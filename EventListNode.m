%congruo con funzioni
classdef EventListNode < dlnode
    methods
        function lista1=rewind(lista)
            while(~isempty(lista.Prev))
                lista=lista.Prev;
            end
            lista1=lista;
        end
        function node=EventListNode(event)
            %inutile prevedere un costruttore vuoto, tanto la lista verrà
            %sempre inizializzata con due valori
            node@dlnode(event);
            node.Next=EventListNode.empty();
            node.Prev=EventListNode.empty();
        end
        %qui si va a inserire un evento ordinandolo.
        function lista1=schedula(lista,new_event)
            newNode=EventListNode(new_event);
            done = false;
            while(~done)
                if isempty(lista)
                    lista=newNode;
                    done=true;
                    break;
                end
                inserted=false;
                while(~isempty(lista.Next))
                    if((lista.Data.OccurTime()>=new_event.OccurTime()))
                        insertBefore(newNode,lista);
                        inserted=true;
                        done=true;
                        break
                    end
                    lista=lista.Next;
                end
                if(inserted==false)
                    %insertAfter(newNode,lista);
                    if(lista.Data.OccurTime()>=new_event.OccurTime())
                        insertBefore(newNode,lista);
                    else
                        insertAfter(newNode,lista);
                    end
                    done=true;
                end
            end
            lista1=lista.rewind();
        end
        %qui si va a fare una get con eliminazione dell'elemento n-esimo
        function [event,lista1]=getEvent(lista,n)
            for i=1:n-1
                lista=lista.Next;
            end
            event=lista.Data;
            lista1=lista.Next;
            removeNode(lista);
            %lista1=lista.rewind();
        end
        function removeNode(node)
            if ~isscalar(node)
                error('Input must be scalar')
            end
            prevNode = node.Prev;
            nextNode = node.Next;
            if ~isempty(prevNode)
               prevNode.Next = nextNode;
            end
            if ~isempty(nextNode)
               nextNode.Prev = prevNode;
            end
            node.Next = EventListNode.empty;
            node.Prev = EventListNode.empty;
        end
        %restituisce l'evento all'n-esima posizione
        function event=explore(lista,n)
            for i=1:n-1
                lista=lista.Next;
            end
            %event=lista.Data;
            if(~isempty(lista))
                event=lista.Data;
            else
                event=evento(0,0,inf,evType.Arrivo,0);
            end
        end
        function ReSchedule(EvList,SpeedR,Staz)
            i=1;
            %%
            done=false;
            while (true)
            %while ~isempty(EvList.Next)
                if(done)
                    break
                else
                    if(isempty(EvList.Next))
                        %qui esploriamo il caso finale della lista
                        done=true;
                        Cevent=EvList.Data;
                        if((Cevent.Station==Staz.Name)&&(Cevent.type==evType.Partenza))
                            [Cevent,EvList]=getEvent(EvList,1); 
                            %non ritorno la lista altrimenti non torno in dietro
                            %% aggiornamento valori dell'envento
                            RemTime=Cevent.OccurTime-Staz.Env.Time;
                            RemTime=RemTime*SpeedR;
                            Cevent.ServTime=RemTime; %aggiorno il nuovo tempo di permanenza
                            OccTime=Staz.Env.Time+Cevent.ServTime;
                            %OccTime=Staz.Env.Time+RemTime;
                            Cevent.OccurTime=OccTime;%Aggiorno il nuovo tempo di parteza
                           %%
                           EventArray(i)=Cevent;
                           i=i+1;
                        else
                            %nulla da fare tanto siamo alla fine
                        end
                    else
                        %qui esploramo un qualsiasi nodo della lista
                        Cevent=EvList.Data;
                        if ((Cevent.Station==Staz.Name)&&(Cevent.type==evType.Partenza))
                            [Cevent,EvList]=getEvent(EvList,1);
                            %% aggiornamento valori dell'envento
                            RemTime=Cevent.OccurTime-Staz.Env.Time;
                            RemTime=RemTime*SpeedR;
                            Cevent.ServTime=RemTime; %aggiorno il nuovo tempo di permanenza
                            OccTime=Staz.Env.Time+RemTime;
                            Cevent.OccurTime=OccTime;%Aggiorno il nuovo tempo di parteza
                            %%
                            EventArray(i)=Cevent;
                            i=i+1;
                        else
                            EvList=EvList.Next;
                        end
                    end
                end
            end
            if(~isempty(EvList))
                EvList=rewind(EvList);
            end
            %% Ora dobbiamo rischedulare tutti gli eventi che sono presentiin EventArray
            %if size(EventArray,2)==Staz.Nsys
                %controlla se ho saltato qualche evento: gli eventi da
                %rischedulare in un IS sono pari al numero di clienti
                %attualmente nel sistema IS
                for i=1:size(EventArray,2)
                    EvList=schedula(EvList,EventArray(i));
                end
                Staz.Env.EventList=EvList;
            %else
            %    warndlg('ATTENZIONE: n° eventi da rischedulare non congruo','Missing Events');
           %end
        end
    end
end