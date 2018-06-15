%%% check for normality
function checkNormal(group1, group2)
    totpoints = (size(group1,1)+size(group2,1))*size(group1,2);
    % Kolmogorov-Smirnov test
    [hNormInt,p] = jbtest(reshape([group1;group2],[totpoints,1]));
    %[hNormContr,p2] = kstest(group2);
    if hNormInt==0
        name = ["JB test: Measurements are normally distributed, pval ",num2str(p)];
        disp(name)
    end
    if hNormInt==1
        name = ["JB test: Cannot assume normal distribution, pval ",num2str(p)];
        disp(name)
    end
    fprintf('\n')

    % QQ plot
    % reshape data
    tmp1 = reshape(group1,1,size(group1,1)*size(group1,2));
    tmp2 = reshape(group2,1,size(group2,1)*size(group1,2));
    
    figure
    h=qqplot([tmp1 tmp2]);
    title("All participants")
    set(gca,'fontsize',20)
    set(h, 'LineWidth',2,'Marker','x')
    
    figure
    h=qqplot(tmp1);
    title("Control Group")
    set(gca,'fontsize',20)
    set(h, 'LineWidth',2)
    
    figure
    h=qqplot(tmp2);
    title("Intervention Group")
    set(gca,'fontsize',20)
    set(h, 'LineWidth',2,'Marker','s')

% shapiro-wilk test
    [H, pValue, ~] = swtest([tmp1, tmp2], 0.05);
     if H==0
         name=["SW test: Both groups are normally distributed, pval ", num2str(pValue)];
         disp(name)
     end
     if H==1
         name=["SW test: Cannot assume normal distribution, pval ", num2str(pValue)];
         disp(name)
     end
            fprintf('\n')

end
