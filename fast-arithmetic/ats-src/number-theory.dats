#include "ats-src/number-theory-internal.dats"

extern
fun totient_ats { k : nat | k >= 2 }(int(k)) : int =
  "mac#"

extern
fun count_divisors_ats { k : nat | k >= 2 }(int(k)) : int =
  "mac#"

extern
fun little_omega_ats { n : nat | n > 0 } : int(n) -> int =
  "mac#"

extern
fun sum_divisors_ats : { n : nat | n > 1 } int(n) -> int =
  "mac#"

extern
fun jacobi_ats : (intGte(0), Odd) -> int =
  "mac#"

extern
fun is_perfect_ats : intGt(1) -> bool =
  "mac#"

extern
fun totient_sum_ats : intGte(1) -> Intinf =
  "mac#"

extern
fun coprime_ats {k:nat}{n:nat} : (int(k), int(n)) -> bool =
  "mac#"

implement sum_divisors_ats (m) =
  sum_divisors(m)

implement count_divisors_ats (n) =
  count_divisors(n)

implement totient_ats (n) =
  totient(n)

implement little_omega_ats (n) =
  little_omega(n)

implement is_perfect_ats (n) =
  is_perfect(n)

implement jacobi_ats (m, n) =
  jacobi(m, $UN.cast(n))

implement totient_sum_ats (n) =
  totient_sum(n)

implement coprime_ats (m, n) =
  is_coprime(m, n)
