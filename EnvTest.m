function EnvTest(n,Clienti,location)
%% Versione parallela Exp Neg
load('ModelloFinale.mat')
pointStore=ConfPoint.empty(0,n);
appo=Ambiente.empty(0,n);
for i=1:n
    appo(i)=Ambiente(nStaz,pTrans,tServ,StazType,StazDescr,i*10);
end
parfor i=1:n
    appo(i)=StartEngine(appo(i),Clienti);
end
for i=1:n
    pointStore(i)=appo(i).PlotPoint;
end
location1=strcat(location,num2str(Clienti),'NegExp.mat');
save(location1,'pointStore');

%% Versione parallela Erlang
load('ModelloFinaleErlang.mat')
pointStore=ConfPoint.empty(0,n);
appo=Ambiente.empty(0,n);
for i=1:n
    appo(i)=Ambiente(nStaz,pTrans,tServ,StazType,StazDescr,i*10);
end
parfor i=1:n
    appo(i)=StartEngine(appo(i),Clienti);
end
for i=1:n
    pointStore(i)=appo(i).PlotPoint;
end
location1=strcat(location,num2str(Clienti),'Erlang.mat');
save(location1,'pointStore');
%% Versione parallela Composite
load('ModelloFinaleComposite.mat')
pointStore=ConfPoint.empty(0,n);
appo=Ambiente.empty(0,n);
for i=1:n
    appo(i)=Ambiente(nStaz,pTrans,tServ,StazType,StazDescr,i*10);
end
parfor i=1:n
    appo(i)=StartEngine(appo(i),Clienti);
end
for i=1:n
    pointStore(i)=appo(i).PlotPoint;
end
location1=strcat(location,num2str(Clienti),'Composite.mat');
save(location1,'pointStore');
end