syms N
load('Indici_di_prestazione.mat');
As1(N)=N*0.5-2;
As2(N)=abs(N-N)+20.8;
hold on
primo=ezplot(As1(N),[0,100]);
    set(primo,'color',[1,0,0]);
secondo=ezplot(As2(N),[0,100]);
    set(secondo,'color',[0,1,0]);
frullo=linspace(0,100);
terzo=plot(frullo,R(:,1));
legend('(N*Vb*Sb)-Z','R=(1)','R')
hold off