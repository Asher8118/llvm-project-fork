; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn -mcpu=gfx1250 < %s | FileCheck --check-prefix=GCN %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx1250 < %s | FileCheck --check-prefix=GCN %s

define amdgpu_ps float @scratch_load_b32_alloca_idxprom(i32 %idx) {
; GCN-LABEL: scratch_load_b32_alloca_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %p = alloca [32 x i32], align 4, addrspace(5)
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i64 %idxprom
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b32_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b32_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = sext i32 %idx to i64
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i64 %idxprom
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b32_idx32(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b32_idx32:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i32 %idx
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b32_idxprom_wrong_stride(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b32_idxprom_wrong_stride:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GCN-NEXT:    scratch_load_b32 v0, v0, s0
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds <2 x float>, ptr addrspace(5) %p, i64 %idxprom
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b16_idxprom_ioffset(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b16_idxprom_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_u16 v0, v0, s0 offset:32 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = sext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds i16, ptr addrspace(5) %p, i64 %idxadd
  %ld = load i16, ptr addrspace(5) %arrayidx, align 2
  %ret.i32 = zext i16 %ld to i32
  %ret = bitcast i32 %ret.i32 to float
  ret float %ret
}

define amdgpu_ps <2 x float> @scratch_load_b64_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b64_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b64 v[0:1], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds <2 x float>, ptr addrspace(5) %p, i64 %idxprom
  %ret = load <2 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <2 x float> %ret
}

define amdgpu_ps <3 x float> @scratch_load_b96_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b96_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b96 v[0:2], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds [3 x float], ptr addrspace(5) %p, i64 %idxprom
  %ret = load <3 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <3 x float> %ret
}

define amdgpu_ps <3 x float> @scratch_load_b96_idxpromi_ioffset(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b96_idxpromi_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b96 v[0:2], v0, s0 offset:192 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = zext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds [3 x float], ptr addrspace(5) %p, i64 %idxadd
  %ret = load <3 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <3 x float> %ret
}

define amdgpu_ps <4 x float> @scratch_load_b128_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_load_b128_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b128 v[0:3], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds <4 x float>, ptr addrspace(5) %p, i64 %idxprom
  %ret = load <4 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <4 x float> %ret
}

define amdgpu_ps float @scratch_load_b32_idxprom_range(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b32_idxprom_range:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b32 v0, v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i64 %idxprom
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b32_idxprom_range_ioffset(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b32_idxprom_range_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b32 v0, v0, s0 offset:64 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i64 %idxadd
  %ret = load float, ptr addrspace(5) %arrayidx, align 4
  ret float %ret
}

define amdgpu_ps float @scratch_load_b8_idxprom_range_ioffset(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b8_idxprom_range_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_u8 v0, v0, s0 offset:16
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds i8, ptr addrspace(5) %p, i64 %idxadd
  %ld = load i8, ptr addrspace(5) %arrayidx
  %ret.i32 = zext i8 %ld to i32
  %ret = bitcast i32 %ret.i32 to float
  ret float %ret
}

define amdgpu_ps float @scratch_load_b16_idxprom_range(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b16_idxprom_range:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_u16 v0, v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds i16, ptr addrspace(5) %p, i64 %idxprom
  %ld = load i16, ptr addrspace(5) %arrayidx, align 2
  %ret.i32 = zext i16 %ld to i32
  %ret = bitcast i32 %ret.i32 to float
  ret float %ret
}

define amdgpu_ps float @scratch_load_b16_idxprom_range_ioffset(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b16_idxprom_range_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_u16 v0, v0, s0 offset:32 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds i16, ptr addrspace(5) %p, i64 %idxadd
  %ld = load i16, ptr addrspace(5) %arrayidx, align 2
  %ret.i32 = zext i16 %ld to i32
  %ret = bitcast i32 %ret.i32 to float
  ret float %ret
}

define amdgpu_ps <2 x float> @scratch_load_b64_idxprom_range(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b64_idxprom_range:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b64 v[0:1], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds <2 x float>, ptr addrspace(5) %p, i64 %idxprom
  %ret = load <2 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <2 x float> %ret
}

; Multiplication is unsigned here, so we cannot match it.

define amdgpu_ps <3 x float> @scratch_load_b96_idxprom_range(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b96_idxprom_range:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b96 v[0:2], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = sext i32 %idx to i64
  %arrayidx = getelementptr inbounds [3 x float], ptr addrspace(5) %p, i64 %idxprom
  %ret = load <3 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <3 x float> %ret
}

define amdgpu_ps <3 x float> @scratch_load_b96_idxprom_range_ioffset(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b96_idxprom_range_ioffset:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b96 v[0:2], v0, s0 offset:192 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = sext i32 %idx to i64
  %idxadd = add i64 %idxprom, 16
  %arrayidx = getelementptr inbounds [3 x float], ptr addrspace(5) %p, i64 %idxadd
  %ret = load <3 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <3 x float> %ret
}

define amdgpu_ps <4 x float> @scratch_load_b128_idxprom_range(ptr addrspace(5) align 4 inreg %p, ptr addrspace(5) align 4 %pp) {
; GCN-LABEL: scratch_load_b128_idxprom_range:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    scratch_load_b32 v0, v0, off
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    scratch_load_b128 v[0:3], v0, s0 scale_offset
; GCN-NEXT:    s_wait_loadcnt 0x0
; GCN-NEXT:    ; return to shader part epilog
entry:
  %idx = load i32, ptr addrspace(5) %pp, align 4, !range !0
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds <4 x float>, ptr addrspace(5) %p, i64 %idxprom
  %ret = load <4 x float>, ptr addrspace(5) %arrayidx, align 4
  ret <4 x float> %ret
}

define amdgpu_ps void @scratch_store_b32_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_store_b32_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_mov_b32_e32 v1, 1.0
; GCN-NEXT:    scratch_store_b32 v0, v1, s0 scale_offset
; GCN-NEXT:    s_endpgm
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds float, ptr addrspace(5) %p, i64 %idxprom
  store float 1.0, ptr addrspace(5) %arrayidx, align 4
  ret void
}

define amdgpu_ps void @scratch_store_b16_idxprom(ptr addrspace(5) align 2 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_store_b16_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_mov_b32_e32 v1, 1
; GCN-NEXT:    scratch_store_b16 v0, v1, s0 scale_offset
; GCN-NEXT:    s_endpgm
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds i16, ptr addrspace(5) %p, i64 %idxprom
  store i16 1, ptr addrspace(5) %arrayidx, align 2
  ret void
}

define amdgpu_ps void @scratch_store_b64_idxprom(ptr addrspace(5) align 4 inreg %p, i32 %idx) {
; GCN-LABEL: scratch_store_b64_idxprom:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    v_mov_b64_e32 v[2:3], 1.0
; GCN-NEXT:    scratch_store_b64 v0, v[2:3], s0 scale_offset
; GCN-NEXT:    s_endpgm
entry:
  %idxprom = zext i32 %idx to i64
  %arrayidx = getelementptr inbounds double, ptr addrspace(5) %p, i64 %idxprom
  store double 1.0, ptr addrspace(5) %arrayidx, align 4
  ret void
}

!0 = !{i32 0, i32 1024}
