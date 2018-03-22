%
%   TOPIC: Linear Discriminant Analysis
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

lda_mdl=fitcdiscr(smarket_train,'Direction~Lag1+Lag2');

fprintf('Class names:\n')
disp(lda_mdl.ClassNames)
 
fprintf('Group means:\n')
disp(lda_mdl.Mu)
 
fprintf('Prior probabilities of groups:\n')
disp(lda_mdl.Prior)

lda_mdl.ClassNames([1 2])
K = lda_mdl.Coeffs(1,2).Const;
L = lda_mdl.Coeffs(1,2).Linear;

f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
h2 = ezplot(f);
h2.Color = 'r';
h2.LineWidth = 2;

[s, score, ~] = predict(lda_mdl, smarket_test);

confs = confusionmat(table2array(smarket_test(:,9)),s);
error_rates = (confs(2,1)+confs(1,2))/sum(sum(confs))

yhat_t50 = (score(:,2) > 0.5);
yhat_t50 = categorical(yhat_t50, [0,1], {'Up', 'Down'});

conf = confusionmat(table2array(smarket_test(:,9)),yhat_t50);
error_rate = (conf(2,1)+conf(1,2))/sum(sum(conf))

[~, score2, ~] = predict(lda_mdl, smarket_test);
yhat_t90 = (score2(:,2) > 0.9);
yhat_t90 = categorical(yhat_t90, [0,1], {'Up', 'Down'});

conf2 = confusionmat(table2array(smarket_test(:,9)),yhat_t90);
error_rate2 = (conf2(2,1)+conf2(1,2))/sum(sum(conf2))





