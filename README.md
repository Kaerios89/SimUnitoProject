# SimUnitoProjetc
Progetto di simulazione di reti di code per il corso di Simulazione e Modelli della Magistrale di Unito

Progetto funzionante ma con alcuni problemi da risolvere. Provvederò presto a un readme più dettagliato, ma nel mentre non garantisco a nessuno che funzioni al primo colpo (prima leggere tutto il codice e capire cosa fa)

Il progetto principale è il simulatore ad eventi discreti. La classe Ambiente ha al suo interno tutte le strutture e imetodi necessari per l'inizializzazione e lesecuzione del simulatore; per inizializzare un ambiente c'è bisogno dei parametri del sistema (nel mio caso inclusi nei file "ModelloFinale*.mat". Una volta caricati basta vedere lo script EnvTest.m che mostra il funzionamento del simulatore e i metodi d'Ambiente invocati. 

Da notare che EnvTest è scritto per essere parallelizzato mediante i tool inclusi in matlab, ergo se si vuole usare una versione sequenziale basta usare il "for" al posto del "parfor".

COSE DA FARE.
  - Implementare Un sistema di inizializzazione delle stazioni con una distribuzione qualsiasi (magari presa da un file in input)
  - Implementare un eseguibile o comunque uno script (migliore di EnvTest) che non si limiti a eseguire, ma che analizzi i dati fornendo tabelle e grafici e salvando gli stessi.
