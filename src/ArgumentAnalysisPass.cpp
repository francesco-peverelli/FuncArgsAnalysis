#include <vector>
#include <iostream>

#include "ArgumentsAnalysisPass.h" 

using namespace func_analysis;

ArgumentAnalysisPass* func_analysis::createArgumentAnalysisWrapperPass(){

    return new ArgumentAnalysisPass::ArgumentAnalysisPass(); 
}

ArgumentAnalysisPass::ArgumentType ArgumentAnalysisPass::sumFlag(ArgumentType a1, ArgumentType a2)
{
    return (ArgumentAnalysisPass::ArgumentType)((int)a1 | (int)a2);
}

bool ArgumentAnalysisPass::isNotDecidable(ArgumentType a)
{
    return ((ArgumentAnalysisPass::ArgumentType)((int)a & (int)ArgumentType::N) == ArgumentType::N);
}

ArgumentAnalysisPass::ArgumentType ArgumentAnalysisPass::turnDecided(ArgumentType a1)
{
    return (ArgumentAnalysisPass::ArgumentType)((int)ArgumentType::RW & (int)a1);
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
                case ArgumentType::W:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : writeonly\n";
                    break;
                case ArgumentType::RW:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : readwrite\n";
                    break;
                case ArgumentType::N:
                   llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : not decidable\n";
                   break;
                case ArgumentType::NR:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : ND readonly\n";
                    break;
                case ArgumentType::NW:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : ND writeonly\n";
                    break;
                case ArgumentType::NRW:
                    llvm::errs() << "\t" << std::distance(it->second.begin(),it_2) << " : ND readwrite\n";
                    break;
            }
        }
    }
}

void ArgumentAnalysisPass::analyzeArguments(llvm::Function &F) {
        
    ArgsVector argumentsVector;

    if(F.isDeclaration()){
        for(llvm::Argument &a : F.args()){
            argumentsVector.push_back(ArgumentType::RW);
        }
        functionsMapping.insert(std::pair<std::string,ArgsVector>(F.getName(),argumentsVector));
        return;
    }

    for(llvm::Argument &arg : F.args())
    {
        argumentsVector.push_back(ArgumentType::U);

        for(llvm::User* user : arg.users())
        {
            if(llvm::Instruction* userAsInstr = llvm::dyn_cast<llvm::Instruction>(user))
            {
                if(userAsInstr->getOpcodeName() == std::string("getelementptr"))
                {
                    llvm::Instruction * getElemPtr = userAsInstr;
                    while(getElemPtr->getOpcodeName() == std::string("getelementptr")) {
                        bool hasBeenAssigned = false;
                        for(llvm::User *pointerUser : getElemPtr->users()) {
                            if (llvm::Instruction *pointerAsInstruction = llvm::dyn_cast<llvm::Instruction>(pointerUser)) {
                                if (pointerAsInstruction->getOpcodeName() == std::string("getelementptr")) {
                                    getElemPtr = pointerAsInstruction;
                                    hasBeenAssigned = true;
                                } else {
                                    hasBeenAssigned = false;
                                }
                            }
                        }
                        if(!hasBeenAssigned)
                            break;
                    }

                    userAsInstr = getElemPtr;
                    for(llvm::User* pointerUser : userAsInstr->users())
                    {
                        if(llvm::Instruction* pointerUserAsInstr = llvm::dyn_cast<llvm::Instruction>(pointerUser))
                        {
                            if (pointerUserAsInstr->getOpcodeName() == std::string("store") && pointerUserAsInstr->getOperand(1) == userAsInstr)
                            {
                                argumentsVector.at(arg.getArgNo()) = sumFlag(argumentsVector.at(arg.getArgNo()), ArgumentType::W);
                            }
                            else
                            {
                                argumentsVector.at(arg.getArgNo()) = sumFlag(argumentsVector.at(arg.getArgNo()), ArgumentType::R);
                            }
                        }
                    }

                }
                else if(userAsInstr->getOpcodeName() == std::string("store") && userAsInstr->getOperand(1) == llvm::dyn_cast<llvm::Value>(&arg))
                {
                    argumentsVector.at(arg.getArgNo()) = sumFlag(argumentsVector.at(arg.getArgNo()), ArgumentType::W);
                }
                else if(userAsInstr->getOpcodeName() == std::string("call"))
                {
                    argumentsVector.at(arg.getArgNo()) = sumFlag(argumentsVector.at(arg.getArgNo()), ArgumentType::N);
                }else
                {
                    argumentsVector.at(arg.getArgNo()) = sumFlag(argumentsVector.at(arg.getArgNo()), ArgumentType::R);
                }
            }
        }
    }

    functionsMapping.insert(std::pair<std::string,ArgsVector>(F.getName(),argumentsVector));

    return;
}

void ArgumentAnalysisPass::resolveNonDecidable()
{
    for(auto it=functionsMapping.begin(); it != functionsMapping.end(); ++it)
    {
        llvm::Function *F = module->getFunction(it->first);
        for(auto it_2 = it->second.begin(); it_2 != it->second.end(); ++it_2)
        {
            if(isNotDecidable(*it_2))
            {
                std::vector<ArgPosition> argPositions;
                argPositions.push_back(ArgPosition(F->getName(),std::distance(it->second.begin(),it_2)));
                *it_2 = resolveArgumentType(argPositions, *it_2);
                argPositions.pop_back();
            }
        }
    }
}

ArgumentAnalysisPass::ArgumentType ArgumentAnalysisPass::resolveArgumentType(std::vector<ArgPosition> &callVector, ArgumentType currentType)
{
    std::string functionName = callVector.back().first;
    llvm::Function *function = module->getFunction(functionName);

    ArgsVector *argsVector = &(functionsMapping[functionName]);
    ArgumentType argType = argsVector->at(callVector.back().second);

    if( currentType == ArgumentType::NRW) {
        return ArgumentType::RW;
    }

    if(callVector.size() > 1 && callVector.at(0)==callVector.back()) {
        turnDecided(argType);
    }

    if(!isNotDecidable(argType)) {
        return sumFlag(currentType, argType);
    }

    llvm::Argument *arg;

    int i=0;
    for (llvm::Argument &a : function->args()) {
        if(i==callVector.back().second)
            arg = &a;
        i++;
    }

    for (llvm::User *user : arg->users()) {
        if (llvm::Instruction *userAsInstr = llvm::dyn_cast<llvm::Instruction>(user)) {
            if (userAsInstr->getOpcodeName() == std::string("call")) {
                llvm::Function *calledFunction = llvm::dyn_cast<llvm::CallInst>(userAsInstr)->getCalledFunction();
                std::string calledFunctionName = calledFunction->getName();
                for(auto it = userAsInstr->operands().begin(); it != userAsInstr->operands().end(); ++it) {
                    llvm::Value * a = llvm::dyn_cast<llvm::Value>(arg);
                    if(*it == a) {
                        int opPos = std::distance(userAsInstr->operands().begin(),it);
                        callVector.push_back(ArgPosition(calledFunctionName, opPos));
                        currentType = sumFlag(currentType, resolveArgumentType(callVector, currentType));
                        callVector.pop_back();
                    }
                }
            }
        }
    }

    return turnDecided(currentType);
}

bool ArgumentAnalysisPass::runOnModule(llvm::Module &M){

    module = &M;

    for(llvm::Function &F : M.functions())
    {
        llvm::legacy::FunctionPassManager* functionPassManager = new llvm::legacy::FunctionPassManager(&M);
    
        llvm::ScalarEvolutionWrapperPass* scevPassRef = new llvm::ScalarEvolutionWrapperPass();    
        llvm::LoopInfoWrapperPass* loopInfoPassRef = new llvm::LoopInfoWrapperPass();

        //The pass manager is used to run the preliminary LLVM passes on the .ll file,
        
        functionPassManager->add(llvm::createPromoteMemoryToRegisterPass());    // -mem2reg
        functionPassManager->add(loopInfoPassRef);                              // -loops
        functionPassManager->add(scevPassRef);                                  // -scalar-evolution
        
        functionPassManager->run(F);
        
        analyzeArguments(F);

    }

    resolveNonDecidable();

    printFunctionMap();

    return false;

}

void ArgumentAnalysisPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
    
    AU.setPreservesAll();
}

