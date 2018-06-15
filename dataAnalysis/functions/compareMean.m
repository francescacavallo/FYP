function [hT,pvalT,ci,stats]=compareMean(group1,group2,type)
% compare the means of the two groups using either t-test of wilcoxon
% signed-rank test, depending on the underlying distribution
% inputs: two groups under test adn type (paired or 2sample)
% outputs:
        % h = 0 if cannot reject null hypothesis, 1 otherwise
        % pval = p value of decision

% check for normality
%hNormInt = kstest(group1);
%hNormContr = kstest(group2);

% if samples in intervention are from normal distribution use t test
%if hNormInt+hNormContr==0
    % plot cdf of intervention vs cdf of normal distribution 
    % plotcdf(group1);   
    % check if and how the two means are different
    [hT,pvalT,ci, stats]=testMean(group1, group2,type);
    
%end



%%%%%% not sure about wilcoxon : wait to see the data and then decide
% wilcoxon otherwise
%if hNormInt*hNormContr==1
  %[hT,pvalT,hT2,pvalT2]=testMean(intervention, control,'wilx');
%end
        
        
end


%%%%%% internal functions %%%%%%
function plotcdf(intervention)
[f,x_values] = ecdf(intervention);
    figure
    F = plot(x_values,f);
    set(F,'LineWidth',2);
    hold on;
    G = plot(x_values,normcdf(x_values,0,1),'r-');
    set(G,'LineWidth',2);
    legend([F G],...
        'Empirical CDF','Standard Normal CDF',...
        'Location','SE');
    set(gca,'fontsize',12)
end


function [hT,pvalT,ci, stats]=testMean(intervention,control,type)

% does a different test based on the specified type to verify whether
    % 1 control and intervention means are different
    % 2 intervention mean is smaller than control

if strcmp(type, '2sample')
    [hT,pvalT,ci, stats]=ttest2(intervention, control);
        switch hT
            case 1 % the means are different 
                disp('The two means are different')
                name=['with pval ',num2str(pvalT)];
                disp(name)
                
                [hT_left,pvalT_left]=ttest2(intervention, mean(control),'Tail', 'left');
                switch hT_left
                    case 1 %mean(intervention) is smaller than mean(control)
                        disp('Intervention mean is smaller than control mean')
                        name = ['with pval ',num2str(pvalT_left)];
                        disp(name)
                    case 0
                        [~,pvalT_right]=ttest2(intervention, mean(control),'Tail', 'right');
                        disp('Intervention mean is greater than control mean')
                        name = ['with pval ',num2str(pvalT_right)];
                        disp(name)
                end
                
            case 0 % the means are the same
                disp('The two means are the same')
                name=['with pval ',num2str(pvalT)];
                disp(name)
        end
end

if strcmp(type, 'paired')
    [hT,pvalT,ci,stats]=ttest(intervention, control);
        switch hT
            case 1 % the means are different 
                disp('The two means are different')
                name=['with pval ',num2str(pvalT)];
                disp(name)
                
                [hT_left,pvalT_left]=ttest(intervention, mean(control),'tail', 'left');
                switch hT_left
                    case 1 %mean(intervention) is smaller than mean(control)
                        disp('Firs mean is smaller than second mean')
                        name = ['with pval ',num2str(pvalT_left)];
                        disp(name)
                    case 0
                        [~,pvalT_right]=ttest(intervention, mean(control),'tail', 'right');
                        disp('First mean is greater than second mean')
                        name = ['with pval ',num2str(pvalT_right)];
                        disp(name)
                end
            case 0 % the means are the same
                disp('The two means are the same')
                name = ['with pval ',num2str(pvalT)];
                disp(name)
        end
    
end

end
