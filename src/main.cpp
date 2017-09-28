#include <iostream>
#include <fstream>
#include <utility>
#include <memory>
#include <list>
#include <algorithm>

#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Linker/Linker.h"

#include "ArgumentsAnalysisPass.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/Support/SourceMgr.h"

using namespace llvm;

/**
 * @brief Entry point of the program. Two arguments must be passed. 
 * @param argc 
 * @param argv [1]: name of a /path/to/file.ll file
 *        argv [3]: name of the function to process. Must correspond to the name of a
 *        function to translate present in the C implementation in the file from which
 *        the .ll file was generated.
 * @return 0 on success, -1 on failure
 */
int main(int argc, char**argv) {
	    
    static LLVMContext context;             // LLVMContext variable
    SMDiagnostic error;                     // error message
    Module* module;                         // module to process

    if(argc < 2)
    {
        llvm::errs() << "Expected a path and at least one .ll file...\n";
        return -1;
    }
    
    std::string filePathRef = argv[1];        // StringRef for the file to process

    //parse a llvm::Module from the .ll file
    std::string firstModule = filePathRef + argv[2];
    auto modPtr = parseAssemblyFile(firstModule,error,context);
    
    module = (Module*)modPtr.get();

    for(int i = 3; i < argc; i++)
    {
        std::string modulePath = filePathRef + argv[i];
        llvm::Linker::linkModules(*module,parseAssemblyFile(modulePath,error,context));
    }

    llvm::legacy::PassManager passManager;
    passManager.add(new func_analysis::ArgumentAnalysisPass());
    passManager.run(*module);
    
    return 0;
}