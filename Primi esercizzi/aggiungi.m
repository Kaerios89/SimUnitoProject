function [nStaz,pTrans,tServ,StazType,StazDescr]=aggiungi(nStaz,pTrans,tServ,StazType,StazDescr,NumAdd)
    for i=1:NumAdd    %caratterizza le stazioni
        [Buff_tServ(i),Buff_StazType(i),Buff_StazDescr(i)]=StazDet(i);
    end
     tServ=[tServ,Buff_tServ];
     StazType=[StazType,Buff_StazType];
     StazDescr=[StazDescr,Buff_StazDescr];
     %definizione probabilità di transizione
     pTrans=DefTransFunc(pTrans,nStaz);
end