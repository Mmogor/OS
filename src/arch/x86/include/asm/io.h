#ifndef INCLUDE_ASM_IO_H
#define INCLUDE_ASM_IO_H

#include "../types.h"

#ifndef __always_inline
#define __always_inline inline __attribute((always_inline))
#endif // __always_inline

#define BUILDIO(bwl, bw, type)							\
static __always_inline void __out##bwl(type value, u16 port)			\
{               								\
	asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port));	\
}										\
										\
static __always_inline type __in##bwl(u16 port) 				\
{										\
	type value;								\
	asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port));	\
	return value;								\
}

BUILDIO(b, b, u8)
BUILDIO(w, w, u16)
BUILDIO(l,  , u32)

#undef BUILDIO

#endif // INCLUDE_ASM_IO_H
