; ModuleID = 'f_loop.c'
source_filename = "f_loop.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.a = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16
@main.b = private unnamed_addr constant [5 x i32] [i32 10, i32 20, i32 30, i32 40, i32 50], align 16

; Function Attrs: noinline nounwind uwtable
define i32 @f_loop(i32*, i32*, i32*, i32, i32*, i32*) #0 {
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32*, align 8
  %12 = alloca i32*, align 8
  %13 = alloca [5 x i32], align 16
  %14 = alloca [5 x i32], align 16
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store i32* %0, i32** %7, align 8
  store i32* %1, i32** %8, align 8
  store i32* %2, i32** %9, align 8
  store i32 %3, i32* %10, align 4
  store i32* %4, i32** %11, align 8
  store i32* %5, i32** %12, align 8
  store i32 103, i32* %15, align 4
  store i32 0, i32* %16, align 4
  br label %18

; <label>:18:                                     ; preds = %71, %6
  %19 = load i32, i32* %16, align 4
  %20 = icmp slt i32 %19, 5
  br i1 %20, label %21, label %74

; <label>:21:                                     ; preds = %18
  %22 = load i32*, i32** %7, align 8
  %23 = load i32, i32* %16, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, i32* %22, i64 %24
  %26 = load i32, i32* %25, align 4
  %27 = load i32*, i32** %8, align 8
  %28 = load i32, i32* %16, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i32, i32* %27, i64 %29
  %31 = load i32, i32* %30, align 4
  %32 = add nsw i32 %26, %31
  %33 = load i32, i32* %16, align 4
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [5 x i32], [5 x i32]* %13, i64 0, i64 %34
  store i32 %32, i32* %35, align 4
  %36 = load i32, i32* %16, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [5 x i32], [5 x i32]* %13, i64 0, i64 %37
  %39 = load i32, i32* %38, align 4
  %40 = load i32, i32* %10, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32, i32* %10, align 4
  %43 = add nsw i32 %41, %42
  %44 = load i32, i32* %16, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [5 x i32], [5 x i32]* %14, i64 0, i64 %45
  store i32 %43, i32* %46, align 4
  %47 = load i32, i32* %16, align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [5 x i32], [5 x i32]* %14, i64 0, i64 %48
  %50 = load i32, i32* %49, align 4
  %51 = load i32*, i32** %9, align 8
  %52 = load i32, i32* %16, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i32, i32* %51, i64 %53
  %55 = load i32, i32* %54, align 4
  %56 = sdiv i32 %50, %55
  %57 = load i32*, i32** %9, align 8
  %58 = load i32, i32* %16, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds i32, i32* %57, i64 %59
  store i32 %56, i32* %60, align 4
  %61 = load i32, i32* %10, align 4
  %62 = load i32*, i32** %11, align 8
  %63 = load i32, i32* %62, align 4
  %64 = add nsw i32 %61, %63
  %65 = load i32*, i32** %12, align 8
  store i32 %64, i32* %65, align 4
  %66 = load i32, i32* %10, align 4
  %67 = load i32*, i32** %12, align 8
  %68 = load i32, i32* %67, align 4
  %69 = mul nsw i32 %66, %68
  %70 = load i32*, i32** %11, align 8
  store i32 %69, i32* %70, align 4
  br label %71

; <label>:71:                                     ; preds = %21
  %72 = load i32, i32* %16, align 4
  %73 = add nsw i32 %72, 1
  store i32 %73, i32* %16, align 4
  br label %18

; <label>:74:                                     ; preds = %18
  store i32 0, i32* %17, align 4
  br label %75

; <label>:75:                                     ; preds = %104, %74
  %76 = load i32, i32* %17, align 4
  %77 = icmp slt i32 %76, 5
  br i1 %77, label %78, label %107

; <label>:78:                                     ; preds = %75
  %79 = load i32*, i32** %7, align 8
  %80 = load i32, i32* %17, align 4
  %81 = sext i32 %80 to i64
  %82 = getelementptr inbounds i32, i32* %79, i64 %81
  %83 = load i32, i32* %82, align 4
  %84 = load i32, i32* %17, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [5 x i32], [5 x i32]* %13, i64 0, i64 %85
  %87 = load i32, i32* %86, align 4
  %88 = add nsw i32 %83, %87
  %89 = load i32*, i32** %9, align 8
  %90 = load i32, i32* %17, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i32, i32* %89, i64 %91
  store i32 %88, i32* %92, align 4
  %93 = load i32*, i32** %9, align 8
  %94 = load i32, i32* %17, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i32, i32* %93, i64 %95
  %97 = load i32, i32* %96, align 4
  %98 = load i32, i32* %15, align 4
  %99 = sdiv i32 %97, %98
  %100 = load i32*, i32** %9, align 8
  %101 = load i32, i32* %17, align 4
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds i32, i32* %100, i64 %102
  store i32 %99, i32* %103, align 4
  br label %104

; <label>:104:                                    ; preds = %78
  %105 = load i32, i32* %17, align 4
  %106 = add nsw i32 %105, 1
  store i32 %106, i32* %17, align 4
  br label %75

; <label>:107:                                    ; preds = %75
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [5 x i32], align 16
  %3 = alloca [5 x i32], align 16
  %4 = alloca [5 x i32], align 16
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %8 = bitcast [5 x i32]* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* bitcast ([5 x i32]* @main.a to i8*), i64 20, i32 16, i1 false)
  %9 = bitcast [5 x i32]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* bitcast ([5 x i32]* @main.b to i8*), i64 20, i32 16, i1 false)
  store i32 10, i32* %5, align 4
  store i32 3, i32* %6, align 4
  store i32 5, i32* %7, align 4
  %10 = getelementptr inbounds [5 x i32], [5 x i32]* %2, i32 0, i32 0
  %11 = getelementptr inbounds [5 x i32], [5 x i32]* %3, i32 0, i32 0
  %12 = getelementptr inbounds [5 x i32], [5 x i32]* %4, i32 0, i32 0
  %13 = load i32, i32* %5, align 4
  %14 = call i32 @f_loop(i32* %10, i32* %11, i32* %12, i32 %13, i32* %6, i32* %7)
  ret i32 %14
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
