function [FigHandle,NSat,NSatThink,NSatServ,D]=BNA(VisitVector,tServ)

    % non è nulla si speciale, solo il calcolo degli asintoti del sistema e
    % altri valori indicatori
    syms n;
    appo=VisitVector.*tServ;
    TroughLimitHoriz=appo.^-1; % valori dell'asintoto orizzontale per fig1
    TroughLimitHorizN=sym(TroughLimitHoriz);
    D=sum(appo);            %asintoto orizzontale fig2
    Y=D-tServ(1);
    X_0(n)=n/Y;     %funzione dell'asintoto obliquo
    for i=1:length(tServ)
        R(1,i)=n*appo(i)-tServ(1); %funzione n-esima asintoto obliquo fig 2
    end
    %R=n.*R;
    NSat=Y/min(appo);
    NSatThink=tServ/min(appo);
    NSatServ=D/min(appo);
    
    subplot(1,2,1);
        a=ezplot(X_0);
        set(a,'Color','black', 'LineStyle', '--', 'LineWidth', 1);
        hold on;
        for i=1:length(TroughLimitHoriz)
            b=ezplot(TroughLimitHorizN(1,i));
            set(b,'Color','black', 'LineStyle', ':', 'LineWidth', 1);
        end
        title('Troughput al variare di N');
        hold off;
    subplot(1,2,2);
        Dn=sym(D);
        c=ezplot(Dn);
        set(c,'Color','black', 'LineStyle', '--', 'LineWidth', 1);
        hold on;
        for i=1:length(TroughLimitHoriz)
            d=ezplot(R(1,i));
            set(d,'Color','black', 'LineStyle', ':', 'LineWidth', 1);
        end  
        title('Tempo di risposta al variare di N');
        hold off;
    FigHandle=gcf;
end