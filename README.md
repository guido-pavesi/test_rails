# README

## Setup:

```bash
bundle install
yarn install

rails db:create db:migrate
rails db:seed
```

Per avviare il server:
```bash
rails server
bin/webpack-dev-server
```

Per avviare i test:

```bash
bundle exec rspec
```

### Compiti:

a) L'api corrente /api/posts ha un problema di performance molto comune. Qual è? Come si potrebbe risolvere?

b) Implementare una nuova API nel PostsController che, ricevendo in GET un parametro "term" permetta di cercare per nome e per tag i post.

Ad esempio, cercando "gatto", verrà trovato un post che contiene la parola gatto o che ha almeno un tag che si chiama "gatto".

Per l'implementazione, utilizzare l'approccio "TDD". Per farla semplice, implementa semplicemente un test nella cartella spec/requests similare a quello già fatto per l'index

c) Implementare in Vue un'input form, modificando il componente app.vue, che permetta di filtrare i post utilizzando l'API creata precedentemente.

### Risposte:

a) Originariamente, per poter visualizzare l'elenco dei post con i relativi tag presenti in DB, veniva usata la funzione All, un metodo di ActiveRecord applicabile al modello, equivalente a findAll, per ricercare tutti i record di un modello, effettuando però più query (N+1) in base al numero di Post collegati ai Tags. Il modello in questione, Post, è collegato a Tags tramite una relazione 1-N. In Rails esiste il metodo includes che permette di accedere alle tags effettuando solo due query, aumentando così le performance.

b) Implementata funzione richiesta, vedi PostsController aggiornato. In particolare, se il termine da cercare è vuoto, vengono restituiti tutti i post. Ho inoltre aggiunto la route e i test relativi.

c) Ho modificato il file app.vue, aggiungendo nel template un semplice form con relativo stile. Ho aggiunto nei dati del componente la variabile "term" per memorizzare ciò che viene inserito e ho implementato un metodo che rimanda all'API creata precedentemente.