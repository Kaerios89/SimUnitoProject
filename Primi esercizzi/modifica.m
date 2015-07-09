function [tServ,StazType,StazDescr]=modifica(tServ,StazType,StazDescr,NumMod)
    %la funzione deve prendere il sistema attuale insieme al numedo della
    %stazione da modificare (variabile NumMod) richiama StazDet con numero
    %di nuove stazioni pari a uno e utilizza gli output in modo da
    %sostituire i valodi della stazione attuale
    [tServ(NumMod),StazType(NumMod),StazDescr(NumMod)]=StazDet(NumMod);
end