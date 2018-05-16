/*
**
** The C code is generated by ATS/Anairiats
** The compilation time is: 2018-3-22:  1h:15m
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

/* prologues from statically loaded files */
/* external codes at top */
/* type definitions */
/* external typedefs */
/* assuming abstract types */
/* sum constructor declarations */
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infix_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infixl_1) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infixr_2) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_prefix_3) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_postfix_4) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_pos_1) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_neg_2) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fn_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fnx_1) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fun_2) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_prfn_3) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_prfun_4) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_praxi_5) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_castfn_6) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_pos_1) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_neg_2) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_prval_3) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKfun_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKval_1) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKpraxi_2) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKprfun_3) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKprval_4) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKcastfn_5) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FUNCLOfun_0) ;
ATSglobal(ats_sum_type, _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FUNCLOclo_1) ;

/* exn constructor declarations */
/* static load function */

ats_void_type
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__staload () {
static int _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__staload_flag = 0 ;
if (_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__staload_flag) return ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__staload_flag = 1 ;

_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infix_0.tag = 0 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infixl_1.tag = 1 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_infixr_2.tag = 2 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_prefix_3.tag = 3 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FXK_postfix_4.tag = 4 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_0.tag = 0 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_pos_1.tag = 1 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__CK_case_neg_2.tag = 2 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fn_0.tag = 0 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fnx_1.tag = 1 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_fun_2.tag = 2 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_prfn_3.tag = 3 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_prfun_4.tag = 4 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_praxi_5.tag = 5 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FK_castfn_6.tag = 6 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_0.tag = 0 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_pos_1.tag = 1 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_val_neg_2.tag = 2 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__VK_prval_3.tag = 3 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKfun_0.tag = 0 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKval_1.tag = 1 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKpraxi_2.tag = 2 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKprfun_3.tag = 3 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKprval_4.tag = 4 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__DCKcastfn_5.tag = 5 ;
_2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FUNCLOfun_0.tag = 0 ;
// _2tmp_2ATS_2dPostiats_2src_2pats_basics_2esats__FUNCLOclo_1.tag = 1 ;
return ;
} /* staload function */

/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [pats_basics_sats.c] */
