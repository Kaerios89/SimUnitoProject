function calcola(nStaz,pTrans,tServ,StazType,StazDescr)
    VisitVector=[];
    while true
        choice=menu(...
            'cosa vuoi fare?',...
            'vettore delle visite',...
            'Stazione Bottle-Neck del sistema',...
            'Bottle-Neck analisysis e analisi asintotica',...
            'Calcolo indici prestazione',...
            'Indici di prestazione Erlang',...
            'esci');
        switch choice
            case 1,
                %vettore delle visite
                VisitVector=vettorevisite(nStaz,pTrans);
                stem(VisitVector,'DisplayName','Vettore visite');
                figure(gcf);
                saveas(gcf,'VisitVector','jpg');
                %possibile uso del print
                save('VettoreVisite','VisitVector');
            case 2,
                % identifica la staizone Bottle-Neck
                switch isempty(VisitVector)
                    case 1,
                        errText='è necessario calcolare il vettore delle visite prima';
                        errTitle='VisitVector needed';
                        h = errordlg(errText,errTitle);
                        clear h;
                        continue;
                    case 0,
                        [StazBN,IndexBN]=bottleneck(VisitVector,tServ,StazDescr,StazType);
                        msgbox(StazBN);
                        save('StazioneBN','StazBN','IndexBN');
                        continue;
                end
            case 3,
                % esegue la BNA del sistema
                [FigHandle,NSat,NSatThink,NSatServ,D]=BNA(VisitVector,tServ);
                saveas(gcf,'Grafici asintotici','jpg');
                save('Valori_saturazione','NSat','NSatThink','NSatServ','D');
            case 4,
                switch isempty(VisitVector)
                    case 1,
                        errText='è necessario calcolare il vettore delle visite prima';
                        errTitle='VisitVector needed';
                        h = errordlg(errText,errTitle);
                        clear h;
                        continue;
                    case 0,
                        prompt='Inserire il numero massimo di clienti';
                        dlg_title='ClientMax';
                        num_lines=1;
                        defAns={'0'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defAns);
                        ClientMax=str2double(answer{1});
                        [X,R]=indiciPrest(VisitVector,tServ,nStaz,ClientMax,StazType);
                        save('Indici_di_prestazione','X','R');
                        continue;
                end
            case 5,
                %calcola X e R con stazione erlang 3
                prompt='Inserire il numero massimo di clienti';
                dlg_title='nClientMax';
                num_lines=1;
                defAns={'0'};
                answ=inputdlg(prompt,dlg_title,num_lines,defAns);
                nClientMax=str2double(answ{1});
                %inserimento indice della stazione da modellare come
                %Erlang3
                prompt='Inserire indice della stazione da modellare';
                dlg_title='IndexCPU';
                num_lines=1;
                defAns={'0'};
                answ1=inputdlg(prompt,dlg_title,num_lines,defAns);
                IndexCPU=str2double(answ1{1});
                %Calcolo degli indici di prestazioni (nota il calcolo può
                %essere Time Consuming)
                [Xe,Re]=Step2(tServ,pTrans,IndexCPU,nClientMax,StazType);
                save('Indici_di_prestazione_Erlang','Xe','Re');
                break;
            case 6,
                %esci
                break;
            otherwise
                %esci 
                break;
                
        end
    end
end