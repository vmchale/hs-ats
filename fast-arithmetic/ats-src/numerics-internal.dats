#include "share/atspre_staload.hats"
#include "contrib/atscntrb-hx-intinf/mylibies.hats"
#include "contrib/atscntrb-libgmp/mylibies.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "libats/libc/SATS/math.sats"
staload UN = "prelude/SATS/unsafe.sats"

// Existential types for even and odd numbers. These are only usable with the
// ATS library.
typedef Even = [n:nat] int(2*n)
typedef Odd = [n:nat] int(2*n+1)
typedef gprime(tk: tk, p: int) = { m, n : nat | m < 1 && m <= n && n < p && m*n != p && p > 1 } g1int(tk, p)
typedef prime(p: int) = gprime(int_kind, p)
typedef Prime = [p:nat] prime(p)

fn witness(n : int) :<> [m:nat] int(m) =
  $UN.cast(n)

// Fast computation of Fibonacci numbers via GMP bindings.
fun fib_gmp(n : intGte(0)) : Intinf =
  let
    var z = ptr_alloc()
    var x = g0int2uint(n + 1)
    val () = $GMP.mpz_init(!(z.2))
    val () = $GMP.mpz_fib_uint(!(z.2), x)
  in
    $UN.castvwtp0(z)
  end

// Fast integer exponentiation.
fun exp {n:nat} .<n>. (x : int, n : int(n)) : int =
  case+ x of
    | 0 => 0
    | x =>> 
      begin
        if n > 0 then
          let
            var n2 = half(n)
            var i2 = n % 2
          in
            if i2 = 0 then
              exp(x * x, n2)
            else
              let
                var y = x * exp(x * x, n2)
              in
                y
              end
          end
        else
          1
      end

fn sqrt_int(k : intGt(0)) :<> [m:nat] int(m) =
  let
    var bound: int = g0float2int(sqrt_float(g0int2float(k)))
  in
    witness(bound)
  end

// function to check primality
fn is_prime(k : intGt(0)) :<> bool =
  case+ k of
    | 1 => false
    | k => 
      begin
        let
          fnx loop {n:nat}{m:nat} .<max(0,m-n)>. (i : int(n), bound : int(m)) :<> bool =
            if i < bound then
              if k % i = 0 then
                false
              else
                loop(i + 1, bound)
            else
              if i = bound then
                if k % i = 0 then
                  false
                else
                  true
              else
                true
        in
          loop(2, sqrt_int(k))
        end
      end
