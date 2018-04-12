%
%   TOPIC: Support Vector Machines
%
% ------------------------------------------------------------------------

close all
clearvars

%% Generate data.

rng(1); % For reproducibility

n_cls = 100; % Number of samples in each class.

r = sqrt(rand(n_cls,1)); % Radius
t = 2 * pi * rand(n_cls,1);  % Angle
X_cls1 = [r .* cos(t), r .* sin(t)]; % Points

r2 = sqrt(3 * rand(n_cls,1) + 1); % Radius
t2 = 2 * pi * rand(n_cls,1);      % Angle
X_cls2 = [r2 .* cos(t2), r2 .* sin(t2)]; % points

X = vertcat(X_cls1, X_cls2);
Y = vertcat(-1 * ones(n_cls,1), +1 * ones(n_cls,1));

%% Fit a model.

Mdl = fitcsvm(X,Y,'KernelFunction','rbf','BoxConstraint',Inf);

%% Visualize data and the model.

d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(Mdl,xGrid);

figure;
h(1:2) = gscatter(X(:,1),X(:,2),Y,'rb','.');
hold on
ezpolar(@(x)1);
h(3) = plot(X(Mdl.IsSupportVector,1),X(Mdl.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1','Support Vectors'});
axis equal
ezpolar(@(x)2);
hold off

