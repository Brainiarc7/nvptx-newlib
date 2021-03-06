// Support file for nvptx in newlib.
// Copyright (c) 2014 Mentor Graphics.

// The authors hereby grant permission to use, copy, modify, distribute,
// and license this software and its documentation for any purpose, provided
// that existing copyright notices are retained in all copies and that this
// notice is included verbatim in any distributions. No written agreement,
// license, or royalty fee is required for any of the authorized uses.
// Modifications to this software may be copyrighted by their authors
// and need not follow the licensing terms described here, provided that
// the new terms are clearly indicated on the first page of each file where
// they apply.

        .version        3.1
        .target sm_30
        .address_size 64

// BEGIN GLOBAL FUNCTION DEF: putchar
.const .align 1 .u8 $LC0[4] = { 37, 99, 10, 0 };
.extern .func (.param.u32 %out_retval)printf (.param.u64 %arg0, .param.u64 %arg1);
.visible .func (.param.u32 %out_retval)putchar(.param.u32 %in_ar1)
{
	.param.u32 %retval_in;
	.param.u64 fmt, arg;
	.reg.u64 r1;
	.reg.u32 r2;
	.reg.u64 r3;
       	.local.b8 %outargs[1];

	cvta.const.u64 r1, $LC0;
	ld.param.u32 r2,[%in_ar1];
	cvta.local.u64  r3, %outargs;
	st.param.u64 [fmt], r1;
	st.local.u8 [%outargs], r2;
	st.param.u64 [arg], r3;
        {
                call (%retval_in), printf, (fmt, arg);
        }
	ld.param.u64    r1, [%retval_in];
	st.param.u64	[%out_retval], r1;
}
