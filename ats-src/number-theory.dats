#include "share/atspre_staload.hats"
#include "ats-src/numerics.dats"

staload "libats/libc/SATS/math.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define ATS_MAINATSFLAG 1

// Existential types for even and odd numbers. These are only usable with the
// ATS library.
typedef Even = [ n : nat ] int(2 * n)

typedef Odd = [ n : nat ] int(2 * n+1)

// m | n
fn divides(m : int, n : int) :<> bool =
  n % m = 0

// totien sum http://mathworld.wolfram.com/TotientSummatoryFunction.html
// fn totient_sum(n: int) : int =
fn count_divisors { k : nat | k >= 1 } (n : int(k)) :<> int =
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

// Euler's totient function.
fn totient { k : nat | k >= 1 } (n : int(k)) : int =
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

// TODO gcd
fun totient_sum { k : nat | k >= 1 } (n : int(k)) : int =
  let
    fnx loop { n : nat | n >= 1 }{ m : nat | m >= n } .<m-n>. (i : int(n), bound : int(m)) : int =
      if i < bound then
        totient(i) + loop(i + 1, bound)
      else
        totient(i)
  in
    loop(1, n)
  end

fn is_even(n : int) :<> bool =
  n % 2 = 0

fn is_odd(n : int) :<> bool =
  n % 2 = 1