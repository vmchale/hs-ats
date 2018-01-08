#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/number-theory.dats"

extern
fun totient_ats { k : nat | k >= 2 } (int(k)) : int =
  "mac#"

extern
fun count_divisors_ats { k : nat | k >= 2 } (int(k)) : int =
  "mac#"

extern
fun little_omega_ats { n : nat | n > 0 } : int(n) -> int =
  "mac#"

extern
fun sum_divisors_ats : { n : nat | n >= 1 } int(n) -> int =
  "mac#"

extern
fun is_perfect_ats : intGte(1) -> bool =
  "mac#"

implement sum_divisors_ats (m) =
  sum_divisors(m)

implement count_divisors_ats (n) =
  count_divisors(n)

implement totient_ats (n) =
  totient(n)

implement little_omega_ats (n) =
  little_omega(n)

implement is_perfect_ats (n) =
  is_perfect(n)