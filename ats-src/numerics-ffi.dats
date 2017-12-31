#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/numerics.dats"

extern
fun is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun exp_ats { n : nat | n > 0 } : (int, int(n)) -> int =
  "mac#"

implement is_prime_ats (n) =
  is_prime(n)

implement exp_ats (a, k) =
  exp(a, k)