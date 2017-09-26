#include <iostream>
#include <fstream>
#include <utility>
#include <memory>
#include <list>
#include <algorithm>

#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm-c/Core.h"

#include "ArgumentsAnalysisPass.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionAliasAnalysis.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Transforms/Scalar.h"


using namespace llvm;

//Directory used to access .ll files to process
std::string RESOURCES_DIR; 
//Directory used to store the processed files
std::string OUTPUT_DIR;

/**
 * @brief Entry point of the program. Two arguments must be passed. 
 * @param argc 
 * @param argv [1]: name of a .ll file, argv [2]: directory where [1] is located,
 *        argv [3]: name of the function to process. Must correspond to the name of a
 *        function to translate present in the C implementation in the file from which
 *        the .ll file was generated.
 * @return 0 on success, -1 on failure
 */
int main(int argc, char**argv) {
	    
    static LLVMContext context;             // LLVMContext variable
    SMDiagnostic error;                     // error message
    Module* module;                         // module to process
    
    StringRef filePathRef = argv[1];        // StringRef for the file to process
    
    //parse a llvm::Module from the .ll file 
    auto modPtr = parseAssemblyFile(filePathRef,error,context);
    
    module = (Module*)modPtr.get();
    
    llvm::legacy::PassManager passManager;
    passManager.add(new func_analysis::ArgumentAnalysisPass());
    passManager.run(*module);
    
    return 0;
}