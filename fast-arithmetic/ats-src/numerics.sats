// Existential types for even and odd numbers.
typedef Even = [n:nat] int(2*n)
typedef Odd = [n:nat] int(2*n+1)

// Existential types for prime numbers.
typedef gprime(tk: tk, p: int) = { m, n : nat | m < 1 && m <= n && n < p && m*n != p && p > 1 } g1int(tk, p)
typedef prime(p: int) = gprime(int_kind, p)
typedef Prime = [p:nat] prime(p)

castfn witness(n : int) :<> [m:nat] int(m)

fn exp_ats {m:nat} : ([n:nat] int(n), int(m)) -> int =
  "ext#"

fn is_prime_ats { n : nat | n > 0 } : int(n) -> bool =
  "ext#"

fn is_semiprime_ats { n : nat | n > 0 } : int(n) -> bool =
  "ext#"
