%
%   TOPIC: Simple Linear Regression
%
% ------------------------------------------------------------------------

close all
clearvars

% FIXME: implement
% Reading the table nad extracting necessary information
T=readtable('data/boston.csv');
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

% Printing coefCI and regression line
plot(lm)

% Printing residual
figure(2)
plotResiduals(lm,'probability');

