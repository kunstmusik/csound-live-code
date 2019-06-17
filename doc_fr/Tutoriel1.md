# Tutoriel 1 - Faisons un son!

## Introduction

Bienvenue! Dans ce tutoriel, nous allons apprendre à connaître l'application Csound-Live-Code, en apprendre un peu plus sur Csound et faire nos premiers sons en utilisant des synthétiseurs pré-construits. À la fin, vous aurez une petite idée de ce à quoi ressemble le codage en live avec Csound et vous serez prêts à passer aux étapes suivantes:
faire vos propres synthétiseurs!

## A propos de l'environnement internet

Commençons par ouvrir l' Application Web [csound-live-code](https://live.csound.com). Vous devriez voir la barre du haut avec un bouton pause / lecture et un bouton d'aide, deux autres boutons, l'un pour évaluer le code immédiatement et l'autre pour l'évaluer à partir de la mesure suivante, ainsi que, sous la barre, la zone d'édition du code. L'éditeur contiendra, par défaut, un exemple de codage. Juste pour vérifiez que tout fonctionne correctement, cliquez dans l'éditeur de code pour le mettre en évidence, appuyez sur `ctrl-a` pour sélectionner tout le texte, puis appuyez sur
`ctrl-entrer` pour évaluer le code. À ce stade, vous devriez commencer à entendre la musique produite par le code.

Vous entendez la musique, c'est fantastique !  

Oh, vous n'entendez pas le son? Eh bien, cherchons la cause. il est probable que le navigateur que vous utilisez ne prend pas en charge les fonctionnalités nécessaires,
qui sont:

1. WebAudio API 
2. WebAssembly

Si vous savez que ceux-ci fonctionnent pour votre navigateur, vous pouvez essayer de vérifier
la console Javascript de votre navigateur (option menu "outils de développement" généralement). La console est aussi l'endroit où les erreurs Javascript sont signalées comme toute sortie de Csound.

Si rien d’évident n’est signalé ou si vous utilisez un navigateur
où la console javascript n’est pas accessible (i.e., iOS ou Android), veuillez
contacter l'auteur. Les tests sont généralement faits sous Windows 10 avec Chrome,
Firefox et Edge; Navigateur Chrome OS; et Chrome sur Android; ça pourrait venir
de l'utilisation d'une configuration que l'auteur doit rechercher et tester.

## Notre premier son

Mais il est probable que tout fonctionne correctement. Actualisons le site Web et
effaçons le code présent pour commencer avec un nouvel éditeur de code vide.
Saisissez le code suivant:

```csound
schedule("Sub1", 0, 2, 440, 0.5)
```

(Remarque: pour ces tutoriels, vous pouvez copier/coller le code pour faire vos essais, cependant, si vous avez le temps, nous vous recommandons dès maintenant d'entrer le code au clavier ce qui vous permettra d'assimiler plus vite les caractéristiques de cette programmation.)

Essayez de sélectionner le code et de l’évaluer en utilisant `ctrl-enter` ou l’un des
boutons d'évaluation. Si tout va bien, vous devriez entendre le synthétiseur `Sub1`
jouer à 440 hertz avec un volume de 0,5 (environ la moitié de la valeur maximale de 1,0).
Félicitations et bienvenue dans le codage en direct avec Csound!

## Les concepts de Csound

Alors, qu'est-ce que tout ce qui précède? Dans Csound, nous avons quelques abstractions/concepts principaux:

1. __Values__ sont des données. Il existe différents types de données disponibles dans
   Csound, mais pour ces tutoriels, nous allons nous concentrer sur les données numériques (par exemple, 0, 2,
   0.5) et les données nominales (par exemple, "Sub1"). Parfois, nous écrirons directement des valeurs dans
   notre code, comme dans l'exemple ci-dessus, et d'autres fois, nous travaillerons avec des valeurs générées et traitées.
2. __Variables__ sont des éléments nommés en mémoire qui contiennent _values_. Nous faisons généralement
   seulement deux choses avec des variables, qui consistent à lire, _read_, la valeur de variable
  ou écrire, _write_, une valeur dans la variable. Les variables sont importantes pour la connexion des différentes unités de traitement et pour attribuer des noms aux choses, ce qui
   contribue à rendre notre code plus facile à écrire et à comprendre. (Si vous venez de
   système de patch, virtuel ou analogique, vous pouvez considérer les variables comme
   les câbles qui connectent les modules et par lesquels les valeurs sont transférées vers et
   de chacun d'eux.)
3. __Opcodes__ sont des unités de traitement individuelles (_unités génératrices_ dans le
   langage des systèmes MUSIC-N). Les opcodes générent, traitent et consomment des données. Nous pouvons penser à des variables comme noms et _opcodes_ en tant que verbes dans le langage de programmation de Csound. Les opcodes ont un
   cycle de vie où ils peuvent effectuer des opérations quand ils sont instanciés
   (init-time); pendant la performance du moteur (perf-time), et quand ils sont
   disposés (destruction-time), (nous n'aurons pas à nous inquiéter trop de tout cela pour l'instant). Certains opcodes n'effectuent des opérations qu'au moment de l'initialisation, alors que d'autres le font
   au moment de la performance, et nous utilisons ces opcodes différemment. Ça va être important de
   comprendre cela, mais nous allons passer à autre chose et revenir à cela dans le
   prochain tutoriel.
4. __Instruments__ sont des objets qui définissent un processus via un ensemble de variables
et une série d'opcodes. Le nom _instrument_ vient de MUSIC-N et nous * utilisons * souvent
des instruments Csound comme des instruments traditionnels, c'est-à-dire dans le but de faire du son, de la musique. Cependant, les instruments Csound sont des processus génériques, et nous pouvons les utiliser pour faire
un certain nombre de tâches, telles que les effets permanents, le mixage, la génération de partitions et
   plus. De plus, les instruments fonctionnent avec les événements, c’est-à-dire que nous pouvons les
   programmer pour qu'ils s'exécutent à un moment donné et pour une durée donnée.
5. __Evénements__ sont des messages qui ont un type, un début et une durée. Csound
   inclut un planificateur qui contient les événements et, lorsque le moteur traite le
   temps, il lit les événements en attente et déclenche les actions en fonction de leur
   type. Pour ces tutoriels, le seul type d’événement qui nous intéressera est
   créer de nouvelles instances d’instrument, que nous pouvons considérer comme "jouer une note pour
   cet instrument" ou "joue ce son".

## Utilisons des Opcodes

Revenons à notre premier exemple:

```csound
schedule("Sub1", 0, 2, 440, 0.5)
```
Nous appelons l'opcode `schedule` pour effectuer une opération en utilisant le code d'orchestre de Csound. Dans la syntaxe moderne (parfois appelée _function-call_syntaxe dans la communauté), nous appelons un opcode en écrivant son nom, utilisons des parenthèses, une liste de zéro à plusieurs _arguments_ séparés par des virgules. Les valeurs entre parenthèses que nous donnons à l'opcode doivent faire correspondre le nombre attendu d'arguments définis pour l'opcode
ainsi que les types de données pour chaque argument. Le nombre et les types d'arguments
sont définis par l'opcode et la façon dont nous apprenons à leur sujet est en recherchant la
Documentation. (Par exemple, voir l’entrée du manuel de référence pour l'opcode
[schedule](https://csound.com/docs/manual-fr/schedule.html). Nous pouvons nous réjouir qu'une version française du manuel de Csound soit maintenue à jour (note du traducteur).

Ici, l'opcode `schedule` nécessite au moins trois arguments mais il
admet une quantité illimitée d'arguments supplémentaires. Cela nous permet d' utiliser l'opcode avec des instruments pouvant nécessiter un nombre différent de
paramètres à donner. Pour ce tutoriel, nous allons utiliser `schedule` juste
comme ci-dessus avec cinq arguments et discuterons des arguments et des paramètres de l'instrument
dans le prochain tutoriel.

## Explorons les instruments 

Les instruments fournis avec csound-live-code sont tous conçus pour utiliser cinq
paramètres. Les trois premiers sont intégrés à chaque instrument tandis que le quatrième
et le cinquième sont définis par l'utilisateur. Les paramètres sont:

* p1 - l’identifiant numérique de l’instrument (les instruments nommés, comme Sub1, ont un
   ID attribué automatiquement)
* p2 - début d'exécution de l'instrument
* p3 - durée d'exécution de l'instrument
* p4 - fréquence en hertz
* p5 - amplitude ajustée à la plage `0dbfs` (` 0dbfs` est un paramètre définissable par l'utilisateur
   pour la plage d'amplitude du système. Il est communément défini comme une plage de 0-1.0, il en est ainsi pour csound-live-code)

Explorons maintenant les différents paramètres. Il me semble important de s'efforcer de retenir l'identification numérique des paramètres, c'est pourquoi je les ai rappelé en sous-titre (le traducteur).

### Début ou p2

La donnée de démarrage affecte le moment où l'instrument va fonctionner et la valeur numérique est relative à l'heure actuelle. Par exemple, lorsque nous utilisons 0, cela signifie "0 secondes à partir de maintenant", soit immédiatement. Vous pouvez essayer de changer la valeur elle-même en utilisant des valeurs positives. Lorsque vous évaluez le code mis à jour, il devrait maintenant commencer la note un certain temps après avoir déclenché l'évaluation. Une chose à essayer est d’écrire plusieurs lignes et d’utiliser différentes heures de début.

```csound
schedule("Sub1", 0, 2, 440, 0.5)
schedule("Sub1", 3, 2, 440, 0.5)
```

Cela devrait jouer deux notes, chacune d'une durée de deux secondes, avec la deuxième note commençant 1 seconde après la fin de la première note.

### Durée ou p3

Maintenant, voyons la durée. Essayez de modifier le troisième paramètre et d’évaluer la
ligne. Par exemple, pour que la durée soit de 4 secondes ou 1 seconde, vous devriez
écrire les lignes comme suit:

```csound
schedule("Sub1", 0, 4, 440, 0.5)
schedule("Sub1", 0, 1, 440, 0.5)
```
Avec les valeurs ainsi modifiées, vous devriez pouvoir faire varier le son de l'instrument sur la longueur et la durée si vous mettez à jour et réévaluez le code. 

### Fréquence ou p4

Ensuite, gardons la même durée mais en modifiant la fréquence.
Essayez d’utiliser les valeurs 110, 220, 880 au lieu de 440, comme suit: 

```csound
schedule("Sub1", 0, 2, 110, 0.5)
schedule("Sub1", 0, 2, 220, 0.5)
schedule("Sub1", 0, 2, 880, 0.5)
```

Vous devriez entendre le son de l’instrument `Sub1` à différentes hauteurs.

Maintenant, il peut sembler étrange que nous utilisions la fréquence ici car nous pourrions avoir tendance à penser plus
en termes de gammes et de noms de note ou autre choses plus musicales. Ne vous inquiétez pas, nous aurons matière à travailler avec ces types de valeurs en utilisant des appels d'opcodes supplémentaires. (La
raison pour laquelle les instruments se notent en fréquence est que cela permet à l'utilisateur final de
choisir le système de réglage ou de hauteur qu’il aimerait utiliser et rend les
instruments réutilisables par tout le monde.)

### Amplitude ou p5

Modifions à présent la dernière valeur. Soyez ** très ** prudent et n'utilisez que les valeurs numériques comprises entre 0 et 1.0: définir une valeur supérieure à 1.0 peut provoquer des bruits très forts en sortie (évitons les casques audio pour l'instant) 

```csound
schedule("Sub1", 0, 2, 110, 0.25)
schedule("Sub1", 0, 2, 220, 0.1)
schedule("Sub1", 0, 2, 880, 0.05)
```

Comme pour la fréquence, nous sommes probablement habitués à penser à des valeurs dans une autre échelle,
tels que décibels, marquage dynamique (par exemple, "f", "mp", "p") ou valeurs d’ampli MIDI.
Pour la même raison que la fréquence, les instruments sont conçus pour être flexibles et
réutilisables et nous allons passer par différentes façons de travailler avec l'amplitude
plus tard dans ces tutoriels.

### Le nom de l'instrument ou p1

Enfin, expérimentons le nom de l’instrument. csound-live-code fournit un jeu
d’instruments mélodiques ainsi que de percussions (de Iain McCurdy's
Simulation TR808). Tous ces instruments prennent en compte les cinq paramètres, bien que
les instruments non mélodiques ignoreront la valeur de la fréquence.

| Mélodiques | 
| ------- | 
| Sub1 |       `            
| Sub2 |
| Sub3 |
| Sub4 |
| Sub5 |
| SynBrass |
| Plk |
| Bass |
| VoxHumana |
| FM1 |
| Noi |
| Wobble |

| Percussions |        
| ---------- |        
|  Clap |  
|  BD   |  
|  SD   |  
|  OHH  |  
|  CHH  |  
|  HiTom  | 
|  MidTom  |  
|  LowTom   | 
|  Cymbal   | 
|  Rimshot  | 
|  Claves |  |
|  Cowbell |  
|  Maraca   | 
|  HiConga  | 
|  MidConga   |  
|  LowConga   |  

Dans votre code, remplacez le "Sub1" par chacun des éléments ci-dessus et évaluez le code mis à jour pour entendre le son de chaque patch.
