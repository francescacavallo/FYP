function [similarControl_leptin,similarInter_leptin] = LeptinByGroup(baseline,Measurements,type)
clc 
close all
clear leg
%
week = 1:5;
similarControl_leptin = zeros(11,5);
subplot(1,2,1)
i=1;
for n=1:11
    bool = condition(baseline(n),type);
    if bool && sum(isnan([Measurements(n).Leptin]))<4
        similarControl_leptin(n,:)= [Measurements(n).Leptin];
        Xi = 1:0.1:5;
        Yi = pchip(week,similarControl_leptin(n,:),Xi);
        plot(Xi,Yi,'LineWidth',2)
        hold on
        title('Control')
        leg{i}=num2str(baseline(n).Code); i=i+1;
        leptinlegend
    end
end
%legend(leg) 
clear leg

subplot(1,2,2)
similarInter_leptin = zeros(12,5);
i=1;
for n=12:23
    bool = condition(baseline(n),type);
    if bool && sum(isnan([Measurements(n).Leptin]))<4
        similarInter_leptin(n-11,:)= [Measurements(n).Leptin];
        Xi = 1:0.1:5;
        Yi = pchip(week,similarInter_leptin(n-11,:),Xi);
        plot(Xi,Yi,'LineWidth',2)
        hold on
        title('Intervention')
        leptinlegend
        leg{i}=num2str(baseline(n).Code); i=i+1;
        leptinlegend
    end
end
%legend(leg)

end

