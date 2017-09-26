; ModuleID = 'grav_2.c'
source_filename = "grav_2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.x = private unnamed_addr constant [10 x float] [float 1.000000e+00, float 1.500000e+00, float 2.000000e+00, float 2.500000e+00, float 3.000000e+00, float 3.500000e+00, float 4.000000e+00, float 4.500000e+00, float 5.000000e+00, float 5.500000e+00], align 16
@main.y = private unnamed_addr constant [10 x float] [float 1.500000e+00, float 2.500000e+00, float 3.500000e+00, float 4.500000e+00, float 6.000000e+00, float 8.000000e+00, float 1.050000e+01, float 1.100000e+01, float 1.150000e+01, float 1.200000e+01], align 16

; Function Attrs: noinline nounwind uwtable
define i32 @gravitational_force(float*, float*, float, float, float, float*) #0 {
  %7 = alloca float*, align 8
  %8 = alloca float*, align 8
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float*, align 8
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca i32, align 4
  store float* %0, float** %7, align 8
  store float* %1, float** %8, align 8
  store float %2, float* %9, align 4
  store float %3, float* %10, align 4
  store float %4, float* %11, align 4
  store float* %5, float** %12, align 8
  store i32 0, i32* %15, align 4
  br label %16

; <label>:16:                                     ; preds = %55, %6
  %17 = load i32, i32* %15, align 4
  %18 = icmp slt i32 %17, 10
  br i1 %18, label %19, label %58

; <label>:19:                                     ; preds = %16
  %20 = load float, float* %11, align 4
  %21 = load float, float* %9, align 4
  %22 = fmul float %20, %21
  %23 = load float, float* %10, align 4
  %24 = fmul float %22, %23
  store float %24, float* %13, align 4
  %25 = load float*, float** %7, align 8
  %26 = load i32, i32* %15, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds float, float* %25, i64 %27
  %29 = load float, float* %28, align 4
  %30 = load float*, float** %8, align 8
  %31 = load i32, i32* %15, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds float, float* %30, i64 %32
  %34 = load float, float* %33, align 4
  %35 = fsub float %29, %34
  %36 = load float*, float** %7, align 8
  %37 = load i32, i32* %15, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds float, float* %36, i64 %38
  %40 = load float, float* %39, align 4
  %41 = load float*, float** %8, align 8
  %42 = load i32, i32* %15, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds float, float* %41, i64 %43
  %45 = load float, float* %44, align 4
  %46 = fsub float %40, %45
  %47 = fmul float %35, %46
  store float %47, float* %14, align 4
  %48 = load float, float* %13, align 4
  %49 = load float, float* %14, align 4
  %50 = fdiv float %48, %49
  %51 = load float*, float** %12, align 8
  %52 = load i32, i32* %15, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds float, float* %51, i64 %53
  store float %50, float* %54, align 4
  br label %55

; <label>:55:                                     ; preds = %19
  %56 = load i32, i32* %15, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, i32* %15, align 4
  br label %16

; <label>:58:                                     ; preds = %16
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
  %11 = call i32 @gravitational_force(float* %8, float* %9, float 2.000000e+01, float 1.500000e+01, float 0x3DD2559860000000, float* %10)
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
