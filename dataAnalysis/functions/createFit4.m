function [pd1,pd2] = createFit4(arg_1,arg_2)
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2] = CREATEFIT(ARG_1,ARG_2)
%   Creates a plot, similar to the plot in the main distribution fitter
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  2
%   Number of fits:  2
%
%   See also FITDIST.

% This function was automatically generated on 15-Jun-2018 11:30:16

% Output fitted probablility distributions: PD1,PD2

% Data from dataset "leptinControl(:,1) data":
%    Y = arg_1 (originally leptinControl(:,1))

% Data from dataset "leptinIntervention(:,1) data":
%    Y = arg_2 (originally leptinIntervention(:,1))

% Force all inputs to be column vectors
arg_1 = arg_1(:);
arg_2 = arg_2(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "leptinControl(:,1) data"
[CdfY,CdfX] = ecdf(arg_1,'Function','cdf');  % compute empirical cdf
hLine = stairs(CdfY,[CdfX(2:end);CdfX(end)],'Color',[0.333333 0 0.666667],'LineStyle','-', 'LineWidth',1);
xlabel('Probability');
ylabel('Quantile')
LegHandles(end+1) = hLine;
LegText{end+1} = 'leptinControl(:,1) data';

% --- Plot data originally in dataset "leptinIntervention(:,1) data"
[CdfY,CdfX] = ecdf(arg_2,'Function','cdf');  % compute empirical cdf
hLine = stairs(CdfY,[CdfX(2:end);CdfX(end)],'Color',[0.333333 0.666667 0],'LineStyle','-', 'LineWidth',1);
xlabel('Probability');
ylabel('Quantile')
LegHandles(end+1) = hLine;
LegText{end+1} = 'leptinIntervention(:,1) data';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "Fit Control"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('normal',[ 0.3400403767201, 0.2449772649593])
pd1 = fitdist(arg_1, 'normal');
[YPlot,YLower,YUpper] = icdf(pd1,XGrid,0.05);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
if ~isempty(YLower)
    hBounds = plot([XGrid(:); NaN; XGrid(:)], [YLower(:); NaN; YUpper(:)],'Color',[1 0 0],...
        'LineStyle',':', 'LineWidth',1,...
        'Marker','none');
end
LegHandles(end+1) = hLine;
LegText{end+1} = 'Fit Control';
LegHandles(end+1) = hBounds;
LegText{end+1} = '95% confidence bounds';

% --- Create fit "Fit Intervention"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd2 = ProbDistUnivParam('normal',[ 0.3653570091973, 0.1893231353856])
pd2 = fitdist(arg_2, 'normal');
[YPlot,YLower,YUpper] = icdf(pd2,XGrid,0.05);
hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
if ~isempty(YLower)
    hBounds = plot([XGrid(:); NaN; XGrid(:)], [YLower(:); NaN; YUpper(:)],'Color',[0 0 1],...
        'LineStyle',':', 'LineWidth',1,...
        'Marker','none');
end
LegHandles(end+1) = hLine;
LegText{end+1} = 'Fit Intervention';
LegHandles(end+1) = hBounds;
LegText{end+1} = '95% confidence bounds';

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9);
set(hLegend,'Units','normalized');
Position = get(hLegend,'Position');
Position(1:2) = [0.462054,0.662548];
set(hLegend,'Interpreter','none','Position',Position);
