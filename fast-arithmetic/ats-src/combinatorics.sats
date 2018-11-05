staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"

fun bell_ats {n:nat} : int(n) -> intinfGt(0) =
  "ext#"

fun choose_ats {n:nat}{ m : nat | m <= n } : (int(n), int(m)) -> Intinf =
  "ext#"

fun double_factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fun factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fun catalan_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fun derangements_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fun permutations_ats {n:nat}{ k : nat | k <= n && k > 0 } : (int(n), int(k)) -> Intinf =
  "ext#"

fun max_regions_ats {n:nat} : int(n) -> Intinf =
  "ext#"
