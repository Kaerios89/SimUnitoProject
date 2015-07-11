# SimUnitoProjetc
Progetto di simulazione di reti di code per il corso di Simulazione e Modelli della Magistrale di Unito

Progetto funzionante ma con alcuni problemi da risolvere. Provvederò presto a un readme più dettagliato, ma nel mentre non garantisco a nessuno che funzioni al primo colpo (prima leggere tutto il codice e capire cosa fa)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Potete fare quello che volete con il codice, ma se lo volete usare per il vostro progetto apprezzerei che contribuiste a completarlo, o quantomeno a sistemare una delle voci aperte espresse più in basso. So bene quanto sia difficile questo esame, per questo lo condivido con voi qui, se questo vi allevierà parte del carico, usate un parte dello stesso per rendere questo progetto completo. In cambio un mio sentito ringraziamento. xD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Il progetto principale è il simulatore ad eventi discreti. La classe Ambiente ha al suo interno tutte le strutture e imetodi necessari per l'inizializzazione e lesecuzione del simulatore; per inizializzare un ambiente c'è bisogno dei parametri del sistema (nel mio caso inclusi nei file "ModelloFinale*.mat". Una volta caricati basta vedere lo script EnvTest.m che mostra il funzionamento del simulatore e i metodi d'Ambiente invocati. 

Da notare che EnvTest è scritto per essere parallelizzato mediante i tool inclusi in matlab, ergo se si vuole usare una versione sequenziale basta usare il "for" al posto del "parfor".

Nella cartella "Primi Esercizzi" ci sono le prime due parti del progetto che comprendono l'analisi del sistema con metodi numerici:
  - BNA
  - Vettore delle visite
  - Analisi asintotica
  - Calcolo dei valori esatti usando le soluzioni sottoforma di prodotto
  - Calcolo dei valori esatti per Erlang-3 mediante catene di Markov
In questo caso il sistema fornisce una basilare GUI con cui è possibile creare da zero una rete di code, è possibile inoltre caricare un modello già fatto e eseguire tutti gli step elencati sopra.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COSE DA FARE.
  - Implementare Un sistema di inizializzazione delle stazioni con una distribuzione qualsiasi (magari presa da un file in input)
  - Implementare un eseguibile o comunque uno script (migliore di EnvTest) che non si limiti a eseguire, ma che analizzi i dati fornendo tabelle e grafici e salvando gli stessi.
  - In "primi Esercizzi":
    - Implementare tutta la parte del calcolo su catene di Markov in modo che sia parametrico e usabile su ogni combinazione di stazioni (ora funziona solo con il sistema oggetto del progetto)
    - Sistemare il calcolo del tempo di risposta R nel calcolo con catene di Markov. Per qualche motivo i risultati sono sbagliati, ho dovuto applicare a mano, data la matrice dei throughput (stranamente corretta), le formule per ricavare R.
  - Ripulitura del codice: questo progetto è stato in "work-in-progress" fino all'ultimo, quindi il codice è pieno di commenti senza senso, e di parti commentate per dei test e lasicate li. Va fatta un operazione di pulizia del codice che non è necessario e vanno risistemati i commenti rendendoli comprensibili e d'aiuto per tutti.
