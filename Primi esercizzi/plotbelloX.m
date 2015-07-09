clear
syms N
load('Indici_di_prestazione.mat');
As1(N)=N*X(1,1);
As2(N)=abs(N-N)+2;
hold on
primo=ezplot(As1(N),[0,100]);
    set(primo,'color',[1,0,0]);
secondo=ezplot(As2(N),[0,100]);
    set(secondo,'color',[0,1,0]);
frullo=linspace(0,100);
terzo=plot(frullo,X(:,1));
    set(terzo,'color',[0,0,1]);
legend('N*X0(1)','X0=1/VbSb','X')
hold off