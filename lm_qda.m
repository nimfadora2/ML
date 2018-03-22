%
%   TOPIC: Quadratic Discriminant Analysis
%
% ------------------------------------------------------------------------

close all
clearvars

smarket=readtable('data/smarket.csv');
smarket.Direction = categorical(smarket.Direction, {'Up','Down'});

figure
gscatter(smarket.Lag1,smarket.Lag2,smarket.Direction,'br','xo')
hold on

is_train = (smarket.Year < 2005);
smarket_train = smarket(is_train,:);

smarket_test = smarket(~is_train,:);

qda_mdl=fitcdiscr(smarket_train,'Direction~Lag1+Lag2','DiscrimType','quadratic');

qda_mdl.ClassNames([1 2])
K = qda_mdl.Coeffs(1,2).Const;
L = qda_mdl.Coeffs(1,2).Linear;
Q = qda_mdl.Coeffs(1,2).Quadratic;

f = @(x1,x2) K + L(1)*x1 + L(2)*x2 + Q(1,1)*x1.^2 + ...
    (Q(1,2)+Q(2,1))*x1.*x2 + Q(2,2)*x2.^2;
h3 = ezplot(f); % Plot the relevant portion of the curve.
h3.Color = 'k';
h3.LineWidth = 2;

[s, score, ss] = predict(qda_mdl, smarket_test);
conf = confusionmat(table2array(smarket_test(:,9)),s);
error_rate = (conf(2,1)+conf(1,2))/sum(sum(conf))