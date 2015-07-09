function OperativeMenu(nStaz,pTrans,tServ,StazType,StazDescr)
    while true
        choice=menu('cosa vuoi fare?','crea nuovo','carica nuovo','salva','aggiungi stazione','modifica una stazione','procedi con i calcoli','esci');
        switch choice
            case 1,
                %chiedi conferma e se si vuole salvare, in caso positivo
                %procedi alla creazione di un nuovo sistema e itera (previa
                %eventuale salvataggio)
                prompt='Procedere alla creazione di un nuovo modello senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        [nStaz,pTrans,tServ,StazType,StazDescr]=crea();
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        [nStaz,pTrans,tServ,StazType,StazDescr]=crea();
                    case 'Annulla',
                        continue;
                end
                % NO break
            case 2,
                %chiedi conferma e se si vuole salvare il lavoro attuale,
                %in caso positivo procedi al caricamento di un nuovo
                %sistema
                prompt='Procedere al caricamento di un modello senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        [nStaz,pTrans,tServ,StazType,StazDescr]=carica();
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        [nStaz,pTrans,tServ,StazType,StazDescr]=carica();
                    case 'Annulla',
                        continue;
                end
                %NO break
            case 3,
                %salva l'attuale sistema in un file definito dall'utente
                uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                % NO break;
            case 4,
                %aggiungi una o più stazioni
                
                prompt='Procedere senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        prompt='Inserire il numedo di stazioni da aggiungere';
                        dlg_title='Aggiungi';
                        num_lines=1;
                        defAns={'0'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defAns);
                        NumAdd=str2double(answer{1});
                        if NumAdd==0
                            continue;
                        else
                            [nStaz,pTrans,tServ,StazType,StazDescr]=aggiungi(nStaz,pTrans,tServ,StazType,StazDescr,NumAdd);
                        end
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        prompt='Inserire il numedo di stazioni da aggiungere';
                        dlg_title='Aggiungi';
                        num_lines=1;
                        defAns={'0'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defAns);
                        NumAdd=str2double(answer{1});
                        if NumAdd==0
                            continue;
                        else
                            [nStaz,pTrans,tServ,StazType,StazDescr]=aggiungi(nStaz,pTrans,tServ,StazType,StazDescr,NumAdd);
                        end
                    case 'Annulla',
                        continue;
                end
                
                
                % NO break;
            case 5,
                %va inserita una procedura che permetta la modifica del
                %comportamento delle staizoni, ovvero da esponenziali
                %negative a qualcosa di diverso
                prompt='Procedere senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        prompt='Inserire il numero della stazione da modificare';
                        dlg_title='Modifica';
                        num_lines=1;
                        defAns={'0'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defAns);
                        NumMod=str2double(answer{1});
                        if NumMod==0
                            continue;
                        else
                            [nStaz,pTrans,tServ,StazType,StazDescr]=modifica(nStaz,pTrans,tServ,StazType,StazDescr,NumMod);
                        end
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        prompt='Inserire il numero della stazione da modificare';
                        dlg_title='Modifica';
                        num_lines=1;
                        defAns={'0'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defAns);
                        NumMod=str2double(answer{1});
                        if NumMod==0
                            continue;
                        else
                            [tServ,StazType,StazDescr]=modifica(tServ,StazType,StazDescr,NumMod);
                        end
                    case 'Annulla',
                        continue;
                end
            case 6,
                %rimandare a un menù con le opzioni di calcolo
                uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                calcola(nStaz,pTrans,tServ,StazType,StazDescr);
                % NO break;
                continue;
            case 7,
                %esci dal sistema dopo aver avuto conferma ed eventuale
                %salvataggio
                prompt='Uscire senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        break;
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        break;
                    case 'Annulla',
                        continue;
                end
            otherwise
                %chiedi se si vuole salvare
                prompt='Uscire senza salvare?';
                titolo='Attenzione';
                button = questdlg(prompt,titolo,'Procedi comunque','Salva','Annulla','Annulla');
                switch button
                    case 'Procedi comunque',
                        break;
                    case 'Salva',
                        uisave({'nStaz','pTrans','tServ','StazType','StazDescr'});
                        break;
                    case 'Annulla',
                        continue;
                end
        end
    end
end