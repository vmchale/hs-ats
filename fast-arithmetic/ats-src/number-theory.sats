staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "ats-src/numerics.sats"

// m | n
fn divides(m : intGt(0), n : intGte(0)) :<> bool

// Euclid's algorithm
fn gcd {k:nat}{l:nat} (m : int(l), n : int(k)) : int

fn lcm {k:nat}{l:nat} (m : int(l), n : int(k)) : int

// radical of an integer: https://oeis.org/A007947
fn radical_ats { k : nat | k >= 1 }(int(k)) : int =
  "ext#"

// Euler's totient function.
fn totient_ats { k : nat | k >= 2 }(int(k)) : int =
  "ext#"

fn count_divisors_ats { k : nat | k >= 2 }(int(k)) : int =
  "ext#"

// distinct prime divisors
fn little_omega_ats { n : nat | n > 0 } : int(n) -> int =
  "ext#"

// aka σ in number theory
fn sum_divisors_ats : { n : nat | n > 1 } int(n) -> int =
  "ext#"

fn jacobi_ats : (intGte(0), Odd) -> int =
  "ext#"

fn is_perfect_ats : intGt(1) -> bool =
  "ext#"

// The sum of all φ(m) for m between 1 and n. Note the use of refinement types
// to prevent 0 from being passed as an argument. This function is
// slower than it should be, but is included for the sake of ATS programmers.
fn totient_sum : intGte(1) -> Intinf

fn coprime {k:nat}{n:nat} : (int(k), int(n)) -> bool
