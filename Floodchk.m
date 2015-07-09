classdef Floodchk
    %Floodchk Controlla che ad ogni run ci sia almeno un flooding iniziale
    %delle stazioni
    
    %NOTA, in caso le statistiche non siano soddisfacenti qui posso imporre
    %dei vincoli su quando un run ha un numero di elementi sufficenti. Ad
    %esempio posso imporre che abbia almeno 20 partenze dalla prima
    %stazione in modo che le statistiche siano significative.
    properties
        Env
    end
    
    properties (Access=protected)
        NparCurrVector
        NarrCurrVector
    end
    
    methods
        function chk=Floodchk(InEnv)
            chk.Env=InEnv;
            for i=1:size(InEnv.StazArr,2)
                chk.NparCurrVector(i)=InEnv.StazArr{i}.Npar;
                chk.NarrCurrVector(i)=InEnv.StazArr{i}.Narr;
            end 
        end
        function test=isFlooded(flood, CurrEnv)
            test=true;
            for i=1:size(flood.NparCurrVector,2)
                test=test && (CurrEnv.StazArr{i}.Npar > flood.NparCurrVector(i));
                test=test && (CurrEnv.StazArr{i}.Narr > flood.NarrCurrVector(i));
            end
        end
        function flood_o=updFlood(flood, InEnv)
            for i=1:size(InEnv.StazArr,2)
                flood.NparCurrVector(i)=InEnv.StazArr{i}.Npar;
                flood.NarrCurrVector(i)=InEnv.StazArr{i}.Narr;
            end
            flood_o=flood;
        end
    end
    
end

