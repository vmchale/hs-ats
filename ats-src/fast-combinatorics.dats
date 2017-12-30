#define ATS_MAINATSFLAG 1

#include "share/atspre_staload.hats"

staload "contrib/atscntrb-hx-intinf/SATS/intinf_t.sats"
staload "contrib/atscntrb-hx-intinf/SATS/intinf_vt.sats"

//fun fact_gmp{m:nat} .<m>. (k: !intinf(m)) : Intinf =
//  if k = 0
//    then (intinf_make_int(1))
//    else let
//      var y = k - 1
//      var z = fact_gmp(y)
//      var q = y * k
//      val _ = intinf_free(y)
//      val _ = intinf_free(z)
//      in q
//      end

fnx fact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | k =>> fact(k - 1) * k

fnx dfact {n : nat} .<n>. (k : int(n)) :<> int =
  case+ k of
    | 0 => 1
    | 1 => 1
    | k =>> k * dfact(k - 2)

fn choose {n : nat}{m : nat} (n : int(n), k : int(m)) : int =
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

extern
fun choose_ats {n : nat}{m : nat} : (int(n), int(m)) -> int =
  "mac#"

implement choose_ats (n, k) =
  choose(n, k)

extern
fun factorial_ats {n : nat} : int(n) -> int =
  "mac#"

implement factorial_ats (m) =
  fact(m)
