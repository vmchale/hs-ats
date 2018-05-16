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
ats_ptr_type atslab_2 ;
ats_size_type atslab_3 ;
} anairiats_rec_0 ;

/* external typedefs */
/* external dynamic constructor declarations */
/* external dynamic constant declarations */
ATSextern_fun(ats_bool_type, atspre_igte) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_size1_of_int1) (ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_add_size1_int1) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_size_type, atspre_sub_size1_int1) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_bool_type, atspre_lt_size1_size1) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_bool_type, atspre_gt_size1_int1) (ats_size_type, ats_int_type) ;
ATSextern_fun(ats_ptr_type, atspre_ref_make_elt_tsz) (ats_ref_type, ats_size_type) ;
ATSextern_fun(ats_ptr_type, atspre_array_ptr_alloc_tsz) (ats_size_type, ats_size_type) ;
ATSextern_fun(ats_void_type, atspre_array_ptr_initialize_elt_tsz) (ats_ref_type, ats_size_type, ats_ref_type, ats_size_type) ;
ATSextern_fun(ats_ptr_type, ArraySubscriptException_make) () ;
ATSextern_fun(ats_ptr_type, ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_make_arrpsz) (anairiats_rec_0) ;

/* external dynamic terminating constant declarations */
#ifdef _ATS_PROOFCHECK
#endif /* _ATS_PROOFCHECK */

/* assuming abstract types */
int ATS_2d0_2e2_2e12_2prelude_2basics_sta_2esats__sasp__array0_viewt0ype_type = 0 ;

/* sum constructor declarations */
/* exn constructor declarations */
/* global dynamic (non-functional) constant declarations */
/* internal function declarations */
static
ats_ptr_type ref_01088_anairiats_rec_0 (anairiats_rec_0 arg0) ;
static
ats_ptr_type ref_make_elt_01089_anairiats_rec_0 (anairiats_rec_0 arg0) ;

/* partial value template declarations */
/* static temporary variable declarations */
/* external value variable declarations */

/* function implementations */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/prelude/DATS/reference.dats: 1828(line=57, offs=18) -- 1902(line=59, offs=4)
*/
ATSstaticdec()
ats_ptr_type
ref_01088_anairiats_rec_0 (anairiats_rec_0 arg0) {
/* local vardec */
ATSlocal (ats_ptr_type, tmp2) ;
ATSlocal (anairiats_rec_0, tmp3) ;

__ats_lab_ref_01088_anairiats_rec_0:
/* anairiats_rec_0 tmp3 ; */
tmp3 = arg0 ;
tmp2 = atspre_ref_make_elt_tsz ((&tmp3), sizeof(anairiats_rec_0)) ;
return (tmp2) ;
} /* end of [ref_01088_anairiats_rec_0] */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/prelude/DATS/reference.dats: 1994(line=62, offs=27) -- 2009(line=62, offs=42)
*/
ATSstaticdec()
ats_ptr_type
ref_make_elt_01089_anairiats_rec_0 (anairiats_rec_0 arg0) {
/* local vardec */
ATSlocal (ats_ptr_type, tmp1) ;

__ats_lab_ref_make_elt_01089_anairiats_rec_0:
tmp1 = ref_01088_anairiats_rec_0 (arg0) ;
return (tmp1) ;
} /* end of [ref_make_elt_01089_anairiats_rec_0] */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/prelude/DATS/array0.dats: 1993(line=65, offs=30) -- 2018(line=65, offs=55)
*/
ATSglobaldec()
ats_ptr_type
ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_make_arrpsz (anairiats_rec_0 arg0) {
/* local vardec */
ATSlocal (ats_ptr_type, tmp0) ;

__ats_lab_ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_make_arrpsz:
tmp0 = ref_make_elt_01089_anairiats_rec_0 (arg0) ;
return (tmp0) ;
} /* end of [ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_make_arrpsz] */

/*
// /nix/store/v4f9spcfgyx2132bq60s8qqal6hyzhgd-ats-0.2.12/lib/ats-anairiats-0.2.12/prelude/DATS/array0.dats: 2813(line=96, offs=13) -- 2894(line=100, offs=4)
*/
ATSglobaldec()
ats_size_type
ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_size (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_size_type, tmp4) ;
ATSlocal (ats_ptr_type, tmp5) ;

__ats_lab_ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_size:
tmp5 = ats_selsin_mac(ats_castfn_mac(ats_ptr_type, arg0), atslab_1) ;
tmp4 = ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp5), atslab_3) ;
return (tmp4) ;
} /* end of [ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__array0_size] */

/* static load function */

// extern ats_void_type ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__staload (void) ;
extern ats_void_type ATS_2d0_2e2_2e12_2prelude_2DATS_2reference_2edats__staload (void) ;

ats_void_type
ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__staload () {
static int ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__staload_flag = 0 ;
if (ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__staload_flag) return ;
ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__staload_flag = 1 ;

// ATS_2d0_2e2_2e12_2prelude_2SATS_2array0_2esats__staload () ;
ATS_2d0_2e2_2e12_2prelude_2DATS_2reference_2edats__staload () ;

return ;
} /* staload function */

/* dynamic load function */

// dynload flag declaration
// extern ats_int_type ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__dynload_flag ;

ats_void_type
ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__dynload () {
// ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__dynload_flag = 1 ;
ATS_2d0_2e2_2e12_2prelude_2DATS_2array0_2edats__staload () ;

#ifdef _ATS_PROOFCHECK
#endif /* _ATS_PROOFCHECK */

/* marking static variables for GC */

/* marking external values for GC */

/* code for dynamic loading */
return ;
} /* end of [dynload function] */

/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [DATS_array0_dats.c] */
