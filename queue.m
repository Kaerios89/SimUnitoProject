%congruo con funzioni
% Implementazione di una coda usando i nodi di una lista doppiamente
% concatenata. Da notare che è sottoclasse di handle, e quindi è necessario
% prestare attenzione a come si modificano le proprietà di tale oggetto
classdef queue < dlnode
    properties
        head
    end
    methods
        
        function queue=queue(event)
            if nargin > 0
                queue.head=dlnode(event);
            else
                %queue.head=dlnode();
            end
        end
        function queue_o=accoda(queue, event)
            %%
            if(isempty(queue.head))
                queue.head=dlnode(event);
            else
            %%
                appo=queue.head;
                done=false;
                while(~done)
                    if(isempty(appo.Next))
                        %inserisci qui il nuovo nodo
                        insertAfter(dlnode(event),appo);
                        done=true;
                    else
                        appo=appo.Next;
                    end
                end
            end
            queue_o=queue;
        end
        function [event,queue_o]=prendi(queue)
            if(~isempty(queue.head))
                appo=queue.head.Next;
                event=queue.head.Data;
                removeNode(queue.head);
                queue.head=appo;
            else
                event=NaN;
            end
            queue_o=queue;
        end
    end
end