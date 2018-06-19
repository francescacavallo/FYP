function MyAnova(similarControl_leptin,similarInter_leptin,baseline,idxC,idxI)

    vec=[similarControl_leptin;similarInter_leptin];
    group = [[baseline(idxC).Group]';[baseline(11+idxI).Group]']';
    [anova.p, anova.table, anova.stats] = anova1(vec,group);
    set(findobj(gca,'type','line'),'linew',2)
    set(gca,'fontsize',20)
    figure
    [mult_com.c, mult_com.m, mult_com.h, mult_com.nms] = multcompare(anova.stats,'alpha',.05,'ctype','bonferroni');
    set(findobj(gca,'type','line'),'linew',2)
    set(gca,'fontsize',20)
    
end

