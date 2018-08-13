#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"
#include "ats-src/combinatorics-internal.dats"

extern
fun choose_ats {n:nat}{ m : nat | m <= n } : (int(n), int(m)) -> Intinf =
  "mac#"

extern
fun double_factorial_ats {n:nat} : int(n) -> Intinf =
  "mac#"

extern
fun factorial_ats {n:nat} : int(n) -> Intinf =
  "mac#"

extern
fun catalan_ats {n:nat} : int(n) -> Intinf =
  "mac#"

extern
fun derangements_ats {n:nat} : int(n) -> Intinf =
  "mac#"

extern
fun permutations_ats {n:nat}{ k : nat | k <= n && k > 0 } : (int(n), int(k)) -> Intinf =
  "mac#"

implement choose_ats (n, k) =
  choose(n, k)

implement double_factorial_ats (m) =
  dfact(m)

implement factorial_ats (m) =
  fact(m)

implement catalan_ats (n) =
  catalan(n)

implement derangements_ats (n) =
  derangements(n)

implement permutations_ats (n, k) =
  permutations(n, k)
