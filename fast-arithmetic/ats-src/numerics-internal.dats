#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload "libats/libc/SATS/math.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload "ats-src/numerics.sats"

// TODO: lucas numbers?
// Fast computation of Fibonacci numbers via GMP bindings.
fn fib_gmp(n : uintGte(0)) : Intinf =
  let
    var z = ptr_alloc()
    val () = $GMP.mpz_init(!(z.2))
    val () = $GMP.mpz_fib_uint(!(z.2), n)
  in
    $UN.castvwtp0(z)
  end

// rising pochammer symbol
fun rising_fac_ref {a:nat}{n:nat}(a : int(a), n : int(n), ret : &Intinf? >> Intinf) : void =
  case+ n of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(a)
    | k =>> let
      val () = rising_fac_ref(a + 1, n - 1, ret)
    in
      ret := mul_intinf0_int(ret, a)
    end

fn rising_fac {a:nat}{n:nat}(a : int(a), n : int(n)) : Intinf =
  let
    var ret: intinfGte(0)
    val () = rising_fac_ref(a, n, ret)
  in
    ret
  end

// Fast integer exponentiation. This performs O(log n) multiplications. This
// function is mostly useful for exponentiation in modular arithmetic, as
// it can overflow.
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

// Fast integer exponentiation.
fun big_exp {n:nat} .<n>. (x : Intinf, n : int(n)) : Intinf =
  if compare_intinf_int(x, 0) = 0 then
    x
  else
    if n > 0 then
      let
        var n2 = half(n)
        var i2 = n % 2
      in
        if i2 = 0 then
          let
            var c = square_intinf0(x)
          in
            big_exp(c, n2)
          end
        else
          let
            var c0 = square_intinf1(x)
            var c1 = big_exp(c0, n2)
            var c = mul_intinf0_intinf1(c1, x)
            val () = intinf_free(x)
          in
            c
          end
      end
    else
      (intinf_free(x) ; int2intinf(1))

// square root is bounded for bounded k.
fn sqrt_int(k : intGt(0)) :<> [m:nat] int(m) =
  let
    var bound = g0float2int(sqrt_double(g0int2float_int_double(k)))
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
          fun loop {n:nat}{m:nat} .<max(0,m-n)>. (i : int(n), bound : int(m)) :<> bool =
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

fn is_semiprime(k : intGt(0)) :<> bool =
  case+ k of
    | 1 => false
    | k => 
      begin
        let
          fun loop { n : nat | n > 0 }{m:nat} .<max(0,m-n)>. (i : int(n), bound : int(m)) :<> bool =
            if i < bound then
              if k % i = 0 then
                if is_prime(i) then
                  is_prime($UN.cast(k / i))
                else
                  false
              else
                loop(i + 1, bound)
            else
              if i = bound then
                if k % i = 0 then
                  if is_prime(i) then
                    is_prime($UN.cast(k / i))
                  else
                    false
                else
                  false
              else
                false
        in
          loop(2, sqrt_int(k))
        end
      end
