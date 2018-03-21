%% Uczenie maszynowe AiR, 2018
%%
%% Cwiczenie: K-najblizszych sasiadow
% Cel: Wykorzystanie wbudowanych funkcji do klasyfikacji danych przy pomocy
% algorytmu k-nn

% Prosze uzupelnic brakujace fragmenty zgodnie z instrukcj? (FIXME)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-nearest 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Prosze pobrac dane
clear all
close all
%Fisher's 1936 iris data
load fisheriris.mat

%lub
% Cardiac arrhythmia data from the UCI machine learning repository:
%load arrhythmia.mat

% Prosze zapoznac sie ze zbiorem danych -> zmienna Description w Workspace

%Prosze uzywac funkcji fitcknn(), funkcja knnclassify() zostanie w
%przyszlosci ca?lkowicie wycofana

%Zadania

% Zaprojektuj klasyfikator typu k najblizszych sasiadow (k-NN) do
% rozpoznawania kwiatow irysa lub rodzaju arytmii.

% Zadanie 1

% Podziel zbior danych na uczacy i testowy. Losowo wybierz 5 danych do
%zbioru testowego

s=rng;
learn_x = randi([0,150],5,1);
learn = meas(learn_x,:);
learn_species = species(learn_x,:);
meas(learn_x,:)=[];
species(learn_x,:)=[];

% Zadanie 2
% Narysuj dane uczace oraz testowe

figure(1)
plot(learn(:,1),learn(:,2),'b*');
hold on;
plot(meas(:,1),meas(:,2),'mo');



% Zadanie 3 
% Znajdz 5 punktow najblizszych punktowi badanemu (pierwszy ze zbioru testowego)
% Skorzystaj z funkcji knnsearch()
X = meas;
Y = learn(1,:);
find = knnsearch(X,Y,'K',5);
neigh = X(find,:);

% Narysuj te punkty na wykresie
plot(Y(:,1),Y(:,2),'rs');
plot(X(find,1),X(find,2),'go');
legend('Dane uczace','Dane testowe','Punkt pierwszy','Najbli¿si sasiedzi');

% Zadanie 4
%Ustal gatunki sasiadow. Skorzystaj z funckji tabulate()

tbl = tabulate(species(find,:));


% Zadanie 5
% Wykorzystujac funkcj? fitcknn() stworz klasyfikator dla k=4

Mdl = fitcknn(meas,species,'NumNeighbors',4);


%Zadanie 6 
%Sklasyfikuj dane ze zbioru testowego, funkcja predict()

predict(Mdl,Y);

%Zadanie 7
% W procedurze 10-krotnej walidacji krzyzowej znajdz optymalna wartosc liczby najblizszych sasiadow k:
%Przydatne funckje: crossvalind(), fitcknn()
%Dokladnosc klasyfikatora: ACC

ACC = zeros(1,100);
for i = 1:100
    Mdl = fitcknn(meas,species,'NumNeighbors',i);
    predicted = predict(Mdl,learn);
    ACC(i)=0;
    for j=1:5
        if isequal(predicted{j}, learn_species{j})
            ACC(i) = ACC(i)+20;
        end
    end
end


%Narysuj wykres zaleznosci dokladnosci klasyfikatora (ACC) od wartosci k.

figure(2)
plot(ACC)
xlabel('k');
ylabel('Proper detection');

%Wybierz optymalna wartosc k

k=8;

%Zadanie 8

% Przedstaw na wykresie granice klas

%Stworz klasyfikator kNN dla 2 wybranych parametrow:

mdl_2 = fitcknn(X(:,[1 2]),species,'NumNeighbors',k);

%Dane testowe- przestrzen (X- parametry)(odkomentuj:)
x1_range = min(X(:,1)):.01:max(X(:,1));
x2_range = min(X(:,2)):.01:max(X(:,2));
[xx1, xx2] = meshgrid(x1_range,x2_range);
XGrid = [xx1(:) xx2(:)];

% Sklasyfikuj dane ze zbioru testowego

test_data = predict(mdl_2,XGrid)

% Narysuj wykres (gscatter())

figure
gscatter(XGrid(:,1),XGrid(:,2),test_data,'brg')

% DODATKOWO
%Prosze zapoznac sie z parametrami funkcji fitcknn() : metryki
%odleglosci(distance metrics), wagi (Distance Weights) ect.



