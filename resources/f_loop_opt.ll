; ModuleID = 'f_loop.ll'
source_filename = "f_loop.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.a = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16
@main.b = private unnamed_addr constant [5 x i32] [i32 10, i32 20, i32 30, i32 40, i32 50], align 16

; Function Attrs: noinline nounwind uwtable
define void @evil_func(i32*, i32*) #0 {
  br label %3

; <label>:3:                                      ; preds = %11, %2
  %.0 = phi i32 [ 0, %2 ], [ %12, %11 ]
  %4 = icmp slt i32 %.0, 5
  br i1 %4, label %5, label %13

; <label>:5:                                      ; preds = %3
  %6 = sext i32 %.0 to i64
  %7 = getelementptr inbounds i32, i32* %0, i64 %6
  %8 = load i32, i32* %7, align 4
  %9 = load i32, i32* %1, align 4
  %10 = add nsw i32 %8, %9
  store i32 %10, i32* %1, align 4
  br label %11

; <label>:11:                                     ; preds = %5
  %12 = add nsw i32 %.0, 1
  br label %3

; <label>:13:                                     ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @f_loop(i32*, i32*, i32*, i32*, i32*, i32*) #0 {
  %7 = alloca [5 x i32], align 16
  %8 = alloca [5 x i32], align 16
  br label %9

; <label>:9:                                      ; preds = %45, %6
  %.01 = phi i32 [ 0, %6 ], [ %46, %45 ]
  %10 = icmp slt i32 %.01, 5
  br i1 %10, label %11, label %47

; <label>:11:                                     ; preds = %9
  %12 = sext i32 %.01 to i64
  %13 = getelementptr inbounds i32, i32* %0, i64 %12
  %14 = load i32, i32* %13, align 4
  %15 = sext i32 %.01 to i64
  %16 = getelementptr inbounds i32, i32* %1, i64 %15
  %17 = load i32, i32* %16, align 4
  %18 = add nsw i32 %14, %17
  %19 = sext i32 %.01 to i64
  %20 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i64 0, i64 %19
  store i32 %18, i32* %20, align 4
  %21 = sext i32 %.01 to i64
  %22 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i64 0, i64 %21
  %23 = load i32, i32* %22, align 4
  %24 = load i32, i32* %3, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, i32* %3, align 4
  %27 = add nsw i32 %25, %26
  %28 = sext i32 %.01 to i64
  %29 = getelementptr inbounds [5 x i32], [5 x i32]* %8, i64 0, i64 %28
  store i32 %27, i32* %29, align 4
  %30 = sext i32 %.01 to i64
  %31 = getelementptr inbounds [5 x i32], [5 x i32]* %8, i64 0, i64 %30
  %32 = load i32, i32* %31, align 4
  %33 = sext i32 %.01 to i64
  %34 = getelementptr inbounds i32, i32* %2, i64 %33
  %35 = load i32, i32* %34, align 4
  %36 = sdiv i32 %32, %35
  %37 = sext i32 %.01 to i64
  %38 = getelementptr inbounds i32, i32* %2, i64 %37
  store i32 %36, i32* %38, align 4
  %39 = load i32, i32* %3, align 4
  %40 = load i32, i32* %4, align 4
  %41 = add nsw i32 %39, %40
  store i32 %41, i32* %5, align 4
  %42 = load i32, i32* %3, align 4
  %43 = load i32, i32* %5, align 4
  %44 = mul nsw i32 %42, %43
  store i32 %44, i32* %4, align 4
  br label %45

; <label>:45:                                     ; preds = %11
  %46 = add nsw i32 %.01, 1
  br label %9

; <label>:47:                                     ; preds = %9
  br label %48

; <label>:48:                                     ; preds = %66, %47
  %.0 = phi i32 [ 0, %47 ], [ %67, %66 ]
  %49 = icmp slt i32 %.0, 5
  br i1 %49, label %50, label %68

; <label>:50:                                     ; preds = %48
  %51 = sext i32 %.0 to i64
  %52 = getelementptr inbounds i32, i32* %0, i64 %51
  %53 = load i32, i32* %52, align 4
  %54 = sext i32 %.0 to i64
  %55 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i64 0, i64 %54
  %56 = load i32, i32* %55, align 4
  %57 = add nsw i32 %53, %56
  %58 = sext i32 %.0 to i64
  %59 = getelementptr inbounds i32, i32* %2, i64 %58
  store i32 %57, i32* %59, align 4
  %60 = sext i32 %.0 to i64
  %61 = getelementptr inbounds i32, i32* %2, i64 %60
  %62 = load i32, i32* %61, align 4
  %63 = sdiv i32 %62, 103
  %64 = sext i32 %.0 to i64
  %65 = getelementptr inbounds i32, i32* %2, i64 %64
  store i32 %63, i32* %65, align 4
  br label %66

; <label>:66:                                     ; preds = %50
  %67 = add nsw i32 %.0, 1
  br label %48

; <label>:68:                                     ; preds = %48
  call void @evil_func(i32* %0, i32* %3)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca [5 x i32], align 16
  %2 = alloca [5 x i32], align 16
  %3 = alloca [5 x i32], align 16
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = bitcast [5 x i32]* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* bitcast ([5 x i32]* @main.a to i8*), i64 20, i32 16, i1 false)
  %8 = bitcast [5 x i32]* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* bitcast ([5 x i32]* @main.b to i8*), i64 20, i32 16, i1 false)
  store i32 10, i32* %4, align 4
  store i32 3, i32* %5, align 4
  store i32 5, i32* %6, align 4
  %9 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
  %10 = getelementptr inbounds [5 x i32], [5 x i32]* %2, i32 0, i32 0
  %11 = getelementptr inbounds [5 x i32], [5 x i32]* %3, i32 0, i32 0
  %12 = call i32 @f_loop(i32* %9, i32* %10, i32* %11, i32* %4, i32* %5, i32* %6)
  ret i32 %12
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
