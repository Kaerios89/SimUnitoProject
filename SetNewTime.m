%dato passato medianto il notify all'listener dell'ambiente in modo che
%aggiorni il tempo della simulazione al tempo di occorrenza dell'evento
%corrente
classdef (ConstructOnLoad)SetNewTime < event.EventData
    properties
        NewTime
    end
    methods
        function data=SetNewTime(newtime)
            data.NewTime=newtime;
        end
    end
end