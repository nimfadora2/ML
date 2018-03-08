%
%   TOPIC: Multiple Linear Regression
%
% ------------------------------------------------------------------------

close all
clearvars

% Reading the table nad extracting necessary information
T=readtable('data/boston.csv');
boston_subset = T(:,{'MEDV','LSTAT','AGE'});

% Visualizing the data
figure(1)
x=boston_subset{:,1};   % response
y=boston_subset{:,2};
z=boston_subset{:,3};

scatter3(y,z,x);
hold on
%{
% Create linear regr. model
lm=fitlm(y+z,x,'linear');
display(lm)

% Plotting the surface
yfit = min(y):100:max(y);
zfit = min(z):10:max(z);

[Y,Z] = meshgrid(yfit,zfit);
% X = 
%}
% Create linear regr. model
lm=fitlm(boston_subset,'MEDV~LSTAT+AGE+LSTAT:AGE');
display(lm)

X=[ones(size(y)) y z y.*z];
b=regress(x,X);
yfit = min(y):3:max(y);
zfit = min(z):3:max(z);
[YFIT,ZFIT] = meshgrid(yfit,zfit);
XFIT = b(1) + b(2)*YFIT + b(3)*ZFIT + b(4)*YFIT.*ZFIT;
%mesh(YFIT,ZFIT,XFIT);
surf(YFIT,ZFIT,XFIT);
xlabel('LSTAT');
ylabel('AGE');
zlabel('MEDV');

mdl2 = fitlm(boston_subset,'MEDV~LSTAT+LSTAT^2')
mdl3 = fitlm(boston_subset,'MEDV~LSTAT')

tbl=anova()
