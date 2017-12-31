#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "ats-src/fast-combinatorics.dats"

extern
fun choose_ats {n : nat}{ m : nat | m <= n } : (int(n), int(m)) -> int =
  "mac#"

extern
fun double_factorial {n : nat} : int(n) -> int =
  "mac#"

extern
fun factorial_ats {n : nat} : int(n) -> int =
  "mac#"

extern
fun is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun exp_ats { n : nat | n > 0 } : (int, int(n)) -> int =
  "mac#"

implement choose_ats (n, k) =
  choose(n, k)

implement double_factorial (m) =
  dfact(m)

implement is_prime_ats (n) =
  is_prime(n)

implement factorial_ats (m) =
  fact(m)

implement exp_ats (a, k) =
  exp(a, k)