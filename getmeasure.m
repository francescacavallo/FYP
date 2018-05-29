function [Control, Intervention]=getmeasure(Measurements,type)
nParticipants = 23;

switch type
    case 'leptin'
        for sample = 1:5
            for i=1:11 % retrieve leptin
                tmp = Measurements(i).Leptin;
                Control(i,sample) = tmp(sample);
            end
            for i=12:nParticipants 
                tmp = Measurements(i).Leptin;
                Intervention(i-11,sample) = tmp(sample);
            end 
        end
    case 'weightW'
        for sample = 1:5
            for i=1:11 % retrieve leptin
                tmp = Measurements(i).WeightWeek;
                Control(i,sample) = tmp(sample);
            end
            for i=12:nParticipants 
                tmp = Measurements(i).WeightWeek;
                Intervention(i-11,sample) = tmp(sample);
            end 
        end
    case 'weightF'
        for sample = 1:5
            for i=1:11 % retrieve leptin
                tmp = Measurements(i).WeightFortn;
                Control(i,sample) = tmp(sample);
            end
            for i=12:nParticipants 
                tmp = Measurements(i).WeightFortn;
                Intervention(i-11,sample) = tmp(sample);
            end 
        end
    case 'caloriesW'
        for sample = 1:5
            for i=1:11 % retrieve leptin
                tmp = Measurements(i).CaloriesWeek;
                Control(i,sample) = tmp(sample);
            end
            for i=12:nParticipants 
                tmp = Measurements(i).CaloriesWeek;
                Intervention(i-11,sample) = tmp(sample);
            end 
        end
    case 'caloriesF'
        for sample = 1:5
            for i=1:11 % retrieve leptin
                tmp = Measurements(i).CaloriesFortn;
                Control(i,sample) = tmp(sample);
            end
            for i=12:nParticipants 
                tmp = Measurements(i).CaloriesFortn;
                Intervention(i-11,sample) = tmp(sample);
            end 
        end
end
end



