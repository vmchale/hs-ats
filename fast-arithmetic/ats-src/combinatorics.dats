#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload "ats-src/combinatorics.sats"

// See [here](http://mathworld.wolfram.com/Derangement.html). I'm not sure how
// fast this is, but it *seems* to be faster than the Haskell version so that's
// good.
fn derangements {n:nat} .<n>. (n : int(n)) : Intinf =
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

fun fact_ref {n:nat} .<n>. (k : int(n), ret : &intinfGte(1)? >> intinfGte(1)) : void =
  case+ k of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(1)
    | k =>> let
      val () = fact_ref(k - 1, ret)
    in
      ret := $UN.castvwtp0(mul_intinf0_int(ret, k))
    end

fn fact {n:nat} .<n>. (k : int(n)) : intinfGte(1) =
  let
    var ret: intinfGte(1)
    val () = fact_ref(k, ret)
  in
    ret
  end

// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
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

// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fun dfact {n:nat} .<n>. (k : int(n)) : Intinf =
  let
    var ret: intinfGte(1)
    val () = dfact_ref(k, ret)
  in
    ret
  end

// Number of permutations on n objects using k at a time.
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

// Catalan numbers, indexing starting at zero.
fn catalan {n:nat}(n : int(n)) : Intinf =
  let
    fun numerator_loop { i : nat | i > 1 } .<i>. (i : int(i)) : intinfGt(0) =
      case+ i of
        | 2 => int2intinf(n + 2)
        | i =>> let
          var x = numerator_loop(i - 1)
          var y = mul_intinf0_int(x, n + i)
        in
          $UN.castvwtp0(y)
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
        $UN.castvwtp0(z)
      end
  end

// Number of combinations of n objects using k at a time.
// When k > n, this returns 0.
fn choose {n:nat}{m:nat}(n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m), ret : &intinfGt(0)? >> intinfGt(0)) : void =
      case+ i of
        | 1 => ret := int2intinf(n)
        | 2 => ret := $UN.castvwtp0(int2intinf((n - 1) * n))
        | i =>> let
          val () = numerator_loop(i - 1, ret)
          var y = mul_intinf0_int(ret, n + 1 - i)
        in
          ret := $UN.castvwtp0(y)
        end
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k when k > n => int2intinf(0)
      | k =>> let
        var x: intinfGt(0)
        val () = numerator_loop(k, x)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        $UN.castvwtp0(z)
      end
  end

fn bell {n:nat}(n : int(n)) : intinfGt(0) =
  let
    fun sum_loop { n : nat | n >= 1 }{ m : nat | m >= 1 && m <= n } .<m>. (n : int(n), i : int(m)) : intinfGt(0) =
      case+ i of
        | 0 => int2intinf(1)
        | 1 => if n > 1 then
          int2intinf(n)
        else
          int2intinf(1)
        | i =>> let
          var p = sum_loop(n, i - 1)
          var b = sum_loop(i, i - 1)
          var c = choose(n - 1, i)
          var pre_ret = mul_intinf0_intinf1(c, b)
          var ret = add_intinf0_intinf1(pre_ret, p)
          val _ = intinf_free(b)
          val _ = intinf_free(p)
        in
          $UN.castvwtp0(ret)
        end
  in
    case+ n of
      | 0 => int2intinf(1)
      | 1 => int2intinf(1)
      | m =>> sum_loop(m, m - 1)
  end

fn max_regions {n:nat}(n : int(n)) : Intinf =
  let
    fun loop {m:nat} .<m>. (m : int(m), ret : &Intinf? >> Intinf) : void =
      if m = 0 then
        ret := int2intinf(1)
      else
        let
          val () = loop(m - 1, ret)
          var c = choose(n, m)
          val () = ret := add_intinf0_intinf1(ret, c)
          val () = intinf_free(c)
        in end
    
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

implement max_regions_ats (n) =
  max_regions(n)

implement bell_ats (n) =
  bell(n)
