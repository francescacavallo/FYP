function leptinlegend
ylabel('Salivary leptin (pg/ml)')
names = {'Week 0'; 'Week 2'; 'Week 4'; 'Week 6'; 'Week 8'};
set(gca,'xtick',[1:5],'xticklabel',names)
set(gca,'fontsize',20)
end
