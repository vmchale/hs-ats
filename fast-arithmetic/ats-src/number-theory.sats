staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "ats-src/numerics.sats"

fun totient_ats { k : nat | k >= 2 }(int(k)) : int =
  "ext#"

fun count_divisors_ats { k : nat | k >= 2 }(int(k)) : int =
  "ext#"

fun little_omega_ats { n : nat | n > 0 } : int(n) -> int =
  "ext#"

fun sum_divisors_ats : { n : nat | n > 1 } int(n) -> int =
  "ext#"

fun jacobi_ats : (intGte(0), Odd) -> int =
  "ext#"

fun is_perfect_ats : intGt(1) -> bool =
  "ext#"

fun totient_sum_ats : intGte(1) -> Intinf =
  "ext#"

fun coprime_ats {k:nat}{n:nat} : (int(k), int(n)) -> bool =
  "ext#"
