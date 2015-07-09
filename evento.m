%congrua con funzioni
classdef evento
   properties (Access = public)
       GenTime %tempo di creazione
       ServTime %quantità di servizio che deve espletare
       OccurTime %quando tale evento accadrà
       type %che tipo di evento è (è un oggetto di tipo evType)
       Station %stazione di appartenenza
   end
   methods
       function evento=evento(gt,st,ot,type,stat)
           evento.GenTime=gt;
           evento.ServTime=st;
           evento.OccurTime=ot;
           evento.type=type;
           evento.Station=stat;
       end
       %definizione dei getter
       %%
       function gt=get.GenTime(event)
           gt=event.GenTime;
       end
       
       function st=get.ServTime(event)
           st=event.ServTime;
       end
       
       function ot=get.OccurTime(event)
           ot=event.OccurTime;
       end
       
       function type=get.type(event)
           type=event.type;
       end
       function stat=get.Station(event)
           stat=event.Station;
       end
       %fine getter    
   end
end