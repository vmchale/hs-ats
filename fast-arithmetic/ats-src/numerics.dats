#define ATS_DYNLOADFLAG 0

#include "share/atspre_staload.hats"
#include "ats-src/numerics-internal.dats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "ats-src/numerics.sats"

%{^
#ifndef LIBRARY_BUILD
#define ATS_MEMALLOC_LIBC
#include "ccomp/runtime/pats_ccomp_memalloc_libc.h"
#include "ccomp/runtime/pats_ccomp_runtime_memalloc.c"
#endif
%}

implement is_prime_ats (n) =
  is_prime(n)

implement rising_fac_ats (a, n) =
  rising_fac(a, n)

implement is_semiprime_ats (n) =
  is_semiprime(n)

implement exp_ats (m, n) =
  exp(m, n)
