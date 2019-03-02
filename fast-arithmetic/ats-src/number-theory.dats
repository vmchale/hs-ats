#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"
#include "ats-src/numerics-internal.dats"

staload "ats-src/numerics.sats"
staload "ats-src/number-theory.sats"
staload "prelude/SATS/integer.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"

#define ATS_MAINATSFLAG 1

implement divides (m, n) =
  n % m = 0

implement gcd (m, n) =
  if n > 0 then
    gcd(n, witness(m % n))
  else
    m

implement lcm (m, n) =
  (m / gcd(m, n)) * n

implement coprime (m, n) =
  gcd(m, n) = 1

implement divisors (n) =
  case+ n of
    | 1 => $ldelay(stream_vt_cons(1, $ldelay(stream_vt_nil)))
    | _ => let
      fun loop { k : nat | k > 0 }{ m : nat | m > 0 }(n : int(k), acc : int(m)) : stream_vt(int) =
        if acc >= sqrt_int(n) then
          if n % acc = 0 then
            if n / acc != acc then
              let
                var x: int = n / acc
              in
                $ldelay(stream_vt_cons(acc, $ldelay(stream_vt_cons(x, $ldelay(stream_vt_nil)))))
              end
            else
              let
                
              in
                $ldelay(stream_vt_cons(acc, $ldelay(stream_vt_nil)))
              end
          else
            $ldelay(stream_vt_nil)
        else
          if n % acc = 0 then
            let
              var x: int = n / acc
            in
              $ldelay(stream_vt_cons(acc, $ldelay(stream_vt_cons(x, (loop(n, acc + 1))))))
            end
          else
            loop(n, acc + 1)
    in
      loop(n, 1)
    end

// if n >= 0, p > 1, then n/p >= 0
fn div_gt_zero(n : intGte(0), p : intGt(1)) : intGte(0) =
  $UN.cast(n / p)

// Jacobi symbol for positive integers. See here: http://mathworld.wolfram.com/JacobiSymbol.html
// fails on 7 5
fun jacobi(a : intGte(0), n : Odd) : int =
  let
    // TODO make this take p prime only.
    fun legendre { p : int | p >= 2 }(a : intGte(0), p : int(p)) : intBtwe(~1, 1) =
      case+ p % a of
        | 0 => 0
        | _ => let
          // TODO require that p be prime
          fun exp_mod_prime(a : intGte(0), n : intGte(0), p : intGt(1)) : int =
            let
              var a1 = a % p
              var n1 = n % (p - 1)
            in
              case+ a of
                | 0 => 0
                | x =>> 
                  begin
                    if n > 0 then
                      let
                        var n2: intGte(0) = $UN.cast(half(n1))
                        var i2 = n1 % 2
                        var sq_a: intGte(0) = $UN.cast(a * a % p)
                      in
                        if i2 = 0 then
                          exp_mod_prime(sq_a, n2, p)
                        else
                          let
                            var y = a * exp_mod_prime(sq_a, n2, p)
                          in
                            y
                          end
                      end
                    else
                      1
                  end
            end
          
          var i = exp_mod_prime(a, (p - 1) / 2, p)
        in
          case+ i of
            | i when i % (p - 1) = 0 => ~1
            | i when i % p = 0 => 0
            | _ => 1
        end
    
    fun get_multiplicity(n : intGte(0), p : intGt(1)) : intGte(0) =
      case+ n % p of
        | 0 => 1 + get_multiplicity(div_gt_zero(n, p), p)
        | _ => 0
    
    fun loop { m : int | m > 1 }(acc : int(m)) : int =
      if acc > n then
        1
      else
        if a = 0 then
          0
        else
          if a % acc = 0 && is_prime(acc) then
            loop(acc + 1) * exp(legendre(acc, n), get_multiplicity(a, acc))
          else
            loop(acc + 1)
  in
    loop(2)
  end

// this doesn't actually work but it should be faster once it's done
fun jacobi2 {m:int}{n:int}(a : int(m), n : int(n)) : int =
  case+ a of
    | 0 => 0
    | 1 => 1
    | _ when a > n => jacobi2($UN.cast(a % n), n)
    | _ when a % 2 = 0 => if n % 8 = 1 || n % 8 = ~1 then
      jacobi2(a / 2, n)
    else
      ~jacobi2(a / 2, n)
    | _ when a % 4 = 3 && n % 4 = 3 => jacobi2(n, a)
    | _ => ~jacobi2(n, a)

implement count_divisors_ats (n) =
  stream_vt_length(divisors(n))

implement sum_divisors_ats (n) =
  let
    fun loop { k : nat | k > 0 }{ m : nat | m > 0 }(n : int(k), acc : int(m)) : int =
      if acc >= sqrt_int(n) then
        if n % acc = 0 then
          if n / acc != acc then
            let
              var x: int = n / acc
            in
              acc + x
            end
          else
            acc
        else
          0
      else
        if n % acc = 0 then
          let
            var x: int = n / acc
          in
            acc + x + loop(n, acc + 1)
          end
        else
          loop(n, acc + 1)
  in
    loop(n, 1)
  end

implement is_perfect_ats (n) =
  sum_divisors_ats(n) = n

fun rip { n : nat | n > 0 }{ p : nat | p > 0 } .<n>. (n : int(n), p : int(p)) :<> [ r : nat | r <= n && r > 0 ] int(r) =
  if n % p != 0 then
    n
  else
    if n / p > 0 then
      let
        var n1 = n / p
      in
        if n1 < n then
          rip(n1, p)
        else
          1
      end
    else
      1

implement prime_factors (n) =
  let
    fun loop { k : nat | k > 0 }{ m : nat | m > 0 }(n : int(k), acc : int(m)) : stream_vt(int) =
      if acc >= n then
        if is_prime(n) then
          $ldelay(stream_vt_cons(n, $ldelay(stream_vt_nil)))
        else
          $ldelay(stream_vt_nil)
      else
        if n % acc = 0 && is_prime(acc) then
          if n / acc > 0 then
            $ldelay(stream_vt_cons(acc, loop(rip(n, acc), 1)))
          else
            $ldelay(stream_vt_cons(acc, $ldelay(stream_vt_nil)))
        else
          loop(n, acc + 1)
  in
    loop(n, 1)
  end

implement little_omega_ats (n) =
  let
    fun loop { k : nat | k > 0 }{ m : nat | m > 0 }(n : int(k), acc : int(m)) :<!ntm> int =
      if acc >= n then
        if is_prime(n) then
          1
        else
          0
      else
        if n % acc = 0 && is_prime(acc) then
          if n / acc > 0 then
            1 + loop(rip(n, acc), 1)
          else
            1
        else
          loop(n, acc + 1)
  in
    loop(n, 1)
  end

implement radical_ats (n) =
  case+ n of
    | 1 => 1
    | n =>> let
      var x: stream_vt(int) = prime_factors(n)
      
      fun product(ys : stream_vt(int)) : int =
        case+ !ys of
          | ~stream_vt_cons (z, zs) => z * product(zs)
          | ~stream_vt_nil() => 1
    in
      product(x)
    end

fn totient(n : intGte(1)) : int =
  case+ n of
    | 1 => 1
    | n =>> let
      vtypedef pair = @{ first = int, second = int }
      
      fn adjust_contents(x : pair, y : int) : pair =
        @{ first = g0int_mul(x.first, y - 1), second = g0int_mul(x.second, y) }
      
      var x: stream_vt(int) = prime_factors(n)
      var empty_pair = @{ first = 1, second = 1 } : pair
      var y = stream_vt_foldleft_cloptr(x, empty_pair, lam (acc, next) => adjust_contents(acc, next)) : pair
    in
      g0int_div(g0int_mul(n, y.first), y.second)
    end

implement totient_sum (n) =
  let
    fun loop { n : nat | n >= 1 }{ m : nat | m >= n } .<m-n>. (i : int(n), bound : int(m)) : Intinf =
      if i < bound then
        let
          var x = loop(i + 1, bound)
          var y = add_intinf0_int(x, witness(totient(i)))
        in
          y
        end
      else
        int2intinf(witness(totient(i)))
  in
    loop(1, n)
  end

implement totient_ats (n) =
  totient(n)

implement jacobi_ats (m, n) =
  jacobi(m, $UN.cast(n))
