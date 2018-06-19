function plotMean(mean,CI)
    figure
    hold all
    plot(mean,'lineWidth',2) 
    plot(CI', 'r--','lineWidth',2)
    leptinlegend
    legend('Mean Leptin', '95% Confidence Intervals')
end
