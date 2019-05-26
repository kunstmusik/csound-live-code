# Déroulement d'une session

Ce qui suit décrit les cycles successifs d'une session en Live Coding. 

## Les cycles du moteur audio de base

Le diagramme suivant illustre le flux de traitement de base d'un moteur audio. Le diagramme montre les deux phases principales d’initialisation et d’exécution et sera expliqué plus en détail dans les sections ci-dessous.

![Audio Engine Lifecycle](../doc/images/audio_engine.png)

## Initialisation

Lorsqu'un utilisateur commence une session, il démarre son moteur audio avec un ensemble donné
d'options. Ces options peuvent être des drapeaux de ligne de commande, des paramètres de programme sauvés,
ou d'autres sources de configuration. Le programme commence par traiter ces
options et configuration du moteur pour l'exécution.

Ensuite, tout code initial est évalué. Par exemple, un document CSD est souvent
fourni à Csound en tant que projet à rendre. Ce code initial peut décrire
pleinement tout ce qui sera rendu -- comme c'est le cas lors de la création
projets non-temps réel destinés à un rendu sur disque -- ou il peut être une configuration de base pour
une performance en temps réel.

Dans le cas de csound-live-code, ce projet fournit un fichier livecode.orc principal
qui contient toute la bibliothèque de code du projet. Il y a aussi
un fichier livecode.csd lié à un #include avec la configuration d'autres options. On peut utiliser le fichier CSD comme code initial lorsqu’on travaille sur un
système de bureau de sorte que lorsque Csound entre dans sa boucle de rendu principale, il sera
prêt pour le codage en direct.

## Runtime

Une fois le moteur initialisé, nous démarrons la boucle de traitement principale du moteur.
La boucle principale dans les moteurs audio peut différer dans ses caractéristiques (par exemple, certains
moteurs peuvent ne pas inclure les scheduleurs) et la mise en œuvre, mais le diagramme ci-dessus
s'applique généralement à la plupart des moteurs.


### Gérer les messages

Les messages sont des structures de données décrivant certaines opérations que le moteur doit effectuer. Ces messages sont envoyés au moteur et placés dans une boîte de réception.
(par exemple, une file d'attente sans verrouillage) où ils attendent que le moteur prenne
les nouveaux messages de la file d'attente et les traite.

Les messages peuvent prendre différentes formes et emprunter différents canaux.
Par exemple, un moteur comme Csound a des files d'attente pour les données MIDI entrantes, les données OSC,
évaluations de code en attente, données de score entrantes, etc.

### Procès des événements

Les moteurs, tels que Csound, qui ont des scheduleurs traiteront en suivant les événements.
Les événements sont comme des messages dans la mesure où ils décrivent une opération que le moteur
doit effectuer, mais ils sont également affectés d'une heure de début. Quand le moteur
se met à traiter les événements, il vérifie les heures de début des événements et les compare au
temps moteur en cours pour déterminer si un événement doit déclencher une action et être
retiré de la file d'attente. Les événements peuvent faire des choses comme exécuter du code, instancier
et commencez à utiliser de nouveaux instruments, et plus encore.

Les événements sont généralement une abstraction exposée aux utilisateurs qui les utiliseront
directement, alors que les messages sont généralement une implémentation interne
avec laquelle le moteur fonctionne.

### Entrée, bloc de rendu, sortie

Enfin, le moteur transfère les données entrantes dans le moteur (par exemple, en lisant
l'entrée audio depuis une carte son), restitue un bloc de traitement (par exemple, générer
et traiter 32 échantillons de données; programmer en interne de nouveaux événements), et
transfère les données sortantes du moteur (par exemple, l’écriture de la sortie audio sur une
carte son). Lorsque cela est fait, le moteur vérifie si l'exécution doit s'arrêter. Si c'est le cas,
le moteur effectue des opérations de nettoyage et s'achève; sinon, il retourne au
début de la boucle et continue.

## Note sur les moteurs

Les moteurs utilisent généralement a _single-sample_ or _block_ processing model.
Dans le premier cas, la boucle principale s’exécute une fois pour chaque échantillon audio,
dans le deuxième cas, la boucle devrait s’exécuter une fois pour un certain nombre d'
échantillons (par exemple, en utilisant ksmps = 32 dans un projet Csound, il demande à Csound de traiter 32
échantillons à la fois). Parce que le traitement des messages et des événements a lieu pour tous les
échantillon, le calendrier des événements et des messages peut être plus précis que le traitement par bloc. 
Le compromis est que le traitement en bloc donne généralement de meilleures
performances (meilleure localisation des données pour le traitement, plus d'opérations effectuées sur
pile plutôt que le tas, moins de surcharge d’appel de fonction).
