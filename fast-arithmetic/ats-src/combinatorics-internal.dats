#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload UN = "prelude/SATS/unsafe.sats"

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

fun fact {n:nat} .<n>. (k : int(n)) : intinfGte(1) =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> $UN.castvwtp0(mul_intinf0_int(fact(k - 1), k))

// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fun dfact {n:nat} .<n>. (k : int(n)) : Intinf =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> let
      var x = dfact(k - 2)
      var y = mul_intinf0_int(x, k)
    in
      y
    end

// Number of permutations on n objects using k at a time.
fn permutations {n:nat}{ k : nat | k <= n }(n : int(n), k : int(k)) : Intinf =
  let
    var x = fact(n)
    var y = fact(n - k)
    var z = div_intinf0_intinf1(x, y)
    val _ = intinf_free(y)
  in
    z
  end

// Catalan numbers, indexing starting at zero.
fn catalan {n:nat}(n : int(n)) : Intinf =
  let
    fun numerator_loop { i : nat | i > 1 } .<i>. (i : int(i)) : [ n : nat | n > 0 ] intinf(n) =
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

// Number of permutations on n objects using k at a time.
fn choose {n:nat}{ m : nat | m <= n }(n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) : [ n : nat | n > 0 ] intinf(n) =
      case+ i of
        | 1 => int2intinf(n)
        | 2 => $UN.castvwtp0(int2intinf((n - 1) * n))
        | i =>> let
          var x = numerator_loop(i - 1)
          var y = mul_intinf0_int(x, n + 1 - i)
        in
          $UN.castvwtp0(y)
        end
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k =>> let
        var x = numerator_loop(k)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        $UN.castvwtp0(z)
      end
  end

// Bell numbers. These can't be called via the FFI because of the mutually
// recursive functions here.
fnx bell {n:nat}(n : int(n)) : [ n : nat | n > 0 ] intinf(n) =
  case- n of
    | 0 => int2intinf(1)
    | n when n >= 0 =>> sum_loop(n, n)
and sum_loop {n:nat}{ m : nat | m >= 1 && m <= n } .<m>. (n : int(n), i : int(m)) : [ n : nat | n > 0 ] intinf(n) =
  case+ i of
    | 1 => int2intinf(1)
    | i =>> let
      var p = sum_loop(n, i - 1)
      var b = bell(i)
      var c = choose(n, i)
      var pre_ret = mul_intinf0_intinf1(c, b)
      var ret = add_intinf0_intinf1(pre_ret, p)
      val _ = intinf_free(b)
      val _ = intinf_free(p)
    in
      $UN.castvwtp0(ret)
    end
