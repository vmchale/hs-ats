#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_t.sats"
staload "libats/libc/SATS/math.sats"
staload "contrib/atscntrb-hx-intinf/SATS/intinf.sats"
staload UN = "prelude/SATS/unsafe.sats"

fnx fact {n : nat} .<n>. (k : int(n)) : [ n : nat | n > 0 ] intinf(n) =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> let
      val x = fact(k - 1) * k
    in
      if compare(x, 0) = 1 then
        x
      else
        int2intinf(1)
    end

// double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fnx dfact {n : nat} .<n>. (k : int(n)) : Intinf =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> k * dfact(k - 2)

// Number of permutations on n objects using k at a time.
fn permutatsions {n : nat}{ k : nat | k <= n } (n : int(n), k : int(k)) : Intinf =
  fact(n) / fact(n - k)

// Number of permutations on n objects using k at a time.
fn choose {n : nat}{ m : nat | m <= n } (n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) : Intinf =
      case+ i of
        | 1 => int2intinf(n)
        | 2 => int2intinf(n - 1) * n
        | i =>> (n + 1 - i) * numerator_loop(i - 1)
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k =>> numerator_loop(k) / fact(k)
  end