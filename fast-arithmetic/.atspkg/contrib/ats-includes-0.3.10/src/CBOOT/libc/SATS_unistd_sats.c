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

/* prologues from statically loaded files */

#include "libc/sys/CATS/types.cats"

#include "libc/CATS/fcntl.cats"

#include "libc/sys/CATS/types.cats"
/* external codes at top */

#include "libc/CATS/unistd.cats"

/* type definitions */
/* external typedefs */
/* assuming abstract types */
/* sum constructor declarations */
/* exn constructor declarations */
/* static load function */

extern ats_void_type ATS_2d0_2e2_2e12_2libc_2sys_2SATS_2types_2esats__staload (void) ;
extern ats_void_type ATS_2d0_2e2_2e12_2libc_2SATS_2fcntl_2esats__staload (void) ;

ats_void_type
ATS_2d0_2e2_2e12_2libc_2SATS_2unistd_2esats__staload () {
static int ATS_2d0_2e2_2e12_2libc_2SATS_2unistd_2esats__staload_flag = 0 ;
if (ATS_2d0_2e2_2e12_2libc_2SATS_2unistd_2esats__staload_flag) return ;
ATS_2d0_2e2_2e12_2libc_2SATS_2unistd_2esats__staload_flag = 1 ;

ATS_2d0_2e2_2e12_2libc_2sys_2SATS_2types_2esats__staload () ;
ATS_2d0_2e2_2e12_2libc_2SATS_2fcntl_2esats__staload () ;

return ;
} /* staload function */

/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [SATS_unistd_sats.c] */
