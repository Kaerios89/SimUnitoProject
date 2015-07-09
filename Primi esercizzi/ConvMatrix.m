function G=ConvMatrix(VisitVector,tServ,nStaz,clientMax,StazType)
    G=zeros(clientMax+1,1);
    for i=1:nStaz
       appo=ConvCol(VisitVector(i),tServ(i),StazType(i),clientMax);
       G=[G,appo'];
    end
end