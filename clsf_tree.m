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

%FIXME

%Zadanie 2
% Przy pomocy funkcji gscatter() prosze wyswietlic wczytane dane dla
% atrybutow:
% a) sepal length <->sepal width (kolumna 1 i 2)

%FIXME%


% b) petal length <->petal width (kolumna 3 i 4)

%FIXME%

%Zadanie 3
% Utworz drzewo decyzyjne przy pomocy funkcji fitctree() lub
% ClassificationTree.fit()

%FIXME


% Zapoznaj sie z powstalym obiektem

% Zadanie 4
% Zapoznaj sie z graficzna i regulowa reprezentacja drzewa (funkcja view()):

%FIXME (werjsa graficzna i regulowa)


% Zadanie 5
%Wyznacz klasy dla ka?dego przykladu trenujacego (dane meas, funkcja predict()):

% Zadanie 6
% Wyznacz macierz bledow (ang. confusion matrix) przy pomocy funkcji
% confusion matrix - funkcja cunfusionmat()

%FIXME


% Zadanie 7
%Wyswietl macierz przy pomocy funkcji disp()

%FIXME


% Zadanie 8
% Wyznacz macierz bledow uzywajac funkcji plotconfusion() (wczesniej konwertuj species i wynik predykcji na wektory numeryczne:

%FIXME 


% Zadanie 9
% Oblicz podstawowe miary na podstawie macierzy bledow:

% czulosc:
%FIXME

% swoistosc:
%FIXME

% precyzja:
%FIXME

% dokladnosc:
%FIXME

% Zadanie 10
%% Funkcja fitctree() po ustawieniu parametru 'CrossVal' 'on' uzywa 10-krotnej walidacji krzyzowej (ang. 10-fold crossvalidation). 
%Utworz drzewo decyzyjne

%FIXME


% Odpowiedz na pytanie:
% Ile drzew zostalo wygenerowanych: FIXME

% Zadanie 11
%Wyswietl pierwsze drzewo:
%FIXME

% Zadanie 12
%Ocen dzialanie modelu po wlaczeniu walidacji krzyzowej (ang. crossvalidation). 
%Odpowiedz: FIXME

% Zadanie 13
%Uzyj funkcji kfoldLoss() do oceny dzialania modelu.
%FIXME

% Zadanie 14
%Ustal optymalna strukture drzewa wykorzystujac procedure walidacji krzyzowej.
%W petli generuj drzewa dla parametru "minimalna liczba przykladow w lisciu" (MinLeaf) zmienianego od 2 do 100 (parametr m). 
%Kazde takie drzewo oceniaj w procedurze walidacji krzyzowej:
%FIXME

% Zadanie 15
%Sporzadz wykres bledu w zaleznosci od parametru m. Wyznacz optymalna wartosc m (najwieksza wartosc m, przy ktorej blad utrzymuje sie na niskim poziomie).
%FIXME

% Zadanie 16
%Pokaz optymalne drzewo w postaci graficznej:
%FIXME

% Zadanie 17
%Porownaj blad osiagany przez drzewo optymalne z bledem osiaganym przez drzewo wygenerowane przy domyslnych ustawieniach parametrow:
%FIXME

%DODATKOWO:
%Prosze przeanalizowac:
%This example shows how to optimize hyperparameters automatically using fitctree. The example uses Fisher's iris data.

%X = meas;
%Y = species;
%Mdl = fitctree(X,Y,'OptimizeHyperparameters','auto')

