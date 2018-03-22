%
%   TOPIC: Logistic Regression
%
% ------------------------------------------------------------------------

close all
clearvars

smarket=readtable('data/smarket.csv');
smarket.Direction = categorical(smarket.Direction, {'Up','Down'});

smarket_lag = smarket(:,[2:7 end]);
mdl = fitglm(smarket_lag,'Distribution','binomial');

yhat = predict(mdl, smarket)>0.5;
yhat = categorical(yhat, [0,1], {'Up', 'Down'});
 
% % W UCI nalezy skozystac z funkcji confusionmat() i recznie obliczyc "error rate"
conf = confusionmat(table2array(smarket(:,9)),yhat);
TP1=conf(1,1);
TP2 = conf(2,2);
TN1 = TP2;
TN2 = TP1;
FP1 = conf(2,1);
FN1 = conf(1,2);
FP2 = FN1;
FN2 = FP1;

error_rate = (FP1+FP2)/sum(sum(conf))

is_train = (smarket.Year < 2005);
smarket_train = smarket(is_train,:);

smarket_test = smarket(~is_train,:);

mdl2 = fitglm(smarket_train,'Direction~Lag1+Lag2','Distribution','binomial');
yhat2 = predict(mdl, smarket_test)>0.5;
yhat2 = categorical(yhat2, [0,1], {'Up', 'Down'});

conf2 = confusionmat(table2array(smarket_test(:,9)),yhat2);
error_rate2 = (conf2(2,1)+conf2(1,2))/sum(sum(conf2))