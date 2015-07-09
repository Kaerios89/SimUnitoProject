classdef Risultati
    %Oggetto che raccoglie i risultati di una stazione per una data run di
    %simularione
    
    properties
        %% identificativi di Stazione e Run
        IDRun
        NoStaz
        
        %% Variabili della stazione
           Nsys %Numero di clienti nel sistema
           Narr %Numero di arrivi nel sistema
           Npar %numero di partenze dal sistema
           Nmax %numero massimo di clienti che sono stati contemporaneamente nel sistema

           BusyTime % tempo totale in cui la stazione risulta occupata
           Area %area Sottesa alla curva
           X %Troughput
           U %utilizzazione
           En %No medio di clienti nel sistema
           Ew %Tempo medio di permanenza
           
           mu %velocità di servizio
           
           %% Roba scartata per presenza di più stazioni
           %lambda %tasso d'arrivo dei clienti 
           %nbar %numero atteso di preseze
    end
    
    methods
    end
    
end

