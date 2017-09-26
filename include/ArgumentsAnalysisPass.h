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
    
    enum class ArgumentType { R = 0, RW = 1, W = 2, U = 3};
    
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
    };

    ArgumentAnalysisPass* createArgumentAnalysisWrapperPass();

}

#endif