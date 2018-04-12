%
%   TOPIC: Support Vector Classifiers
%
% ------------------------------------------------------------------------

close all
clearvars

%% Generate data.

rng(1); % For reproducibility

% Generate data from a normal distribution.
n_cls = 20; % Number of samples in each class.
X = vertcat(...
    horzcat(normrnd(0.5,1, n_cls,1), normrnd(0.4,1, n_cls,1)), ...
    horzcat(normrnd(-0.3,1, n_cls,1), normrnd(-0.5,1, n_cls,1)) ...
    );
Y = vertcat(-1 * ones(n_cls,1), +1 * ones(n_cls,1));

%% Fit a model.

Mdl = fitcsvm(X,Y);

%% Make predictions.

newX = [
    1, -0.4;
    1, -0.85
    ];

predictions = predict(Mdl, newX);

%% Visualize data and the model.

X1 = X((Y==1),:);
X_1 = X((Y==-1),:);
support = X((Mdl.IsSupportVector==1),:);
beta = Mdl.Beta;
bias = Mdl.Bias;

mini =min(X(:,1));
maxi = max(X(:,1));

Xx=[mini:0.1:maxi];
Yy = (beta(1)*Xx+bias)/(-beta(2));

Xp1 = newX((predictions==1),:);
Xp_1 = newX((predictions==-1),:);

figure(1)
plot(X1(:,1),X1(:,2),'r.')
hold on
plot(X_1(:,1),X_1(:,2),'b.')
plot(support(:,1),support(:,2),'ko')
plot(Xx,Yy,'k--')
plot(Xp1(:,1),Xp1(:,2),'*')
plot(Xp_1(:,1),Xp_1(:,2),'y*')

xlim([mini maxi])

xlabel('x_1')
ylabel('x_2')
legend('Class 1+','Class 1-', 'Suport vector', 'Decision boundary', 'Class +1 predicted','Class -1 predicted')


%% Get posteriors.

Mdl2= fitPosterior(Mdl);
[labels,posterior] = predict(Mdl2,newX)