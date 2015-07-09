function pTrans=DefTransFunc(OldMat,nStaz)
    if isempty(OldMat)
        pTrans=zeros(nStaz);
    else
        SizeOldMat=size(OldMat,1);
        OldMat(SizeOldMat+1:SizeOldMat+nStaz,SizeOldMat+1:SizeOldMat+nStaz)=zeros(nStaz);
        pTrans=OldMat;
    end
    pTrans=zeros(nStaz);
    while true
        opt.Resize='on';
        opt.WindowStyle='normal';
        opt.Interpreter='none';
        prompt={'partenza','arrivo'};
        dlg_title='Probabilità di transizione';
        line=[1;1];
        defAns={'inserire numero della stazione di partenza (da 1 a N)','inseire numero della stazione di arrivo'};
        answer = inputdlg(prompt,dlg_title,line,defAns,opt);
        switch isempty(answer)
            case 1,
                %mostra un messaggio (modale) chiedendo se si è finito
                opt1.Resize='off';
                opt1.WindowStyle='modal';
                opt1.Interpreter='none';
                opt1.Default='No';
                prompt1='Si è sicuri di voler terminare?';
                title1='Uscita';
                ans1=questdlg(prompt1,title1,'Si','No',opt1);
                switch ans1
                    case 'Si',
                        %controllo sulla stocasticità della matrice: 
                        nonStoc = false;
                        controlMatrix=sum(pTrans,2);
                        for i=1:length(controlMatrix);
                            if(controlMatrix~=1)
                                nonStoc = true;
                                break
                            end
                        end
                        switch nonStoc
                            case true,
                                errPrompt=['la stazione numero ',num2str(i),' non ha probabilità totale = 1'];
                                errTitle='Matrice Probabilità non esatta';
                                h=errordlg(errPrompt,errTitle,'modal');
                                continue;
                            case false,
                                break;
                        end
                    case 'No',
                        %non fare nulla e ritorna all'inserimento delle
                        %prob
                        continue;
                end
            case 0,
                opt1.Resize='on';
                opt1.WindowStyle='modal';
                opt1.Interpreter='none';
                prompt1=['Inserire la probabilità di transizione tra ',answer{1},' e ',answer{2}];
                title1='Inserimento probabilità di transizione';
                line=1;
                defAns={'0'};
                ans1=inputdlg(prompt1,title1,line,defAns,opt1);
                r=str2double(answer{1});
                c=str2double(answer{2});
                pTrans(r,c)=str2double(ans1{1});
        end
    end
end