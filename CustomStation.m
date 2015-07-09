%coerente con funzioni
classdef CustomStation < SingleServer
% Come suggerito, il parametro mu è lo stesso, in quanto la somma delle
% distibuzioni (o la velocità di servizio dell'Erlang) ha come media lo
% stesso valore (nel nostro caso specifico 30ms)
properties
    DistributionHandle
end
methods
    function NewStaz=CustomStation(StazName,vServ,ambiente,DistHandle)
        NewStaz@SingleServer(StazName,vServ,ambiente);
        NewStaz.DistributionHandle=DistHandle;
        % dato che è una stazione custom ho deciso di non mettere dei
        % vincoli su quale distribuzione della velocità di servizio usare;
        % userò invece un riferimento a una funzione esterna (handle) per
        % definirla quando viene creata
    end
    function deltaS=OttieniTServ(Staz)
        deltaS=Staz.DistributionHandle(Staz.mu);
    end
    function arrivo(Staz)
        arrivo@SingleServer(Staz);
    end
    function partenza(Staz)
        partenza@SingleServer(Staz);
    end
end
end