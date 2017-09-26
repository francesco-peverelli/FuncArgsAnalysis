; ModuleID = 'f_loop.c'
source_filename = "f_loop.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.a = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 16
@main.b = private unnamed_addr constant [5 x i32] [i32 10, i32 20, i32 30, i32 40, i32 50], align 16

; Function Attrs: noinline nounwind uwtable
define void @evil_func(i32*, i32*) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %5, align 4
  br label %6

; <label>:6:                                      ; preds = %19, %2
  %7 = load i32, i32* %5, align 4
  %8 = icmp slt i32 %7, 5
  br i1 %8, label %9, label %22

; <label>:9:                                      ; preds = %6
  %10 = load i32*, i32** %3, align 8
  %11 = load i32, i32* %5, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, i32* %10, i64 %12
  %14 = load i32, i32* %13, align 4
  %15 = load i32*, i32** %4, align 8
  %16 = load i32, i32* %15, align 4
  %17 = add nsw i32 %14, %16
  %18 = load i32*, i32** %4, align 8
  store i32 %17, i32* %18, align 4
  br label %19

; <label>:19:                                     ; preds = %9
  %20 = load i32, i32* %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %5, align 4
  br label %6

; <label>:22:                                     ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @f_loop(i32*, i32*, i32*, i32*, i32*, i32*) #0 {
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca i32*, align 8
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
  store i32* %3, i32** %10, align 8
  store i32* %4, i32** %11, align 8
  store i32* %5, i32** %12, align 8
  store i32 103, i32* %15, align 4
  store i32 0, i32* %16, align 4
  br label %18

; <label>:18:                                     ; preds = %75, %6
  %19 = load i32, i32* %16, align 4
  %20 = icmp slt i32 %19, 5
  br i1 %20, label %21, label %78

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
  %40 = load i32*, i32** %10, align 8
  %41 = load i32, i32* %40, align 4
  %42 = mul nsw i32 %39, %41
  %43 = load i32*, i32** %10, align 8
  %44 = load i32, i32* %43, align 4
  %45 = add nsw i32 %42, %44
  %46 = load i32, i32* %16, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [5 x i32], [5 x i32]* %14, i64 0, i64 %47
  store i32 %45, i32* %48, align 4
  %49 = load i32, i32* %16, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds [5 x i32], [5 x i32]* %14, i64 0, i64 %50
  %52 = load i32, i32* %51, align 4
  %53 = load i32*, i32** %9, align 8
  %54 = load i32, i32* %16, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds i32, i32* %53, i64 %55
  %57 = load i32, i32* %56, align 4
  %58 = sdiv i32 %52, %57
  %59 = load i32*, i32** %9, align 8
  %60 = load i32, i32* %16, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds i32, i32* %59, i64 %61
  store i32 %58, i32* %62, align 4
  %63 = load i32*, i32** %10, align 8
  %64 = load i32, i32* %63, align 4
  %65 = load i32*, i32** %11, align 8
  %66 = load i32, i32* %65, align 4
  %67 = add nsw i32 %64, %66
  %68 = load i32*, i32** %12, align 8
  store i32 %67, i32* %68, align 4
  %69 = load i32*, i32** %10, align 8
  %70 = load i32, i32* %69, align 4
  %71 = load i32*, i32** %12, align 8
  %72 = load i32, i32* %71, align 4
  %73 = mul nsw i32 %70, %72
  %74 = load i32*, i32** %11, align 8
  store i32 %73, i32* %74, align 4
  br label %75

; <label>:75:                                     ; preds = %21
  %76 = load i32, i32* %16, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, i32* %16, align 4
  br label %18

; <label>:78:                                     ; preds = %18
  store i32 0, i32* %17, align 4
  br label %79

; <label>:79:                                     ; preds = %108, %78
  %80 = load i32, i32* %17, align 4
  %81 = icmp slt i32 %80, 5
  br i1 %81, label %82, label %111

; <label>:82:                                     ; preds = %79
  %83 = load i32*, i32** %7, align 8
  %84 = load i32, i32* %17, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds i32, i32* %83, i64 %85
  %87 = load i32, i32* %86, align 4
  %88 = load i32, i32* %17, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [5 x i32], [5 x i32]* %13, i64 0, i64 %89
  %91 = load i32, i32* %90, align 4
  %92 = add nsw i32 %87, %91
  %93 = load i32*, i32** %9, align 8
  %94 = load i32, i32* %17, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i32, i32* %93, i64 %95
  store i32 %92, i32* %96, align 4
  %97 = load i32*, i32** %9, align 8
  %98 = load i32, i32* %17, align 4
  %99 = sext i32 %98 to i64
  %100 = getelementptr inbounds i32, i32* %97, i64 %99
  %101 = load i32, i32* %100, align 4
  %102 = load i32, i32* %15, align 4
  %103 = sdiv i32 %101, %102
  %104 = load i32*, i32** %9, align 8
  %105 = load i32, i32* %17, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds i32, i32* %104, i64 %106
  store i32 %103, i32* %107, align 4
  br label %108

; <label>:108:                                    ; preds = %82
  %109 = load i32, i32* %17, align 4
  %110 = add nsw i32 %109, 1
  store i32 %110, i32* %17, align 4
  br label %79

; <label>:111:                                    ; preds = %79
  %112 = load i32*, i32** %7, align 8
  %113 = load i32*, i32** %10, align 8
  call void @evil_func(i32* %112, i32* %113)
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
  %13 = call i32 @f_loop(i32* %10, i32* %11, i32* %12, i32* %5, i32* %6, i32* %7)
  ret i32 %13
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.0 (tags/RELEASE_400/final)"}
