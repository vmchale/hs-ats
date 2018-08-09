#include "share/atspre_staload.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mydepies.hats"
#include "$PATSHOMELOCS/atscntrb-hx-intinf/mylibies.hats"

staload "$PATSHOMELOCS/atscntrb-hx-intinf/SATS/intinf_vt.sats"
staload UN = "prelude/SATS/unsafe.sats"

infixr (->) ->>

stadef ->> (b1: bool, b2: bool) = ~b1 || b2

// See [here](http://mathworld.wolfram.com/Derangement.html). I'm not sure how
// fast this is, but it *seems* to be faster than the Haskell version so that's
// good.
fn derangements {n:nat} .<n>. (n : int(n)) : Intinf =
  let
    fun loop { n : nat | n > 1 }{ i : nat | i <= n } .<n-i>. (n : int(n), i : int(i), n1 : Intinf, n2 : Intinf) : Intinf =
      if i < n then
        let
          var x = add_intinf0_intinf1(n2, n1)
          var y = mul_intinf0_int(x, i)
        in
          loop(n, i + 1, y, n1)
        end
      else
        let
          var x = add_intinf0_intinf1(n2, n1)
          val _ = intinf_free(n1)
          var y = mul_intinf0_int(x, i)
        in
          y
        end
  in
    case+ n of
      | 0 => int2intinf(1)
      | 1 =>> int2intinf(0)
      | 2 =>> int2intinf(1)
      | n =>> loop(n - 1, 2, int2intinf(1), int2intinf(0))
  end

dataprop fact_p(int, int) =
  | fact_p_base(0, 1) of ()
  | {n:nat}{r:int}{rn:int} fact_p_ind(n + 1, rn) of (fact_p(n, r), MUL(r, n + 1, rn))

stacst fact_b : (int, int) -> bool

stacst mul_b : (int, int, int) -> bool

extern
praxi fact_b_base : [fact_b(0,1)] unit_p

extern
praxi mul_b_base0 {n:int} : [mul_b(n,1,n)] unit_p

extern
praxi mul_b_base1 {n:int} : [mul_b(1,n,n)] unit_p

extern
praxi mul_b_ind0 {n:int}{m:int}{nm:int} : [mul_b(n,m,nm) ->> mul_b(n+1,m,m+nm)] unit_p

// I have no idea how to actually use this proof
// I think I need a proof-level function??
extern
praxi mul_b_ind1 {n:int}{m:int}{nm:int} : [mul_b(n,m,nm) ->> mul_b(n,m+1,n+nm)] unit_p

extern
praxi fact_b_ind {n:nat}{r:int}{rn:int} : [fact_b(n,r) && mul_b(r,n+1,rn) ->> fact_b(n+1,rn)] unit_p

extern
fun fact_v {n:nat} (n : int(n)) : [r:int] (fact_p(n, r) | intinf(r))

extern
fun imul {m:int}{n:int}{o:int} (x : int(m), y : int(m)) : (MUL(m, n, o) | int(o))

(*fun fact_ref {n:nat} .<n>. (k : int(n), ret : &intinfGte(1)? >> intinfGte(1)) : void =
  case+ k of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(1)
    | k =>> let
      val () = fact_ref(k - 1, ret)
    in
      ret := $UN.castvwtp0(mul_intinf0_int(ret, k))
    end*)
// the fancy proof stuff isn't that useful, but it gets us a tail-recursive (?)
// implementation which might be good (?)
// TODO - imul_intinf0_int function
fun fact {n:nat} .<n>. (k : int(n)) : intinfGte(1) =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> $UN.castvwtp0(mul_intinf0_int(fact(k - 1), k))

// TODO: figure out why this crashes clang on mac
(*fn fact_fast {n:nat} .<n>. (k : int(n)) : intinfGte(1) =
  let
    var ret: intinfGte(1)
    val () = fact_ref(k, ret)
  in
    ret
  end*)
// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fun dfact_ref {n:nat} .<n>. (k : int(n), ret : &Intinf? >> Intinf) : void =
  case+ k of
    | 0 => ret := int2intinf(1)
    | 1 => ret := int2intinf(1)
    | k =>> let
      val () = dfact_ref(k - 2, ret)
      var y = mul_intinf0_int(ret, k)
    in
      ret := y
    end

// Double factorial http://mathworld.wolfram.com/DoubleFactorial.html
fun dfact {n:nat} .<n>. (k : int(n)) : Intinf =
  case+ k of
    | 0 => int2intinf(1)
    | 1 => int2intinf(1)
    | k =>> let
      var x = dfact(k - 2)
      var y = mul_intinf0_int(x, k)
    in
      y
    end

// Number of permutations on n objects using k at a time.
fn permutations {n:nat}{ k : nat | k <= n }(n : int(n), k : int(k)) : Intinf =
  let
    // n * (n - 1) * ... * (n - k + 1)
    var x = fact(n)
    var y = fact(n - k)
    var z = div_intinf0_intinf1(x, y)
    val _ = intinf_free(y)
  in
    z
  end

// Catalan numbers, indexing starting at zero.
fn catalan {n:nat}(n : int(n)) : Intinf =
  let
    fun numerator_loop { i : nat | i > 1 } .<i>. (i : int(i)) : intinfGt(0) =
      case+ i of
        | 2 => int2intinf(n + 2)
        | i =>> let
          var x = numerator_loop(i - 1)
          var y = mul_intinf0_int(x, n + i)
        in
          $UN.castvwtp0(y)
        end
  in
    case+ n of
      | 0 => int2intinf(1)
      | 1 => int2intinf(1)
      | k =>> let
        var x = numerator_loop(k)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        $UN.castvwtp0(z)
      end
  end

// Number of permutations on n objects using k at a time.
fn choose {n:nat}{ m : nat | m <= n }(n : int(n), k : int(m)) : Intinf =
  let
    fun numerator_loop { m : nat | m > 1 } .<m>. (i : int(m)) : intinfGt(0) =
      case+ i of
        | 1 => int2intinf(n)
        | 2 => $UN.castvwtp0(int2intinf((n - 1) * n))
        | i =>> let
          var x = numerator_loop(i - 1)
          var y = mul_intinf0_int(x, n + 1 - i)
        in
          $UN.castvwtp0(y)
        end
  in
    case+ k of
      | 0 => int2intinf(1)
      | 1 => int2intinf(n)
      | k =>> let
        var x = numerator_loop(k)
        var y = fact(k)
        var z = div_intinf0_intinf1(x, y)
        val _ = intinf_free(y)
      in
        $UN.castvwtp0(z)
      end
  end

// TODO stirling numbers of the second kind.
// Bell numbers. These can't be called via the FFI because of the mutually
// recursive functions, so we should probably think of something else.
fun bell {n:nat}(n : int(n)) : intinfGt(0) =
  case- n of
    | 0 => int2intinf(1)
    | n when n >= 0 =>> sum_loop(n, n)

and sum_loop {n:nat}{ m : nat | m >= 1 && m <= n } .<m>. (n : int(n), i : int(m)) : intinfGt(0) =
  case+ i of
    | 1 => int2intinf(1)
    | i =>> let
      var p = sum_loop(n, i - 1)
      var b = bell(i)
      var c = choose(n, i)
      var pre_ret = mul_intinf0_intinf1(c, b)
      var ret = add_intinf0_intinf1(pre_ret, p)
      val _ = intinf_free(b)
      val _ = intinf_free(p)
    in
      $UN.castvwtp0(ret)
    end
