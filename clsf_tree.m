%% Uczenie maszynowe AiR, 2018
%%
%% Cwiczenie: Drzewa decyzyjne
% Cel: Ilustracja roznych aspektow budowania drzew decyzyjnych i ich weryfikowania

% Prosze uzupelnic brakujace fragmenty zgodnie z instrukcja (FIXME)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decision Trees
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Prosze pobrac dane
clear all
load fisheriris.mat

%Prosze zapoznac sie ze zmiennymi meas oraz species

% Zadanie 1
%Wyswietlic informacje statystyczne na temat probek danych takie jak:
% Srednia wartosc atrybutu
% wartosc maksymalna atrybutu - wartosc minimalna atrybutu
% odchylenie standardowe

data = zeros(4,3);
for i=1:4
    i;
    temp = meas(:,i);
    average = mean(temp);
    diff = max(temp)-min(temp);
    stand = std(temp);
    data(i,:) = [average, diff, stand];
end

%Zadanie 2
% Przy pomocy funkcji gscatter() prosze wyswietlic wczytane dane dla
% atrybutow:
% a) sepal length <->sepal width (kolumna 1 i 2)

figure(1)
gscatter(meas(:,1),meas(:,2))
xlabel('sepal length')
ylabel('sepal width')

% b) petal length <->petal width (kolumna 3 i 4)

figure(2)
gscatter(meas(:,3),meas(:,4))
xlabel('petal length')
ylabel('petal width')

%Zadanie 3
% Utworz drzewo decyzyjne przy pomocy funkcji fitctree() lub
% ClassificationTree.fit()

tree = fitctree(meas,species);

% Zapoznaj sie z powstalym obiektem

% Zadanie 4
% Zapoznaj sie z graficzna i regulowa reprezentacja drzewa (funkcja view()):

view(tree);
view(tree,'MODE','graph');

% Zadanie 5
%Wyznacz klasy dla ka?dego przykladu trenujacego (dane meas, funkcja predict()):

class = predict(tree,meas);

% Zadanie 6
% Wyznacz macierz bledow (ang. confusion matrix) przy pomocy funkcji
% confusion matrix - funkcja cunfusionmat()

conf = confusionmat(species,class);

% Zadanie 7
%Wyswietl macierz przy pomocy funkcji disp()

disp(conf);


% Zadanie 8
% Wyznacz macierz bledow uzywajac funkcji plotconfusion() (wczesniej konwertuj species i wynik predykcji na wektory numeryczne:
 
tree_num = zeros(150,1);
species_num = zeros(150,1);
for i = 1:length(species)

    if strcmp(class{i},'setosa')==1
        tree_num(i)=1;
    elseif strcmp(class{i},'versicolor')==1
        tree_num(i)=2;
    else
        tree_num(i)=3;
    end
    
    if strcmp(species{i},'setosa')==1
        species_num(i)=1;
    elseif strcmp(species{i},'versicolor')==1
        species_num(i)=2;
    else
        species_num(i)=3;
    end
end

%figure(3)
%plotconfusion(tree_num,species_num)

% Zadanie 9
% Oblicz podstawowe miary na podstawie macierzy bledow:

% czulosc:

tpr = zeros(3,3);

for i = 1:3
    TP = conf(i,i);
    TN = sum(sum(conf))-sum(conf(i,:))-sum(conf(:,i))+TP;
    FP = sum(conf(:,i))-TP;
    FN = sum(conf(i,:))-TP;
    
    % swoistosc:
    tpr(i,1) = TP/(TP+FN);
    
    % precyzja:
    tpr(i,2) = TP/(TP+FP);
    
    % dokladnosc:
    tpr(i,3) = (TP+TN)/(TP+FN+TN+FP);
end

% Zadanie 10
%% Funkcja fitctree() po ustawieniu parametru 'CrossVal' 'on' uzywa 10-krotnej walidacji krzyzowej (ang. 10-fold crossvalidation). 
%Utworz drzewo decyzyjne

tree2 = fitctree(meas,species, 'CrossVal','on');


% Odpowiedz na pytanie:
% Ile drzew zostalo wygenerowanych: length(tree2.Trained) = 10

% Zadanie 11
%Wyswietl pierwsze drzewo:

view(tree2.Trained{1},'Mode','graph')

% Zadanie 12
%Ocen dzialanie modelu po wlaczeniu walidacji krzyzowej (ang. crossvalidation). 
%Odpowiedz: Zadzia³a³o gorzej - wiêcej b³êdów siê pojawi³o.

class2 = predict(tree2.Trained{1},meas); 
conf2 = confusionmat(species,class2);

% Zadanie 13
%Uzyj funkcji kfoldLoss() do oceny dzialania modelu.
kfoldLoss(tree2);

% Zadanie 14
%Ustal optymalna strukture drzewa wykorzystujac procedure walidacji krzyzowej.
%W petli generuj drzewa dla parametru "minimalna liczba przykladow w lisciu" (MinLeaf) zmienianego od 2 do 100 (parametr m). 
%Kazde takie drzewo oceniaj w procedurze walidacji krzyzowej:

mark_temp = zeros(length(2:100),1);
for m=2:100
    tree_temp=fitctree(meas,species, 'CrossVal','on','MinLeafSize',m);
    mark_temp(m-1) = kfoldLoss(tree_temp);
end

% Zadanie 15
%Sporzadz wykres bledu w zaleznosci od parametru m. Wyznacz optymalna wartosc m (najwieksza wartosc m, przy ktorej blad utrzymuje sie na niskim poziomie).

[val,place]=min(mark_temp);

place_opt = 40;

figure(3)
plot(mark_temp)

% Zadanie 16
%Pokaz optymalne drzewo w postaci graficznej:
optim_tree = fitctree(meas,species, 'CrossVal','on','MinLeafSize',place_opt+1);
optim_loss = kfoldLoss(optim_tree)
view(optim_tree.Trained{1},'Mode','graph')

% Zadanie 17
%Porownaj blad osiagany przez drzewo optymalne z bledem osiaganym przez drzewo wygenerowane przy domyslnych ustawieniach parametrow:
default_tree = fitctree(meas,species,'CrossVal','on');
default_loss = kfoldLoss(default_tree)

diff = abs(optim_loss-default_loss)
%DODATKOWO:
%Prosze przeanalizowac:
%This example shows how to optimize hyperparameters automatically using fitctree. The example uses Fisher's iris data.

%X = meas;
%Y = species;
%Mdl = fitctree(X,Y,'OptimizeHyperparameters','auto')

