%coerente con funzioni
classdef ConfPoint
    properties
        Value
        Upper
        Lower
    end
    methods
        function NewPoint=ConfPoint(v,l,u)
            NewPoint.Value=v;
            NewPoint.Upper=u;
            NewPoint.Lower=l;
        end
    end
end