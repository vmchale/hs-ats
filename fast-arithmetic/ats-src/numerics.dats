#define ATS_DYNLOADFLAG 0

#include "share/atspre_staload.hats"
#include "ats-src/numerics-internal.dats"
#include "$PATSHOMELOCS/atscntrb-hx-libgmp/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "$PATSHOMELOCS/atscntrb-hx-libgmp/SATS/gmp.sats"

%{^
#define ATS_MEMALLOC_LIBC
#include "ccomp/runtime/pats_ccomp_memalloc_libc.h"
#include "ccomp/runtime/pats_ccomp_runtime_memalloc.c"
%}

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

// implement fib_ats (m) =
//   fib_gmp(m)
implement mpz_free (x) =
  mpz_clear(x)
