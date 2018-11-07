#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "ats-src/combinatorics.dats"
#include "$PATSHOMELOCS/ats-bench-0.3.3/bench.dats"

fn factorial_bench() : void =
  {
    val x = fact(160)
    val () = intinf_free(x)
  }

fn double_factorial_bench() : void =
  {
    val x = dfact(79)
    val () = intinf_free(x)
  }

fn choose_bench() : void =
  {
    val x = choose(322, 16)
    val () = intinf_free(x)
  }

fn catalan_bench() : void =
  {
    val x = catalan(300)
    val () = intinf_free(x)
  }

fn permutations_bench() : void =
  {
    val x = permutations(20, 10)
    val () = intinf_free(x)
  }

fn bell_bench() : void =
  {
    val x = bell(10)
    val () = intinf_free(x)
  }

fn derangement_bench() : void =
  {
    val x = derangements(35)
    val () = intinf_free(x)
  }

val factorial_delay: io = lam () => factorial_bench()
val double_factorial_delay: io = lam () => double_factorial_bench()
val choose_delay: io = lam () => double_factorial_bench()
val catalan_delay: io = lam () => catalan_bench()
val permutations_delay: io = lam () => permutations_bench()
val bell_delay: io = lam () => bell_bench()
val derangement_delay: io = lam () => derangement_bench()

implement main0 () =
  {
    // FIXME - for some reason this is negative
    // val k = max_regions(46342) 
    // val () = println!(k)
    // val () = intinf_free(k)
    val () = print_slope("factorial", 12, factorial_delay)
    val () = print_slope("double factorial", 12, double_factorial_delay)
    val () = print_slope("choose", 13, choose_delay)
    val () = print_slope("catalan", 9, catalan_delay)
    val () = print_slope("permutations", 13, permutations_delay)
    val () = print_slope("bell", 8, bell_delay)
    val () = print_slope("derangements", 12, derangement_delay)
  }
