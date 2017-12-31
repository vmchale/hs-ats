#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "libats/libc/SATS/math.sats"

fnx fact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | k =>> fact(k - 1) * k

fnx dfact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | 1 => 1
    | k =>> k * dfact(k - 2)

fun exp {n : nat} .<n>. (x : int, n : int(n)) : int =
  if n > 0 then
    let
      val n2 = half(n)
      val i2 = n - (2 * n2)
    in
      if i2 > 0 then
        exp(x * x, n2)
      else
        x * exp(x * x, n2)
    end
  else
    1

// TODO make this more versatile?
fn choose {n : nat}{ m : nat | m <= n } (n : int(n), k : int(m)) : int =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) : int =
      case+ i of
        | 1 => n
        | 2 => (n - 1) * n
        | i =>> (n + 1 - i) * numerator_loop(i - 1)
  in
    case+ k of
      | 0 => 1
      | 1 => n
      | k =>> numerator_loop(k) / fact(k)
  end

// FIXME
fun bad(n : int) : [ m : nat ] int(m) =
  case+ n of
    | 0 => 0
    | n => 1 + bad(n - 1)

fun is_prime(k : intGt(0)) : bool =
  case+ k of
    | 1 => false
    | k => 
      begin
        let
          var pre_bound: int = g0float2int(sqrt_float(g0int2float_int_float(k)))
          var bound: [ m : nat ] int(m) = bad(pre_bound)
          
          fun loop {n : nat}{m : nat} .<max(0,m-n)>. (i : int(n), bound : int(m)) :<> bool =
            if i < bound then
              if k mod i = 0 then
                false
              else
                true && loop(i + 1, bound)
            else
              if i = bound then
                if k mod i = 0 then
                  false
                else
                  true
              else
                true
        in
          loop(2, bound)
        end
      end