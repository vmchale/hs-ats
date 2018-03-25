#define ATS_DYNLOADFLAG 0

#include "share/atspre_staload.hats"
#include "ats-src/numerics-internal.dats"
#include "$PATSHOMELOCS/atscntrb-libgmp/mylibies.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "contrib/atscntrb-libgmp/SATS/gmp.sats"

extern
fun mpz_free : (&mpz >> mpz?) -> void =
  "mac#"

extern
fun is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "mac#"

extern
fun exp_ats {m:nat} : ([n:nat] int(n), int(m)) -> int =
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

implement mpz_free (x) =
  mpz_clear(x)