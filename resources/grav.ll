; ModuleID = 'grav.c'
source_filename = "grav.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.x = private unnamed_addr constant [10 x float] [float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00], align 16
@main.y = private unnamed_addr constant [10 x float] [float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00, float 2.000000e+00], align 16

; Function Attrs: noinline nounwind uwtable
define i32 @gravitational_force(float*, float*, float, float, float, float*) #0 {
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float*, align 8
  %13 = alloca i32, align 4
  store float* %0, float** %7, align 8
  store float* %1, float** %8, align 8
  store float %2, float* %9, align 4
  store float %3, float* %10, align 4
  store float %4, float* %11, align 4
  store float* %5, float** %12, align 8
  store i32 0, i32* %13, align 4
  br label %14

; <label>:14:                                     ; preds = %51, %6
  %15 = load i32, i32* %13, align 4
  %16 = icmp slt i32 %15, 10
  br i1 %16, label %17, label %54

; <label>:17:                                     ; preds = %14
  %18 = load float, float* %11, align 4
  %19 = load float, float* %9, align 4
  %20 = fmul float %18, %19
  %21 = load float, float* %10, align 4
  %22 = fmul float %20, %21
  %23 = load float*, float** %7, align 8
  %24 = load i32, i32* %13, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds float, float* %23, i64 %25
  %27 = load float, float* %26, align 4
  %28 = load float*, float** %8, align 8
  %29 = load i32, i32* %13, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds float, float* %28, i64 %30
  %32 = load float, float* %31, align 4
  %33 = fsub float %27, %32
  %34 = load float*, float** %7, align 8
  %35 = load i32, i32* %13, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds float, float* %34, i64 %36
  %38 = load float, float* %37, align 4
  %39 = load float*, float** %8, align 8
  %40 = load i32, i32* %13, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds float, float* %39, i64 %41
  %43 = load float, float* %42, align 4
  %44 = fsub float %38, %43
  %45 = fmul float %33, %44
  %46 = fdiv float %22, %45
  %47 = load float*, float** %12, align 8
  %48 = load i32, i32* %13, align 4
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds float, float* %47, i64 %49
  store float %46, float* %50, align 4
  br label %51

; <label>:51:                                     ; preds = %17
  %52 = load i32, i32* %13, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, i32* %13, align 4
  br label %14

; <label>:54:                                     ; preds = %14
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [10 x float], align 16
  %3 = alloca [10 x float], align 16
  %4 = alloca [10 x float], align 16
  store i32 0, i32* %1, align 4
  %5 = bitcast [10 x float]* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* bitcast ([10 x float]* @main.x to i8*), i64 40, i32 16, i1 false)
  %6 = bitcast [10 x float]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* bitcast ([10 x float]* @main.y to i8*), i64 40, i32 16, i1 false)
  %7 = bitcast [10 x float]* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 40, i32 16, i1 false)
  %8 = getelementptr inbounds [10 x float], [10 x float]* %2, i32 0, i32 0
  %9 = getelementptr inbounds [10 x float], [10 x float]* %3, i32 0, i32 0
  %10 = getelementptr inbounds [10 x float], [10 x float]* %4, i32 0, i32 0
  %11 = call i32 @gravitational_force(float* %8, float* %9, float 2.000000e+01, float 1.500000e+01, float 0x40239EB860000000, float* %10)
  ret i32 %11
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
