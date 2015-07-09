function [nStaz,pTrans,tServ,StazType,StazDescr]=carica()
    while true
        [FileName,PathName] = uigetfile('*.mat','Seleziona il modello da caricare');
        %controllare il cast in stringa in caso di annullamento
        if(strcmp(FileName,'0')~=1)&&(strcmp(PathName,'0')~=1)
            load([PathName,FileName]);
            break;
        else
            nStaz=nan;
            pTrans=nan;
            tServ=nan;
            StazType=nan;
            StazDescr=nan;
            return;
        end
    end
end