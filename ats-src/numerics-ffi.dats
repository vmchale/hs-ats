#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/numerics.dats"

extern
fun is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun is_even_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun is_odd_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

implement is_prime_ats (n) =
  is_prime(n)

implement is_even_ats (n) =
  is_even(n)

implement is_odd_ats (n) =
  is_odd(n)