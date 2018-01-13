#include "share/atspre_staload.hats"
#include "ats-src/numerics.dats"
#include "contrib/atscntrb-hx-intinf/mylibies.hats"

staload "prelude/SATS/integer.sats"
staload UN = "prelude/SATS/unsafe.sats"
staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"

#define ATS_MAINATSFLAG 1

// Existential types for even and odd numbers. These are only usable with the
// ATS library.
typedef Even = [ n : nat ] int(2*n)
typedef Odd = [ n : nat ] int(2*n+1)

// m | n
fn divides(m : int, n : int) :<> bool =
  n % m = 0

fnx gcd {k : nat}{l : nat} (m : int(l), n : int(k)) : int =
  if n > 0 then
    gcd(n, witness(m % n))
  else
    m

fn lcm {k : nat}{l : nat} (m : int(l), n : int(k)) : int =
  (m / gcd(m, n)) * n

// stream all divisors of an integer.
fn divisors(n : intGte(1)) :<> stream_vt(int) =
  let
    fun loop {k : nat}{ m : nat | m > 0 && k >= m } .<k-m>. (n : int(k), acc : int(m)) :<> stream_vt(int) =
      if acc >= n then
        $ldelay(stream_vt_cons(acc, $ldelay(stream_vt_nil)))
      else
        if n % acc = 0 then
          $ldelay(stream_vt_cons(acc, loop(n, acc + 1)))
        else
          loop(n, acc + 1)
  in
    loop(n, 1)
  end

// prime divisors of an integer
fn prime_divisors(n : intGte(1)) : stream_vt(int) =
  stream_vt_filter_cloptr(divisors(n), lam x => is_prime($UN.cast(x)))

// stream_vt_filter_cloptr
typedef gprime(tk : tk, p : int) = { m, n : nat | m < 1 && m <= n && n < p && m*n != p && p > 1 } g1int(tk, p)
typedef prime(p : int) = gprime(int_kind, p)
typedef Prime = [ p : nat ] prime(p)

fn div_gt_zero(n : intGte(0), p : intGt(1)) : intGte(0) =
  $UN.cast(n / p)

// FIXME require that it be prime.
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
                  val y = a * exp_mod_prime(sq_a, n2, p)
                in
                  y
                end
            end
          else
            1
        end
  end

// Jacobi symbol for positive integers. See here: http://mathworld.wolfram.com/JacobiSymbol.html
fun jacobi { n : int | n > 0 } (a : intGte(0), n : int(n)) : int =
  let
    fun legendre { p : int | p >= 2 } (a : intGte(0), p : int(p)) : int =
      case+ p % a of
        | 0 => 0
        | _ => let
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
    
    fun loop { k : nat | k >= 2 }{ m : nat | m > 0 && k >= m } .<k-m>. (n : int(k), acc : int(m)) : int =
      if acc >= n then
        1
      else
        if n % acc = 0 && is_prime(acc) then
          if acc > 1 then
            loop(n, acc + 1) * exp(legendre(acc, n), get_multiplicity(a, acc))
          else
            loop(n, acc + 1)
        else
          loop(n, acc + 1)
  in
    case+ n of
      | 0 => 0
      | 1 => 1
      | n =>> loop(n, 2)
  end

// TODO make this O(√n)
fn count_divisors(n : intGte(1)) : int =
  let
    fun loop {k : nat}{ m : nat | m > 0 && k >= m } .<k-m>. (n : int(k), acc : int(m)) :<> int =
      if acc >= n then
        1
      else
        if n % acc = 0 then
          1 + loop(n, acc + 1)
        else
          loop(n, acc + 1)
  in
    loop(n, 1)
  end

// TODO make this O(√n)
fn sum_divisors(n : intGte(1)) :<> int =
  if n = 1 then
    1
  else
    let
      fun loop {k : nat}{ m : nat | m > 0 && k >= m } .<k-m>. (n : int(k), acc : int(m)) :<> int =
        if acc >= n then
          n
        else
          if n % acc = 0 then
            acc + loop(n, acc + 1)
          else
            loop(n, acc + 1)
    in
      loop(n, 1)
    end

fn is_perfect(n : intGte(1)) :<> bool =
  sum_divisors(n) = n

// distinct prime divisors
fn little_omega(n : intGte(1)) :<!ntm> int =
  let
    fun rip { n : nat | n > 0 }{ p : nat | p > 0 } .<n>. (n : int(n), p : int(p)) :<> [ r : nat | r <= n && r > 0 ] int(r) =
      if n % p != 0 then
        n
      else
        if n / p > 0 then
          let
            var n1 = n / p
          in
            if n1 < n then
              $UN.cast(rip(n1, p))
            else
              1
          end
        else
          1
    
    fun loop { k : nat | k > 0 }{ m : nat | m > 0 } (n : int(k), acc : int(m)) :<!ntm> int =
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

// Euler's totient function.
fn totient(n : intGte(1)) : int =
  case+ n of
    | 1 => 1
    | n =>> 
      begin
        let
          fnx loop { k : nat | k >= 2 }{ m : nat | m > 0 && k >= m } .<k-m>. (i : int(m), n : int(k)) : int =
            if i >= n then
              if is_prime(n) then
                n - 1
              else
                n
            else
              if n % i = 0 && is_prime(i) && i != n then
                (loop(i + 1, n) / i) * (i - 1)
              else
                loop(i + 1, n)
        in
          loop(1, n)
        end
      end

// The sum of all φ(m) for m between 1 and n 
fun totient_sum(n : intGte(1)) : Intinf =
  let
    fnx loop { n : nat | n >= 1 }{ m : nat | m >= n } .<m-n>. (i : int(n), bound : int(m)) : Intinf =
      if i < bound then
        let
          val x = loop(i + 1, bound)
          val y = add_intinf0_int(x, witness(totient(i)))
        in
          y
        end
      else
        int2intinf(witness(totient(i)))
  in
    loop(1, n)
  end

extern
fun chinese_remainder {n : nat} (residues : list_vt(int, n), moduli : list_vt(int, n)) : Option_vt(int)