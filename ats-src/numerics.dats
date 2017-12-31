#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "libats/libc/SATS/math.sats"

fun exp {n : nat} .<n>. (x : int, n : int(n)) : int =
  case+ x of
    | 0 => 0
    | x => 
      begin
        if n > 0 then
          let
            val n2 = half(n)
            val i2 = n % 2
          in
            if i2 = 0 then
              exp(x * x, n2)
            else
              x * exp(x * x, n2)
          end
        else
          1
      end

fun int_sqrt {n : nat} (n : int(n)) : int =
  let
    var mid = n / 2
    var mid_sq = mid * mid
    
    fun loop(lower : int, upper : int, mid : int, mid_sq : int) : int =
      if lower >= upper - 1 then
        lower
      else
        if mid_sq = n then
          mid_sq
        else
          if mid_sq < n then
            let
              var a = (mid + upper) / 2
            in
              loop(mid, upper, a, a * a)
            end
          else
            let
              var a = (lower + mid) / 2
            in
              loop(lower, mid, a, a * a)
            end
  in
    loop(0, n, mid, mid_sq)
  end

// FIXME wtf
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
          var pre_bound: int = int_sqrt(k)
          var bound: [ m : nat ] int(m) = bad(pre_bound)
          
          fun loop {n : nat}{m : nat} .<max(0,m-n)>. (i : int(n), bound : int(m)) :<> bool =
            if i < bound then
              if k % i = 0 then
                false
              else
                true && loop(i + 1, bound)
            else
              if i = bound then
                if k % i = 0 then
                  false
                else
                  true
              else
                true
        in
          loop(2, bound)
        end
      end