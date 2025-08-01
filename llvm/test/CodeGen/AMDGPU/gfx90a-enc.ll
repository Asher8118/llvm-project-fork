; RUN: llc -mtriple=amdgcn -mcpu=gfx908 -show-mc-encoding < %s | FileCheck -check-prefixes=GFX9,GFX908 %s

; Make sure flag is ignored
; RUN: llc -mtriple=amdgcn -mcpu=gfx908 -amdgpu-mfma-vgpr-form=1 -show-mc-encoding < %s | FileCheck -check-prefixes=GFX9,GFX908 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -show-mc-encoding < %s | FileCheck -check-prefixes=GFX9,GFX90A %s

; GFX9-DAG:   buffer_load_format_xyzw v[{{[0-9:]+}}], v{{[0-9]+}}, s[{{[0-9:]+}}], 0 idxen ; encoding:
; GFX9-DAG:   buffer_load_format_d16_xyzw v[{{[0-9:]+}}], v{{[0-9]+}}, s[{{[0-9:]+}}], 0 idxen ; encoding:
; GFX908-DAG: v_mfma_i32_4x4x4i8 a[{{[0-9:]+}}], v{{[0-9]+}}, v{{[0-9]+}}, a[{{[0-9:]+}}] ; encoding: [{{0x..,0x0.,}}
; GFX90A-DAG: v_mfma_i32_4x4x4i8 a[{{[0-9:]+}}], v{{[0-9]+}}, v{{[0-9]+}}, a[{{[0-9:]+}}] ; encoding: [{{0x..,0x8.,}}
define amdgpu_kernel void @test(<4 x i32> %x) #0 {
  %id = tail call i32 @llvm.amdgcn.workitem.id.x()
  %.x.int = bitcast <4 x i32> %x to i128
  %.x.ptr = inttoptr i128 %.x.int to ptr addrspace(8)
  %r1 = tail call <4 x float> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f32(ptr addrspace(8) %.x.ptr, i32 %id, i32 0, i32 0, i32 0)
  store volatile <4 x float> %r1, ptr poison
  %r2 = tail call <4 x half> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f16(ptr addrspace(8) %.x.ptr, i32 %id, i32 0, i32 0, i32 0)
  store volatile <4 x half> %r2, ptr poison
  %r3 = tail call <4 x i32> @llvm.amdgcn.mfma.i32.4x4x4i8(i32 1, i32 2, <4 x i32> %x, i32 0, i32 0, i32 0)
  store <4 x i32> %r3, ptr poison
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #0
declare <4 x float> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f32(ptr addrspace(8), i32, i32, i32, i32 immarg) #1
declare <4 x half> @llvm.amdgcn.struct.ptr.buffer.load.format.v4f16(ptr addrspace(8), i32, i32, i32, i32 immarg) #1
declare <4 x i32> @llvm.amdgcn.mfma.i32.4x4x4i8(i32, i32, <4 x i32>, i32 immarg, i32 immarg, i32 immarg) #2

attributes #0 = { nounwind readnone speculatable willreturn "amdgpu-flat-work-group-size"="1,256" }
attributes #1 = { nounwind memory(argmem: read) willreturn }
attributes #2 = { convergent nounwind readnone willreturn }
