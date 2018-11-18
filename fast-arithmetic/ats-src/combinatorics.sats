staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"

// Bell numbers. See http://mathworld.wolfram.com/BellNumber.html
fn bell_ats {n:nat} : int(n) -> Intinf =
  "ext#"

// Stirling numbers of the second kind. See
// http://mathworld.wolfram.com/StirlingNumberoftheSecondKind.html
fn stirling2_ats { n, m : nat } : (int(n), int(m)) -> Intinf =
  "ext#"

// Number of combinations of n objects using k at a time.
// When k > n, this returns 0.
fn choose_ats {n:nat}{ m : nat | m <= n } : (int(n), int(m)) -> Intinf =
  "ext#"

// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fn double_factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

fn factorial_ats {n:nat} : int(n) -> Intinf =
  "ext#"

// Catalan numbers, indexing starting at zero.
fn catalan_ats {n:nat} : int(n) -> Intinf =
  "ext#"

// See [here](http://mathworld.wolfram.com/Derangement.html).
fn derangements_ats {n:nat} : int(n) -> Intinf =
  "ext#"

// Number of permutations on n objects using k at a time.
fn permutations_ats {n:nat}{ k : nat | k <= n && k > 0 } : (int(n), int(k)) -> Intinf =
  "ext#"

fn max_regions_ats {n:nat} : int(n) -> Intinf =
  "ext#"
