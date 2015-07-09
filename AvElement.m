%coerente con funzioni
classdef AvElement
    properties
        A
        v
    end
    methods
        function newObj=AvElement(A,v)
            newObj.A=A;
            newObj.v=v;
        end
    end
end