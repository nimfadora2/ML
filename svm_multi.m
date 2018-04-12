%
%   TOPIC: Multiclass Support Vector Machines
%
% ------------------------------------------------------------------------

close all
clearvars

%% Load data.

load fisheriris
X = meas(:, 1:2);
Y = species;

%% Fit a model.

rng(1); % For reproducibility

t = templateSVM('Standardize',1);
Mdl = fitcecoc(X,Y,'Learners',t,'FitPosterior',1,...
    'ClassNames',{'setosa','versicolor','virginica'},...
    'Verbose',2);
Mdl.CodingMatrix

%% Visualize data and the model.
d = 0.1; % Step size of the grid

[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));       % The grid

[~,~,~,PosteriorRegion] = predict(Mdl,[x1Grid(:),x2Grid(:)]);


figure(1)
gh = gscatter(X(:,1),X(:,2),Y,'rgb','oxd',8);
hold on

contour(x1Grid,x2Grid,...
        reshape(max(PosteriorRegion,[],2),size(x1Grid,1),size(x1Grid,2)));
