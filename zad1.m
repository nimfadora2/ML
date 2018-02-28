%%%% Wprowadzenie do przedmiotu %%%%
%%%% Kinga S³owik, czw., g.9:30 %%%%

% zad. 1 %
A = [2:2:20]
A([2:2:length(A)])
A(A>10)
A(mod(A,2)==0)
sum(A(A>10))

X = magic(5)
X(X>5)
sum(X(X>2))
X([2:2:size(X,1)],:)
X(:,[1:2:size(X,2)])
sum(sum(X))

% zad. 2 %

suma=0;
for i=[1:100000]
    suma = suma+i;
end
suma;

sum([1:100000]);

t0=clock;
suma=0;
for i=[1:100000]
    suma = suma+i;
end
etime(clock,t0); %% ans = 0

t0=clock;
sum([1:100000]);
etime(clock,t0); %% ans= 0 

% zad. 3 %

tic
power_1=0;
for i=1:100000
    power_1=power_1+(1/i)^2;
end
power_1;
toc %% Elapsed time is 0.006963 seconds.

tic
sum([1:100000].^(-2)); %% Elapsed time is 0.017289 seconds.
toc

%%% Function using for required less time than built-in %%%

% zad. 4 %

tic
power=0;
for i=1:1000
    power=power+i*i;
end
power; %% Elapsed time is 0.001904 seconds.
toc

tic
sum([1:1000].^2); %% Elapsed time is 0.001211 seconds.
toc

%%% Function for required more time that built-in sum %%%

% zad. 5 %

tic
fraction = 0;
for i = 0:1:501
    fraction = fraction+(1/(2*i+1))*((-1)^i); % Elapsed time is 0.003114 seconds.
end
fraction;
toc

tic
sum(ones(1,502)./((-1).^[0:501].*((2*[0:501])+1))); % Elapsed time is 0.002420 seconds.
toc

%%% The built-in sum is faster than loop for in this case.

% zad. 6 %

X = [-1 0 2;1 -2 1;55 0 2];
X(X(1,:)> 0) %% ans = 55

% zad. 7 %

N = 5;
B=[1:N].*ones(N);

% zad. 8 %

D = B.*(B<=B')+B'.*(B'<B);

% zad. 9 %

A = [0 1 1];
A=[1 0 1 1];
sum(A.*(2.^[length(A)-1:-1:0]));

% zad. 10 %

%%% Ax = B %%%
%%% x = A^(-1)B

A = [2 1; 1 2];
B = [3 -1];
X = B/A
X = inv(A)*B'

A = [2 3 1; 1 -2 7; 3 4 10];
B = [1 17 19];
X2 = inv(A)*B'

