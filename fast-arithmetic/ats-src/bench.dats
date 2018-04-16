#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "ats-src/combinatorics-internal.dats"
#include "$PATSHOMELOCS/ats-bench-0.2.1/bench.dats"

fun factorial_bench() : void =
  {
    val x = fact(160)
    val _ = intinf_free(x)
  }

fun double_factorial_bench() : void =
  {
    val x = dfact(79)
    val _ = intinf_free(x)
  }

val factorial_delay: io = lam () => factorial_bench()
val double_factorial_delay: io = lam () => double_factorial_bench()

implement main0 () =
  {
    val _ = print_slope("factorial", 12, factorial_delay)
    val _ = print_slope("double factorial", 12, double_factorial_delay)
  }
