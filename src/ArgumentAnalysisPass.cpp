#include <vector>
#include <iostream>

#include "ArgumentsAnalysisPass.h" 

using namespace func_analysis;

ArgumentAnalysisPass* func_analysis::createArgumentAnalysisWrapperPass(){

    return new ArgumentAnalysisPass::ArgumentAnalysisPass(); 
}

void ArgumentAnalysisPass::printFunctionMap(){
    
    for(auto it = functionsMapping.begin(); it != functionsMapping.end(); ++it)
    {
        llvm::errs() << "\nName : " << it->first << "\n";
        
        for(auto it_2 = it->second.begin(); it_2 != it->second.end(); ++it_2)
        {
            
           switch(*it_2){
                
                case ArgumentType::U:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : unused\n";
                    break;
                case ArgumentType::R:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : readonly\n";
                    break;
                case ArgumentType::RW:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : readwrite\n";
                    break;
                case ArgumentType::W:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : writeonly\n";
                    break;
                default:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : UNNIDENTIFIED\n";
            }
        }
    }
}

void ArgumentAnalysisPass::analyzeArguments(llvm::Function &F) {
        
        ArgsVector argumentsVector;
        
        for(llvm::Argument &arg : F.args())
        {
            
            if(arg.users().begin() == arg.users().end()){
                argumentsVector.push_back(ArgumentType::U);
            }else{
                argumentsVector.push_back(ArgumentType::R);
            }
                
            for(llvm::User* user : arg.users())
            {

                if(llvm::Instruction* userAsInstr = llvm::dyn_cast<llvm::Instruction>(user))
                {
                    if(userAsInstr->getOpcodeName() == std::string("getelementptr"))
                    {
                        //Offset based access case
                        for(llvm::User* pointerUser : userAsInstr->users())
                        {
                            if(llvm::Instruction* pointerUserAsInstr = llvm::dyn_cast<llvm::Instruction>(pointerUser))
                                if(pointerUserAsInstr->getOpcodeName() == std::string("store") &&
                                    pointerUserAsInstr->getOperand(1) == userAsInstr)
                                {
                                    if(argumentsVector.at(arg.getArgNo()) == ArgumentType::R)
                                        argumentsVector.at(arg.getArgNo()) = ArgumentType::RW;
                                    else
                                        argumentsVector.at(arg.getArgNo()) = ArgumentType::W; 
                                }
                        }
                        
                    }else{
                        
                        //Scalar access case
                        if(userAsInstr->getOpcodeName() == std::string("store") &&
                            userAsInstr->getOperand(1) == llvm::dyn_cast<llvm::Value>(&arg))
                        {
                            if(argumentsVector.at(arg.getArgNo()) == ArgumentType::R)
                                argumentsVector.at(arg.getArgNo()) = ArgumentType::RW;
                            else
                                argumentsVector.at(arg.getArgNo()) = ArgumentType::W;
                        }
                    }
                    
                }
                        
            }

            
        }
        
 
        functionsMapping.insert(std::pair<std::string,ArgsVector>(F.getName(),argumentsVector));
        return;
}

bool ArgumentAnalysisPass::runOnModule(llvm::Module &M){
    
    for(llvm::Function &F : M.functions())
    {
        llvm::legacy::FunctionPassManager* functionPassManager = new llvm::legacy::FunctionPassManager(&M);
    
        llvm::ScalarEvolutionWrapperPass* scevPassRef = new llvm::ScalarEvolutionWrapperPass();    
        llvm::LoopInfoWrapperPass* loopInfoPassRef = new llvm::LoopInfoWrapperPass();

        //The pass manager is used to run the preliminary LLVM passes on the .ll file,
        //and the OXiGen custom pass
        
        functionPassManager->add(llvm::createPromoteMemoryToRegisterPass());    // -mem2reg
        functionPassManager->add(loopInfoPassRef);                              // -loops
        functionPassManager->add(scevPassRef);                                  // -scalar-evolution
        
        functionPassManager->run(F);
        
        F.dump();
        
        analyzeArguments(F);
    }
    
    printFunctionMap();
    return false;

}

void ArgumentAnalysisPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
    
    AU.setPreservesAll();
}

