%
%   TOPIC: Data analysis
%
% ------------------------------------------------------------------------

close all
clearvars

smarket=readtable('data/smarket.csv');
smarket.Direction = categorical(smarket.Direction, {'Up','Down'});
summary(smarket);


smarket_w_dir = smarket(:,1:8);
s_w_dir = table2array(smarket_w_dir);
[Cor,p_vals] = corrcoef(s_w_dir);

% smarket_w_dir - tabela zawieraj¹ca "okrojone" dane (bez cechy `Direction`)
% Cor, p_val - macierze zawieraj¹ce odpowiednio wspó³czynniki korelacji i p-wartoœci
Cor = array2table(Cor);
Cor.Properties.VariableNames = smarket_w_dir.Properties.VariableNames;
Cor.Properties.RowNames = smarket_w_dir.Properties.VariableNames;
p_vals = array2table(p_vals);
p_vals.Properties.VariableNames = smarket_w_dir.Properties.VariableNames;
p_vals.Properties.RowNames = smarket_w_dir.Properties.VariableNames;

