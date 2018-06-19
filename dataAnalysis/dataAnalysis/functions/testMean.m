function [hT,pvalT,hT2,pvalT2]=testMean(intervention,control,type)

% does a different test based on the specified type to verify whether
    % 1 control and intervention means are different
    % 2 intervention mean is smaller than control

hT2 = NaN;
pvalT2= NaN;

if strcmp(type, 'ttest')
    disp('Using ttest')
    [hT,pvalT]=ttest(intervention, control);
        switch hT
            case 1 % the means are different 
                [hT2,pvalT2]=ttest(intervention, mean(control),'Tail', 'left');
                switch hT2
                    case 1 %mean(intervention) is smaller than mean(control)
                        disp('Intervention mean is smaller than control mean')
                        disp('with pval',num2str(pvalT2))
                    case 0
                        disp('Intervention mean is greater than control mean')
                        disp('with pval',num2str(pvalT2))
                end
            case 0 % the means are the same
                disp('The two means are the same')
                disp('with pval',num2str(pvalT))
        end
end

if strcmp(type, 'wilx')
    disp('Using Wilcoxon test')
    [hT,pvalT]=signrank(intervention, control);
        switch hT
            case 1 % the means are different 
                [hT2,pvalT2]=signrank(intervention, mean(control),'tail', 'left');
                switch hT2
                    case 1 %mean(intervention) is smaller than mean(control)
                        disp('Intervention mean is smaller than control mean')
                        disp('with pval',num2str(pvalT2))
                    case 0
                        disp('Intervention mean is greater than control mean')
                        disp('with pval',num2str(pvalT2))
                end
            case 0 % the means are the same
                disp('The two means are the same')
                disp('with pval',num2str(pvalT))
        end
    
end

end

