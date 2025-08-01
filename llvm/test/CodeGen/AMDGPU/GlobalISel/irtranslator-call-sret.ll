; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -stop-after=irtranslator < %s | FileCheck -check-prefix=GCN %s

declare hidden void @external_void_func_sret_struct_i8_i32_byval_struct_i8_i32(ptr addrspace(5) sret({ i8, i32 }), ptr addrspace(5) byval({ i8, i32 })) #0

define amdgpu_kernel void @test_call_external_void_func_sret_struct_i8_i32_byval_struct_i8_i32(i32) #0 {
  ; GCN-LABEL: name: test_call_external_void_func_sret_struct_i8_i32_byval_struct_i8_i32
  ; GCN: bb.1 (%ir-block.1):
  ; GCN-NEXT:   liveins: $sgpr14, $sgpr15, $sgpr16, $vgpr0, $vgpr1, $vgpr2, $sgpr4_sgpr5, $sgpr6_sgpr7, $sgpr8_sgpr9, $sgpr10_sgpr11
  ; GCN-NEXT: {{  $}}
  ; GCN-NEXT:   [[COPY:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr2
  ; GCN-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr1
  ; GCN-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr0
  ; GCN-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr16
  ; GCN-NEXT:   [[COPY4:%[0-9]+]]:sgpr_32 = COPY $sgpr15
  ; GCN-NEXT:   [[COPY5:%[0-9]+]]:sgpr_32 = COPY $sgpr14
  ; GCN-NEXT:   [[COPY6:%[0-9]+]]:sgpr_64 = COPY $sgpr10_sgpr11
  ; GCN-NEXT:   [[COPY7:%[0-9]+]]:sgpr_64 = COPY $sgpr6_sgpr7
  ; GCN-NEXT:   [[COPY8:%[0-9]+]]:sgpr_64 = COPY $sgpr4_sgpr5
  ; GCN-NEXT:   [[COPY9:%[0-9]+]]:_(p4) = COPY $sgpr8_sgpr9
  ; GCN-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 3
  ; GCN-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 8
  ; GCN-NEXT:   [[DEF:%[0-9]+]]:_(p1) = G_IMPLICIT_DEF
  ; GCN-NEXT:   [[FRAME_INDEX:%[0-9]+]]:_(p5) = G_FRAME_INDEX %stack.0.in.val
  ; GCN-NEXT:   [[FRAME_INDEX1:%[0-9]+]]:_(p5) = G_FRAME_INDEX %stack.1.out.val
  ; GCN-NEXT:   [[INT:%[0-9]+]]:_(p4) = G_INTRINSIC intrinsic(@llvm.amdgcn.kernarg.segment.ptr)
  ; GCN-NEXT:   [[C2:%[0-9]+]]:_(s32) = G_CONSTANT i32 4
  ; GCN-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p5) = nuw nusw G_PTR_ADD [[FRAME_INDEX]], [[C2]](s32)
  ; GCN-NEXT:   G_STORE [[C]](s8), [[FRAME_INDEX]](p5) :: (store (s8) into %ir.in.val, addrspace 5)
  ; GCN-NEXT:   G_STORE [[C1]](s32), [[PTR_ADD]](p5) :: (store (s32) into %ir.in.gep1, addrspace 5)
  ; GCN-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def $scc
  ; GCN-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @external_void_func_sret_struct_i8_i32_byval_struct_i8_i32
  ; GCN-NEXT:   [[COPY10:%[0-9]+]]:_(p4) = COPY [[COPY8]]
  ; GCN-NEXT:   [[COPY11:%[0-9]+]]:_(p4) = COPY [[COPY7]]
  ; GCN-NEXT:   [[COPY12:%[0-9]+]]:_(p4) = COPY [[COPY9]](p4)
  ; GCN-NEXT:   [[C3:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; GCN-NEXT:   [[PTR_ADD1:%[0-9]+]]:_(p4) = nuw G_PTR_ADD [[COPY12]], [[C3]](s64)
  ; GCN-NEXT:   [[COPY13:%[0-9]+]]:_(s64) = COPY [[COPY6]]
  ; GCN-NEXT:   [[COPY14:%[0-9]+]]:_(s32) = COPY [[COPY5]]
  ; GCN-NEXT:   [[COPY15:%[0-9]+]]:_(s32) = COPY [[COPY4]]
  ; GCN-NEXT:   [[COPY16:%[0-9]+]]:_(s32) = COPY [[COPY3]]
  ; GCN-NEXT:   [[DEF1:%[0-9]+]]:_(s32) = G_IMPLICIT_DEF
  ; GCN-NEXT:   [[COPY17:%[0-9]+]]:_(s32) = COPY [[COPY2]](s32)
  ; GCN-NEXT:   [[COPY18:%[0-9]+]]:_(s32) = COPY [[COPY1]](s32)
  ; GCN-NEXT:   [[C4:%[0-9]+]]:_(s32) = G_CONSTANT i32 10
  ; GCN-NEXT:   [[SHL:%[0-9]+]]:_(s32) = G_SHL [[COPY18]], [[C4]](s32)
  ; GCN-NEXT:   [[OR:%[0-9]+]]:_(s32) = G_OR [[COPY17]], [[SHL]]
  ; GCN-NEXT:   [[COPY19:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; GCN-NEXT:   [[C5:%[0-9]+]]:_(s32) = G_CONSTANT i32 20
  ; GCN-NEXT:   [[SHL1:%[0-9]+]]:_(s32) = G_SHL [[COPY19]], [[C5]](s32)
  ; GCN-NEXT:   [[OR1:%[0-9]+]]:_(s32) = G_OR [[OR]], [[SHL1]]
  ; GCN-NEXT:   [[AMDGPU_WAVE_ADDRESS:%[0-9]+]]:_(p5) = G_AMDGPU_WAVE_ADDRESS $sp_reg
  ; GCN-NEXT:   [[C6:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; GCN-NEXT:   [[PTR_ADD2:%[0-9]+]]:_(p5) = G_PTR_ADD [[AMDGPU_WAVE_ADDRESS]], [[C6]](s32)
  ; GCN-NEXT:   [[C7:%[0-9]+]]:_(s32) = G_CONSTANT i32 8
  ; GCN-NEXT:   G_MEMCPY [[PTR_ADD2]](p5), [[FRAME_INDEX]](p5), [[C7]](s32), 0 :: (dereferenceable store (s64) into stack, align 4, addrspace 5), (dereferenceable load (s64) from %ir.in.val, align 4, addrspace 5)
  ; GCN-NEXT:   $vgpr0 = COPY [[FRAME_INDEX1]](p5)
  ; GCN-NEXT:   [[COPY20:%[0-9]+]]:_(<4 x s32>) = COPY $private_rsrc_reg
  ; GCN-NEXT:   $sgpr0_sgpr1_sgpr2_sgpr3 = COPY [[COPY20]](<4 x s32>)
  ; GCN-NEXT:   $sgpr4_sgpr5 = COPY [[COPY10]](p4)
  ; GCN-NEXT:   $sgpr6_sgpr7 = COPY [[COPY11]](p4)
  ; GCN-NEXT:   $sgpr8_sgpr9 = COPY [[PTR_ADD1]](p4)
  ; GCN-NEXT:   $sgpr10_sgpr11 = COPY [[COPY13]](s64)
  ; GCN-NEXT:   $sgpr12 = COPY [[COPY14]](s32)
  ; GCN-NEXT:   $sgpr13 = COPY [[COPY15]](s32)
  ; GCN-NEXT:   $sgpr14 = COPY [[COPY16]](s32)
  ; GCN-NEXT:   $sgpr15 = COPY [[DEF1]](s32)
  ; GCN-NEXT:   $vgpr31 = COPY [[OR1]](s32)
  ; GCN-NEXT:   $sgpr30_sgpr31 = noconvergent G_SI_CALL [[GV]](p0), @external_void_func_sret_struct_i8_i32_byval_struct_i8_i32, csr_amdgpu, implicit $vgpr0, implicit $sgpr0_sgpr1_sgpr2_sgpr3, implicit $sgpr4_sgpr5, implicit $sgpr6_sgpr7, implicit $sgpr8_sgpr9, implicit $sgpr10_sgpr11, implicit $sgpr12, implicit $sgpr13, implicit $sgpr14, implicit $sgpr15, implicit $vgpr31
  ; GCN-NEXT:   ADJCALLSTACKDOWN 0, 8, implicit-def $scc
  ; GCN-NEXT:   [[PTR_ADD3:%[0-9]+]]:_(p5) = nuw nusw G_PTR_ADD [[FRAME_INDEX1]], [[C2]](s32)
  ; GCN-NEXT:   [[LOAD:%[0-9]+]]:_(s8) = G_LOAD [[FRAME_INDEX1]](p5) :: (dereferenceable load (s8) from %ir.out.val, addrspace 5)
  ; GCN-NEXT:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[PTR_ADD3]](p5) :: (dereferenceable load (s32) from %ir.out.gep1, addrspace 5)
  ; GCN-NEXT:   G_STORE [[LOAD]](s8), [[DEF]](p1) :: (volatile store (s8) into `ptr addrspace(1) poison`, addrspace 1)
  ; GCN-NEXT:   G_STORE [[LOAD1]](s32), [[DEF]](p1) :: (volatile store (s32) into `ptr addrspace(1) poison`, addrspace 1)
  ; GCN-NEXT:   S_ENDPGM 0
  %in.val = alloca { i8, i32 }, align 4, addrspace(5)
  %out.val = alloca { i8, i32 }, align 4, addrspace(5)
  %in.gep0 = getelementptr inbounds { i8, i32 }, ptr addrspace(5) %in.val, i32 0, i32 0
  %in.gep1 = getelementptr inbounds { i8, i32 }, ptr addrspace(5) %in.val, i32 0, i32 1
  store i8 3, ptr addrspace(5) %in.gep0
  store i32 8, ptr addrspace(5) %in.gep1
  call void @external_void_func_sret_struct_i8_i32_byval_struct_i8_i32(ptr addrspace(5) %out.val, ptr addrspace(5) %in.val)
  %out.gep0 = getelementptr inbounds { i8, i32 }, ptr addrspace(5) %out.val, i32 0, i32 0
  %out.gep1 = getelementptr inbounds { i8, i32 }, ptr addrspace(5) %out.val, i32 0, i32 1
  %out.val0 = load i8, ptr addrspace(5) %out.gep0
  %out.val1 = load i32, ptr addrspace(5) %out.gep1
  store volatile i8 %out.val0, ptr addrspace(1) poison
  store volatile i32 %out.val1, ptr addrspace(1) poison
  ret void
}

