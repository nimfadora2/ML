%
%   TOPIC: Simple Linear Regression
%
% ------------------------------------------------------------------------

close all
clearvars

% FIXME: implement
% Reading the table nad extracting necessary information
T=readtable('boston.csv');
boston_subset = T(:,{'MEDV','LSTAT'});

% Visualizing the data
figure(1)
x=boston_subset{:,1};   % response
y=boston_subset{:,2};   

scatter(y,x);
hold on

% Create linear regr. model
lm=fitlm(y,x,'linear');
% lm2=fitlm(boston_subset,'MEDV~LSTAT') % checking if the same results
disp(lm)

% Confidence intervals
feCI=coefCI(lm)
t = linspace(0,40);
t1 = feCI(2,1)*t+feCI(1,1);
t2 = feCI(2,2)*t+feCI(1,2);

% Printing coefCI and regression line
plot(lm)
plot(t,t2,'g-')
plot(t,t1,'g-')

% Printing residual
figure(2)
plotResiduals(lm,'probability');

