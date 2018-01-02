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
fun totient_sum_ats { n : nat | n > 0 } : int(n) -> int =
  "mac#"

implement count_divisors_ats (n) =
  count_divisors(n)

implement totient_ats (n) =
  totient(n)

implement totient_sum_ats (n) =
  totient_sum(n)