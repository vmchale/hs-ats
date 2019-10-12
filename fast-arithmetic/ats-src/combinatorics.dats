#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload "ats-src/combinatorics.sats"

fn derangements {n:nat}(n : int(n)) : Intinf =
  let
    fun loop { n : nat | n > 1 }{ i : nat | i <= n } .<n-i>. (n : int(n), i : int(i), n1 : Intinf, n2 : Intinf) : Intinf =
      if i < n then
        let
          var x = add_intinf0_intinf1(n2, n1)
          var y = mul_intinf0_int(x, i)
        in
          loop(n, i + 1, y, n1)
        end
      else
        let
          var x = add_intinf0_intinf1(n2, n1)
          val _ = intinf_free(n1)
          var y = mul_intinf0_int(x, i)
        in
          y
        end
  in
    case+ n of
      | 0 => int2intinf(1)
      | 1 =>> int2intinf(0)
      | 2 =>> int2intinf(1)
      | n =>> loop(n - 1, 2, int2intinf(1), int2intinf(0))
  end

fun fact_ref {n:nat} .<n>. (k : int(n), ret : &Intinf? >> Intinf) : void =
  case+ k of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(1)
    | k =>> let
      val () = fact_ref(k - 1, ret)
    in
      ret := mul_intinf0_int(ret, k)
    end

fn fact {n:nat}(k : int(n)) : Intinf =
  let
    var ret: intinfGte(1)
    val () = fact_ref(k, ret)
  in
    ret
  end

fun dfact_ref {n:nat} .<n>. (k : int(n), ret : &Intinf? >> Intinf) : void =
  case+ k of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(1)
    | k =>> let
      val () = dfact_ref(k - 2, ret)
      var y = mul_intinf0_int(ret, k)
    in
      ret := y
    end

fun dfact {n:nat} .<n>. (k : int(n)) : Intinf =
  let
    var ret: intinfGte(1)
    val () = dfact_ref(k, ret)
  in
    ret
  end

fn permutations {n:nat}{ k : nat | k <= n && k > 0 }(n : int(n), k : int(k)) : Intinf =
  let
    fun loop { i : nat | i >= n-k+1 } .<i>. (i : int(i), ret : &Intinf? >> Intinf) : void =
      if i > n - k + 1 then
        (loop(i - 1, ret) ; ret := mul_intinf0_int(ret, i))
      else
        ret := int2intinf(n - k + 1)
    
    var ret: Intinf
    val () = loop(n, ret)
  in
    ret
  end

fn catalan {n:nat}(n : int(n)) : Intinf =
  let
    fun numerator_loop { i : nat | i > 1 } .<i>. (i : int(i)) : Intinf =
      case+ i of
        | 2 => int2intinf(n + 2)
        | i =>> let
          var x = numerator_loop(i - 1)
          var y = mul_intinf0_int(x, n + i)
        in
          y
        end
  in
    case+ n of
      | 0 => int2intinf(1)
      | 1 => int2intinf(1)
      | k =>> let
        var x = numerator_loop(k)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        z
      end
  end

fn choose {n:nat}{m:nat}(n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m), ret : &Intinf? >> Intinf) : void =
      case+ i of
        | 1 => ret := int2intinf(n)
        | 2 => ret := int2intinf((n - 1) * n)
        | i =>> let
          val () = numerator_loop(i - 1, ret)
          var y = mul_intinf0_int(ret, n + 1 - i)
        in
          ret := y
        end
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k when k > n => int2intinf(0)
      | k =>> let
        var x: Intinf
        val () = numerator_loop(k, x)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        z
      end
  end

fn stirling2 { n, k : nat }(n : int(n), k : int(k)) : Intinf =
  ifcase
    | k = 0 && n = 0 => int2intinf(1)
    | k > n => int2intinf(0)
    | _ => let
      fun top_loop {i:nat} .<i>. (i : int(i), acc : &Intinf? >> Intinf) : void =
        case+ i of
          | 0 => acc := int2intinf(0)
          | i =>> {
            fn negate_if_odd(n : int, k : Intinf) : Intinf =
              if n % 2 = 0 then
                k
              else
                neg_intinf0(k)
            
            val () = top_loop(i - 1, acc)
            var add = choose(k, i)
            var factor = pow_int_int(i, n)
            var multiplier = negate_if_odd(k - i, factor)
            var factor_add = mul_intinf0_intinf1(add, multiplier)
            val () = acc := add_intinf0_intinf1(acc, factor_add)
            val () = intinf_free(multiplier)
            val () = intinf_free(factor_add)
          }
      
      var top: Intinf
      val () = top_loop(k, top)
      var bot = fact(k)
      var result = div_intinf0_intinf1(top, bot)
      val () = intinf_free(bot)
    in
      result
    end

fn bell {n:nat}(n : int(n)) : Intinf =
  let
    fun sum_loop { k : nat | k >= 1 } .<k>. (k : int(k), acc : &Intinf? >> Intinf) : void =
      case+ k of
        | 1 => acc := stirling2(n, 1)
        | k =>> {
          val () = sum_loop(k - 1, acc)
          var add = stirling2(n, k)
          val () = acc := add_intinf0_intinf1(acc, add)
          val () = intinf_free(add)
        }
  in
    case+ n of
      | 0 => int2intinf(1)
      | n =>> let
        var ret: Intinf
        val () = sum_loop(n, ret)
      in
        ret
      end
  end

fn max_regions {n:nat}(n : int(n)) : Intinf =
  let
    fun loop {m:nat} .<m>. (m : int(m), ret : &Intinf? >> Intinf) : void =
      case+ m of
        | 0 => ret := int2intinf(1)
        | _ =>> {
          val () = loop(m - 1, ret)
          var c = choose(n, m)
          val () = ret := add_intinf0_intinf1(ret, c)
          val () = intinf_free(c)
        }
    
    var x: Intinf
    val () = loop(4, x)
  in
    x
  end

implement choose_ats (n, k) =
  choose(n, k)

implement double_factorial_ats (m) =
  dfact(m)

implement factorial_ats (m) =
  fact(m)

implement catalan_ats (n) =
  catalan(n)

implement derangements_ats (n) =
  derangements(n)

implement permutations_ats (n, k) =
  permutations(n, k)

implement stirling2_ats (n, k) =
  stirling2(n, k)

implement max_regions_ats (n) =
  max_regions(n)

implement bell_ats (n) =
  bell(n)
