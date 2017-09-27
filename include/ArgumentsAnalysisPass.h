#ifndef ARGUMENTANALYSISPASS_H
#define ARGUMENTANALYSISPASS_H

#include "llvm-c/Core.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionAliasAnalysis.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Transforms/Scalar.h"

namespace func_analysis{

    class ArgumentAnalysisPass : public llvm::ModulePass{
    
    char ID = 0;
    
    enum class ArgumentType { U = 0, R = 1, W = 2, RW = 3, N = 4, NR = 5, NW = 6, NRW = 7 };
    
    typedef std::vector<ArgumentType> ArgsVector;
    typedef std::map<std::string,ArgsVector> FunMap;
    
    FunMap functionsMapping;
        
    public:
        
        ArgumentAnalysisPass() : llvm::ModulePass(ID){}

        bool runOnModule(llvm::Module &M) override;
        
        void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;
        
    private:
        
        void analyzeArguments(llvm::Function &F);
        
        void printFunctionMap();

        ArgumentType sumFlag(ArgumentType a1, ArgumentType a2);
    };

    ArgumentAnalysisPass* createArgumentAnalysisWrapperPass();

}

#endif