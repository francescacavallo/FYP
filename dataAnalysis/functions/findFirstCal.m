function firstCal = findFirstCal(FFQ)
missing=ones(23,1);
missing(17)=0;
missing(22)=0;
firstCal=zeros(23,1);
i=1;
while sum(missing)~=0
    for n=1:23
        if ~isnan(FFQ{i}{n,44})&& missing(n)==1
            firstCal(n) = FFQ{i}{n,44};
            missing(n) = 0;   
        end
    end
    i=i+1;
end

end
