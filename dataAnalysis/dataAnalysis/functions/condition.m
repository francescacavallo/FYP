function [bool] = condition(variable,type)
switch type
    
    case 1 %females GG
        bool =  (variable.genderID==2) * (variable.genotypeID==1); 
        
    case 2  %females GC
        bool =  (variable.genderID==2) * (variable.genotypeID==2);
        
    case 3 %females
        bool = (variable.genderID==2);
        
    case 4 % males
        bool = (variable.genderID==1);
        
    case 5 %% GG
        bool = (variable.genotypeID==1);
        
    case 6 %% CG
        bool = (variable.genotypeID==2);
        
    case 7 %% CC
        bool = (variable.genotypeID==3);
        
    case 8 %normal weight
        bool = variable.BMI<25 && variable.BMI>18.5;
        
    case 9 %overweight
        bool = variable.BMI>25;
        
    case 10 % underweigth
        bool = variable.BMI<18.5;
        
    case 11 %males GG
        bool =  (variable.genderID==1) * (variable.genotypeID==1);

    case 12 %males GC
        bool =  (variable.genderID==1) * (variable.genotypeID==2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    case 13 % BMI between 18.5 and 25 (normal weight)& male & genotype GG
        bool = (variable.BMI<25 && variable.BMI>18.5) && (variable.genderID==1)...
               && (variable.genotypeID==1);
           
    case 14 % BMI between >25 (overweight)& male & genotype GG
        bool = (variable.BMI>25) && (variable.genderID==1)...
               && (variable.genotypeID==1);
           
    case 15 % BMI between 18.5 and 25 (normal weight)& female & genotype GG
        bool = (variable.BMI<25 && variable.BMI>18.5) && (variable.genderID==2)...
               && (variable.genotypeID==1);
           
    case 16 % BMI between > 25 (overweight)& female & genotype GG
        bool = (variable.BMI>25) && (variable.genderID==2)...
               && (variable.genotypeID==1);
           
    case 17 % BMI between 18.5 and 25 (normal weight)& male & genotype GC
        bool = (variable.BMI<25 && variable.BMI>18.5) && (variable.genderID==1)...
               && (variable.genotypeID==2);
           
    case 18 % BMI between >25 (overweight)& male & genotype GC
        bool = (variable.BMI>25) && (variable.genderID==1)...
               && (variable.genotypeID==2);
           
    case 19 % BMI between 18.5 and 25 (normal weight)& female & genotype GC
        bool = (variable.BMI<25 && variable.BMI>18.5) && (variable.genderID==2)...
               && (variable.genotypeID==2);
           
    case 20 % BMI between > 25 (overweight)& female & genotype GC
        bool = (variable.BMI>25) && (variable.genderID==2)...
               && (variable.genotypeID==2);
end



end

