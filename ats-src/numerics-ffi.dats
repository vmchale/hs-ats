#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/numerics.dats"
#include "contrib/atscntrb-hx-intinf/mylibies.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"

extern
fun is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun exp_ats {m : nat} : ([ n : nat ] int(n), int(m)) -> int =
  "mac#"

extern
fun fib_ats : intGte(0) -> Intinf =
  "mac#"

implement is_prime_ats (n) =
  is_prime(n)

implement exp_ats (m, n) =
  exp(m, n)

implement fib_ats (m) =
  fib_gmp(m)