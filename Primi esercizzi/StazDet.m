function [tServ,StazType,StazDescr]=StazDet(i)
    %possibile miglioramento con inserimento di un vettore StazDesc che
    %riporta la distribuzione del tempo di servizio.
    menu_prompt=['inserire il tipo della stazione numero ',num2str(i)];
    while true
        typeS= menu(menu_prompt,'Infinite Server','Single Server','Limited Load Dependency');
        switch typeS
            case 1,
                %inserire Z ovvero il tempo che i clienti passano nella
                %stazione IS
                prompt={'inserisci tempo di pensamento Z','descrizione'};
                titolo='tempo di pensamento Infinite Server';
                defaultAns={'','exp_neg'};
                res=inputdlg(prompt,titolo,1,defaultAns);
                StazType=1;
                tServ=str2double(res{1});
                StazDescr={res{2}};
                break
            case 2,
                %single server con tempo di servizio pari a S
                prompt={'inserisci tempo di servizio S','descrizione'};
                titolo='tempo di servizio Single Server';
                defaultAns={'','exp_neg'};
                res=inputdlg(prompt,titolo,1,defaultAns);
                StazType=2;
                tServ=str2double(res{1});
                StazDescr={res{2}};
                break
            case 3,
                %limited load dependency tempo di servizio S dipendente da
                %n
                prompt={'inserisci tempo di servizio S','descrizione'};
                titolo='tempo di servizio Limited Load Dependency';
                defaultAns={'','exp_neg'};
                res=inputdlg(prompt,titolo,1,defaultAns);
                StazType=3;
                tServ=str2double(res{1});
                StazDescr={res{2}};
                break
            otherwise
                %emettere un messaggio di errore per forzare di specificare
                %una stazione.
                errText=['Fornire i detteagli per la stazione',num2str(i)];
                errTitle='Stazione non dettagliata';
                h = errordlg(errText,errTitle);
                clear h;
        end
    end
end