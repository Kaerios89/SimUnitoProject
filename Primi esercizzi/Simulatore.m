function Simulatore()
    while true
    choice=menu('cosa vuoi fare?','crea','carica','esci');
        switch choice
            case 1,         %crea il modello
                [nStaz,pTrans,tServ,StazType,StazDescr]=crea();
                OperativeMenu(nStaz,pTrans,tServ,StazType,StazDescr);
            case 2,         %carica un modello già creato
                [nStaz,pTrans,tServ,StazType,StazDescr]=carica();
                if isnan(nStaz)
                    continue;
                else
                    OperativeMenu(nStaz,pTrans,tServ,StazType,StazDescr);
                    break;
                end
            case 3,         %esci
                break;
            otherwise
                break;
        end
    end
end