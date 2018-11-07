staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"

fn bell_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn stirling2_ats { n, m : nat } : (int(n), int(m)) -> Intinf =
  "ext#"

fn choose_ats {n:nat}{ m : nat | m <= n } : (int(n), int(m)) -> Intinf =
  "ext#"

fn double_factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn catalan_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn derangements_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn permutations_ats {n:nat}{ k : nat | k <= n && k > 0 } : (int(n), int(k)) -> Intinf =
  "ext#"

fn max_regions_ats {n:nat} : int(n) -> Intinf =
  "ext#"
