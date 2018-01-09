#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "contrib/atscntrb-hx-intinf/mylibies.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload UN = "prelude/SATS/unsafe.sats"

// see [here](http://mathworld.wolfram.com/Derangement.html)
fn derangements {n : nat} .<n>. (n : int(n)) : Intinf =
  let
    fnx loop { n : nat | n > 1 }{ i : nat | i <= n } .<n-i>. (n : int(n), i : int(i), n1 : Intinf, n2 : Intinf) : Intinf =
      if i < n then
        let
          val x = add_intinf0_intinf1(n2, n1)
          val y = mul_intinf0_int(x, i)
        in
          loop(n, i + 1, y, n1)
        end
      else
        let
          val x = add_intinf0_intinf1(n2, n1)
          val _ = intinf_free(n1)
          val y = mul_intinf0_int(x, i)
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

fnx fact {n : nat} .<n>. (k : int(n)) : intinfGte(1) =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> $UN.castvwtp0(mul_intinf0_int(fact(k - 1), k))

// double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fnx dfact {n : nat} .<n>. (k : int(n)) : Intinf =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> let
      val x = dfact(k - 2)
      val y = mul_intinf0_int(x, k)
    in
      y
    end

// Number of permutations on n objects using k at a time.
fn permutations {n : nat}{ k : nat | k <= n } (n : int(n), k : int(k)) : Intinf =
  let
    val x = fact(n)
    val y = fact(n - k)
    val z = div_intinf0_intinf1(x, y)
    val _ = intinf_free(y)
  in
    z
  end

// Number of permutations on n objects using k at a time.
fn choose {n : nat}{ m : nat | m <= n } (n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) : [ n : nat | n > 0 ] intinf(n) =
      case+ i of
        | 1 => int2intinf(n)
        | 2 => $UN.castvwtp0(int2intinf((n - 1) * n))
        | i =>> let
          val x = numerator_loop(i - 1)
          val y = mul_intinf0_int(x, n + 1 - i)
        in
          $UN.castvwtp0(y)
        end
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k =>> let
        val x = numerator_loop(k)
        val y = fact(k)
        val z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        $UN.castvwtp0(z)
      end
  end