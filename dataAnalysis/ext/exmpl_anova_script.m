% Aassuming data is a 8x4 matrix for example of N1 latency, extarcted from the big results structure 
data = ones(8,4);
num_cond = 4;
num_animals = 8;

%%%% 1. preppare vectors
vec = [];
for m = 1:num_cond
    if m==1
        vec = data(:,m);   
    else
        vec = [vec; data(:,m)];
    end
end
group = ['A'; 'A'; 'A'; 'A'; 'A'; 'A'; 'A'; 'A';...
    'B'; 'B'; 'B'; 'B'; 'B'; 'B'; 'B'; 'B';...
    'C'; 'C'; 'C'; 'C'; 'C'; 'C'; 'C'; 'C';...
    'D'; 'D'; 'D'; 'D'; 'D'; 'D'; 'D'; 'D';...
    ];

%%%% 2. run ANOVA
[anova.p, anova.table, anova.stats] = anova1(vec,group);

%%%% 3. run multipule comparison analysis 
% compute t-test between each two groups. 'mult_com.c' is the table of interest
figure;
[mult_com.c, mult_com.m, mult_com.h, mult_com.nms] = multcompare(anova.stats,'alpha',.05,'ctype','bonferroni');

%%%% 4. save vectors
save(['N1_latency_anova','.mat'],'anova');
save(['N1_latency_multi_comp','.mat'],'mult_com');
