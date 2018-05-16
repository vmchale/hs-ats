/*
**
** The C code is generated by ATS/Anairiats
** The compilation time is: 2018-3-22:  1h:17m
**
*/

/* include some .h files */
#ifndef _ATS_HEADER_NONE
#include "ats_config.h"
#include "ats_basics.h"
#include "ats_types.h"
#include "ats_exception.h"
#include "ats_memory.h"
#endif /* _ATS_HEADER_NONE */

/* include some .cats files */
#ifndef _ATS_PRELUDE_NONE
#include "prelude/CATS/basics.cats"
#include "prelude/CATS/bool.cats"
#include "prelude/CATS/char.cats"
#include "prelude/CATS/byte.cats"
#include "prelude/CATS/float.cats"
#include "prelude/CATS/integer.cats"
#include "prelude/CATS/integer_ptr.cats"
#include "prelude/CATS/integer_fixed.cats"
#include "prelude/CATS/sizetype.cats"
#include "prelude/CATS/pointer.cats"
#include "prelude/CATS/reference.cats"
#include "prelude/CATS/string.cats"
#include "prelude/CATS/lazy.cats"
#include "prelude/CATS/lazy_vt.cats"
#include "prelude/CATS/printf.cats"
#include "prelude/CATS/list.cats"
#include "prelude/CATS/option.cats"
#include "prelude/CATS/array.cats"
#include "prelude/CATS/matrix.cats"
#endif /* _ATS_PRELUDE_NONE */
/* prologues from statically loaded files */
/* external codes at top */
/* type definitions */
typedef
struct {
ats_size_type atslab_sz ;
ats_size_type atslab_tot ;
ats_ptr_type atslab_pbeg ;
ats_clo_ref_type atslab_hash ;
ats_clo_ref_type atslab_eqfn ;
} anairiats_rec_0 ;

/* external typedefs */
typedef anairiats_rec_0 HASHTBL ;

/* external dynamic constructor declarations */
/* external dynamic constant declarations */
ATSextern_fun(ats_double_type, atspre_double_of_size) (ats_size_type) ;
ATSextern_fun(ats_double_type, atspre_mul_int_double) (ats_int_type, ats_double_type) ;
ATSextern_fun(ats_bool_type, atspre_gte_double_double) (ats_double_type, ats_double_type) ;
ATSextern_fun(ats_bool_type, atspre_gt_int_int) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_size_of_int1) (ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_add_size_int) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_sub_size_int) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_add_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_size_type, atspre_sub_size1_int1) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_sub_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_size_type, atspre_mul_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_size_type, atspre_mul2_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_size_type, atspre_mod1_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_bool_type, atspre_gt_size1_int1) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_void_type, atslib_hashtbl_free__linprb) (ats_ptr_type) ;
ATSextern_fun(ats_void_type, atslib_hashtbl_ptr_clear__linprb) (ats_ptr_type, ats_size_type, ats_size_type) ;
ATSextern_fun(ats_ptr_type, atslib_hashtbl_ptr_make__linprb) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_void_type, atslib_hashtbl_ptr_free__linprb) (ats_ptr_type) ;
ATSextern_fun(ats_ptr_type, atslib_hashtbl_make_hint_tsz__linprb) (ats_clo_ref_type, ats_clo_ref_type, ats_size_type, ats_size_type) ;

/* external dynamic terminating constant declarations */
#ifdef _ATS_PROOFCHECK
extern
ats_void_type ATS_2d0_2e2_2e12_2prelude_2SATS_2extern_2esats__minus_addback_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_none_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_some_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_encode_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__hashtbl_v_split_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__hashtbl_v_unsplit_prfck () ;
#endif /* _ATS_PROOFCHECK */

/* assuming abstract types */
/* sum constructor declarations */
/* exn constructor declarations */
/* global dynamic (non-functional) constant declarations */
/* internal function declarations */

/* partial value template declarations */
/* static temporary variable declarations */
/* external value variable declarations */

/* function implementations */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/libats/DATS/hashtable_linprb.dats: 3240(line=104, offs=24) -- 3379(line=108, offs=2)
*/
ATSglobaldec()
ats_size_type
ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_size (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_size_type, tmp0) ;
ATSlocal (ats_ptr_type, tmp1) ;

__ats_lab_ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_size:
tmp1 = ats_selsin_mac(ats_castfn_mac(ats_ptr_type, arg0), atslab_2) ;
tmp0 = ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp1), atslab_sz) ;
return (tmp0) ;
} /* end of [ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_size] */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/libats/DATS/hashtable_linprb.dats: 3442(line=111, offs=25) -- 3584(line=115, offs=2)
*/
ATSglobaldec()
ats_size_type
ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_total (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_size_type, tmp2) ;
ATSlocal (ats_ptr_type, tmp3) ;

__ats_lab_ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_total:
tmp3 = ats_selsin_mac(ats_castfn_mac(ats_ptr_type, arg0), atslab_2) ;
tmp2 = ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp3), atslab_tot) ;
return (tmp2) ;
} /* end of [ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__hashtbl_total] */

/* static load function */

// extern ats_void_type ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__staload (void) ;

ats_void_type
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__staload () {
static int ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__staload_flag = 0 ;
if (ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__staload_flag) return ;
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__staload_flag = 1 ;

// ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__staload () ;

return ;
} /* staload function */

/* dynamic load function */

// dynload flag declaration
// extern ats_int_type ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__dynload_flag ;

ats_void_type
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__dynload () {
// ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__dynload_flag = 1 ;
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__staload () ;

#ifdef _ATS_PROOFCHECK
ATS_2d0_2e2_2e12_2prelude_2SATS_2extern_2esats__minus_addback_prfck () ;
ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_none_prfck () ;
ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_some_prfck () ;
ATS_2d0_2e2_2e12_2libats_2SATS_2hashtable_linprb_2esats__Opt_encode_prfck () ;
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__hashtbl_v_split_prfck () ;
ATS_2d0_2e2_2e12_2libats_2DATS_2hashtable_linprb_2edats__hashtbl_v_unsplit_prfck () ;
#endif /* _ATS_PROOFCHECK */

/* marking static variables for GC */

/* marking external values for GC */

/* code for dynamic loading */
return ;
} /* end of [dynload function] */

/* external codes at mid */
/* external codes at bot */

//
// declared in [string.h]
//
#ifndef memset
extern void *memset (void *buf, int chr, size_t n) ;
#endif
//
ats_ptr_type
atslib_hashtbl_ptr_make__linprb
  (ats_size_type sz, ats_size_type keyitmsz) {
  ats_ptr_type pbeg ;
  /* zeroing the allocated memory is mandatory! */
  pbeg = ATS_CALLOC(sz, keyitmsz) ;
  return pbeg ;
} // end of [atslib_hashtbl_ptr_make__linprb]
//
ats_void_type
atslib_hashtbl_ptr_clear__linprb (
  ats_ptr_type ptbl, ats_size_type sz, ats_size_type keyitmsz
) {
  memset (ptbl, 0, sz * keyitmsz) ; return ;
} // end of [atslib_hashtbl_clear__linprb]
//
ats_void_type
atslib_hashtbl_ptr_free__linprb
  (ats_ptr_type pbeg) { ATS_FREE(pbeg) ; return ; }
// end of [atslib_hashtbl_ptr_free__linprb]
//

//
// HX: shortcuts? yes. worth it? probably.
//
#define HASHTABLE_MINSZ 97 // it is chosen arbitrarily
//
ats_ptr_type
atslib_hashtbl_make_hint_tsz__linprb (
  ats_clo_ref_type hash
, ats_clo_ref_type eqfn
, ats_size_type hint
, ats_size_type keyitmsz
) {
  size_t sz ;
  HASHTBL *ptbl ; void *pbeg ;
  ptbl = ATS_MALLOC(sizeof(HASHTBL)) ;
  sz = (hint > 0 ? hint : HASHTABLE_MINSZ) ;
  /* zeroing the allocated memory is mandatory! */
  pbeg = ATS_CALLOC(sz, keyitmsz) ;
  ptbl->atslab_sz = sz ;
  ptbl->atslab_tot = 0 ;
  ptbl->atslab_pbeg = pbeg ;
  ptbl->atslab_hash = hash ;
  ptbl->atslab_eqfn = eqfn ;
  return ptbl ;
} // end of [atslib_hashtbl_make_hint_tsz__linprb]
//
ats_void_type
atslib_hashtbl_free__linprb (ats_ptr_type ptbl) {
  ATS_FREE(((HASHTBL*)ptbl)->atslab_pbeg) ; ATS_FREE(ptbl) ; return ;
} // end of [atslib_hashtbl_free__linprb]
//
ats_void_type
atslib_hashtbl_free_null__linprb (ats_ptr_type ptbl) { return ; }
// end of [atslib_hashtbl_free_null__linprb]
//
ats_int_type
atslib_hashtbl_free_vt__linprb (ats_ptr_type ptbl) {
  if (((HASHTBL*)ptbl)->atslab_tot != 0) return 1 ;
  ATS_FREE(((HASHTBL*)ptbl)->atslab_pbeg) ; ATS_FREE(ptbl) ; return 0 ;
} // end of [atslib_hashtbl_free_vt__linprb]
//


/* ****** ****** */

/* end of [DATS_hashtable_linprb_dats.c] */
