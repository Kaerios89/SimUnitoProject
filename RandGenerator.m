%congruo con funzioni
%Oggetto comune per la generazione di numeri casuali. Usa un generatore a
%Marsenne twister con un periodo di (2^19937)-1
classdef RandGenerator < handle
    properties (SetAccess=private)
        seed
        first
    end
    methods
        function RG=RandGenerator(seed)
            RG.seed=seed;
            rng(seed,'twister');
            RG.first=rand();
        end
        function num=EstraiRand(RG)
            num=rand();
            if num==RG.first
                %stranamente, abbiamo fatto il giro dell'anello del RNG,
                %tocca cambiare seed.
                rng(num,'twister');
                RG.seed=num;
                RG.first=rand();
            end
        end
    end
end