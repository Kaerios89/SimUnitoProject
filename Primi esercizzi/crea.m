function [nStaz,pTrans,tServ,StazType,StazDescr]=crea()
    %inserire numero di stazioni => nStaz
    nStazPrompt='inserire il numero di stazioni nel sistema';
    nStazDlg_title='input';
    nStazNum_line= 1;
    Cell_nStaz=inputdlg(nStazPrompt,nStazDlg_title,nStazNum_line);
    nStaz=str2double(Cell_nStaz{1});
    for i=1:nStaz    %caratterizza le stazioni
        [Buff_tServ(i),Buff_StazType(i),Buff_StazDescr(i)]=StazDet(i);
    end
     tServ=Buff_tServ;
     StazType=Buff_StazType;
     StazDescr=Buff_StazDescr;
     %definizione probabilità di transizione
     a=[];
     pTrans=DefTransFunc(a,nStaz);
end