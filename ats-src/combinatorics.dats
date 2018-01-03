#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "libats/libc/SATS/math.sats"

fnx fact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | k =>> fact(k - 1) * k

// double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fnx dfact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | 1 => 1
    | k =>> k * dfact(k - 2)

// Number of permutations on n objects using k at a time.
fn permutatsions {n : nat}{ k : nat | k <= n } (n : int(n), k : int(k)) :<> int =
  fact(n) / fact(n - k)

// Number of permutations on n objects using k at a time.
fn choose {n : nat}{ m : nat | m <= n } (n : int(n), k : int(m)) :<> int =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) :<> int =
      case+ i of
        | 1 => n
        | 2 => (n - 1) * n
        | i =>> (n + 1 - i) * numerator_loop(i - 1)
  in
    case+ k of
      | 0 => 1
      | 1 => n
      | k =>> numerator_loop(k) / fact(k)
  end