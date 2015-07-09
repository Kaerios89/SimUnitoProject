%da quando la si richiama con il load in realtà si crea già la variabile di
%output che contiene potenzialmente tutte le stazioni, basta instanziarle
%via via in seguito.
%
%Definizione Stazione;
% Nsys: Numero di clienti nella stazione (coda+attivi)
% Nmax: numero di clienti servibili contemporaneamente (1->INF)
% Narr: numero di arrivi
% Npar: numero di partenze
% BusyTime: tempo in cui la stazione è occupata e attiva
% Area: Area sottesa alla curva
% X: Troughput
% U: utilizzazione
% En: numero medio di clienti nella stazione
% Ew: tempo medio di permanenza nella stazione
% TTE: tempo rimanente allo svuotamento della coda (time to end)
% IDStaz: numero della stazione
% Tipo: ci dice se SS o IS
% pTrans: array con le prob di uscita
% tServ: tempo di servizio (forse può essere modificabile)
field1='Nsys'; field2='Nmax'; field3='Narr'; field4='Npar';
field5='BusyTime'; field6='Area'; field7='X'; field8='U';
field9='En'; field10='Ew'; field11='TTE'; field12='IDStaz';
field13='Tipo'; field14='pTrans'; field15='tServ';
Staz=struct(field1,{},field2,{},field3,{},field4,{},field5,{},field6,{},field7,{},field8,{},field9,{},field10,{},field11,{},field12,{},field13,{},field14,{},field15,{});
 save('ModelloStazione.mat','Staz');
 clear;