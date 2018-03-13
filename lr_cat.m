%
%   TOPIC: Linear Regression - Qualitative Predictors
%
% ------------------------------------------------------------------------

close all
clearvars

T=readtable('carseats.csv');
mdl= fitlm(T,'Sales~CompPrice+Income+Advertising+Population+Price+ShelveLoc+Age+Education+Urban+US+Income:Advertising+Price:Age')