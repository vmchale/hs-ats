#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/combinatorics.dats"

extern
fun choose_ats {n : nat}{ m : nat | m <= n } : (int(n), int(m)) -> Intinf =
  "mac#"

extern
fun double_factorial {n : nat} : int(n) -> Intinf =
  "mac#"

extern
fun factorial_ats {n : nat} : int(n) -> Intinf =
  "mac#"

implement choose_ats (n, k) =
  choose(n, k)

implement double_factorial (m) =
  dfact(m)

implement factorial_ats (m) =
  fact(m)