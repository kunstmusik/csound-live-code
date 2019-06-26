# Tutoriel 2 - Faisons notre propre son!

_AVERTISSEMENT de l'auteur de la version originale (Steven Yi): Ce tutoriel est en cours d’écriture et contient des informations incomplètes. Cet avis sera supprimé une fois le didacticiel terminé. Je vous remercie!

## Introduction

Dans ce didacticiel, nous allons créer nos propres sons (instruments) et parcourir une session de Live Coding Csound. Nous allons commencer par créer un simple instrument sinusoïdal, puis effectuer une série d’itérations pour rendre l’instrument plus agréable, puis travailler avec des événements composés et enfin programmer notre propre geste sonore. À la fin de ce didacticiel, nous disposerons d'une expérience du Live Coding avec Csound et nous serons en mesure de créer des sons qui conviendraient bien à une performance de musique ambiante.

## Concevons notre tout premier son 

Commençons par charger le site Web et effacer tout le code pour commencer avec un nouvel éditeur de code vide. Maintenant, commençons par taper le code suivant:

```csound
instr Add
  asig = oscili(0.25, 440)
  out(asig, asig)
endin

schedule("Add", 0, 2)
```

Sélectionnez et évaluer ce code à l’aide de ctrl-enter. Si tout va bien, vous devriez entendre une tonalité sinusoïdale de 440 hertz qui dure deux secondes. Félicitations et bienvenue dans le Live Coding avec Csound!

Maintenant, il y a beaucoup de choses qui nécessitent une explication. Premièrement, nous venons tout juste d’écrire du texte dans le langage Csound Orchestra pour définir un nouveau type d’instrument, nommé "Add", et planifié l’exécution d’une instance de cet instrument dans un délai de 0 seconde pour une durée de 2 secondes. Les sous-sections suivantes décrivent un peu plus en détail ce que tout cela signifie. Les détails sont très importants, mais n'hésitez pas à passer à la section suivante, "Développement de l'instrument", et à voir si cela a un sens intuitif pour vous. Sinon, vous pouvez toujours revenir ici plus tard!

### Définir un instrument

Dans Csound, les instruments sont définis par les utilisateurs en tant que processus exécutés par le moteur Csound. La définition de l'instrument décrit le traitement qui aura lieu lors de l'exécution d'une instance d'un instrument. Dans le code ci-dessus, nous voyons la ligne commençant par `instr` suivi d'un nom `Add`. Le mot instr commence une nouvelle définition d'instrument et le mot ou le numéro après instrument définit le nom ou le numéro de l'instrument. (Csound n'utilisait généralement que des instruments numérotés, mais les instruments nommés peuvent s'avérer beaucoup plus pratiques et ce sera l'usage dans ces tutoriels.) Plus bas, la ligne commençant par `endin` termine la définition de l'instrument. Chaque ligne de texte entre les lignes avec instr et endin est considérée comme un code qui définit le traitement que l'instrument effectuera lorsqu'il sera exécuté.

Le corps de la définition de l'instrument est constitué de deux lignes. Notez qu'ils sont visuellement en retrait. Nous allons utiliser cette pratique chaque fois que nous introduisons de nouveaux blocs de code (tels que des blocs de définition d'instrument, des blocs conditionnels et d'itération, etc.), car cela aide à voir quel code est associé à ce qui est en train d'être défini.

Quant aux deux lignes de code, on peut les lire comme suit:

Premièrement, nous voulons un opcode `oscili` configuré avec les paramètres 0.25 et 440 et dont la sortie sera affectée à la variable `asig`.
Ensuite, nous voulons un opcode `out` qui utilise les valeurs de `asig` et l’envoie à la sortie de Csound (c’est-à-dire à la sortie de la carte son).

Mais qu'est-ce qu'un opcode ? Les codes d'opération sont des unités de traitement individuelles capables de générer ou de traiter des données ou d'effectuer un type d'opération. Les codes d'opération peuvent prendre de zéro à plusieurs entrées et les sorties de zéro à plusieurs, tout en disposant de leurs propres données d'état internes. Dans le langage de la musique classique en informatique, les opcodes de Csound sont des générateurs d’unités.

Nous définissons les instruments à l'aide d'une série d'opcodes que nous configurons et connectons ensemble via des valeurs et des variables constantes. Nous pouvons considérer chaque code d'opération comme un module dans un synthétiseur modulaire et un instrument comme un synthétiseur complet.

Maintenant, pour utiliser un opcode, nous utilisons la syntaxe suivante : en premier le nom de l'opcode; une parenthèse ouvrante; une liste facultative de mots, chiffres, expressions et autres appels de code d'opération séparés par des virgules; et une parenthèse finale. Nous appelons les entrées entre parenthèses les arguments ou les entrées du code d'opération.

Pour récapituler, nous définissons les instruments comme des processus. Les instruments sont constitués d’opcodes, chacun pouvant effectuer un traitement quelconque. Définir les instruments ne définit que ce que nous voulons faire, mais ne fait rien. Pour exécuter l'instrument, nous devons créer une instance de l'instrument et dire à Csound de l'exécuter, et faire tout ce dont nous avons besoin pour utiliser des événements.

#### Classical Syntaxe classique vs. Syntaxe moderne

Un point supplémentaire cependant: le code que nous présentons ci-dessus utilise une version moderne du langage Orchestra de Csound, devenu disponible dans Csound 6. Dans la syntaxe classique de Csound, nous pourrions écrire l'instrument ci-dessus comme suit:

```csound
      instr   Add
asig  oscili  0.25, 440
      outc    asig, asig
      endin
```

Ce style utilise un appel d'opcode par ligne de texte et a la forme générale de:

```
[outputs] opcode_name [inputs]
```

où les sorties et les entrées sont des listes de mots et de nombres séparés par des coma. 

Nous utiliserons la syntaxe moderne dans ce tutoriel. Elle comporte quelques bizarreries parce qu’elle a été ajouté à une langue et à un système vieux de plus de 30 ans (et parce que nous supportons pleinement la compatibilité ascendante pour le style de code original), mais nous espérons que vous trouverez cela intuitif à utiliser lorsque nous effecturons des exercices.

Nous voudrions noter qu’il existe un scénario dans lequel nous devons utiliser l’ancienne syntaxe de style, c’est lorsque les opcodes génèrent plusieurs valeurs de sortie. Vous constaterez que dans ces situations, je vais utiliser l'ancienne syntaxe, mais uniquement dans ces situations. (Il s'agit d'une limitation dans Csound 6 qui a déjà été modifiée dans le code destiné à Csound 7.)

### Procès des événements

Une fois qu'un instrument est défini, nous pouvons créer des événements à l'aide de l'opcode `schedule()`:

```csound
schedule("Add", 0, 2)
```

L'opcode `schedule` prend en compte 3 arguments obligatoires et un nombre quelconque d'arguments supplémentaires. Ce qu'il dit, c'est : "planifier l'exécution d'une instance de l'instrument `Add`, à l'heure 0, pour une durée de 2 secondes". L'appel à planifier créera ensuite un événement, planifiera l'événement avec le planificateur en utilisant l'heure de début relative, puis reviendra. C'est le planificateur lui-même qui déclenche l'événement une fois que l'heure de début est atteinte. (Dans ce cas, en utilisant 0, nous disons :  "programmez un événement pour qu'il commence dans 0 seconde", qui exécute immédiatement l'instrument.) 

Si les instruments sont conçus pour utiliser des champs p supplémentaires, vous devrez alors fournir des valeurs supplémentaires sous forme d'arguments lorsque vous utiliserez la planification. Nous verrons comment cela fonctionne dans la section suivante lorsque nous ajouterons pfields et mettrons à jour notre appel d'horaire.

## Paramétrer l'instrument

À ce stade, l’instrument `Add` fonctionne et nous pouvons planifier son exécution et générer un son sinusoïdal de 440 hertz. Cependant, la façon dont nous "jouons" de l'instrument est assez limitée, car l'instrument n'a que les champs p par défaut. En réalité, tout ce que nous pouvons faire est de changer la durée d'utilisation de l'instrument.

Faisons maintenant un petit changement pour ajouter un pfield supplémentaire pour la fréquence. Nous faisons cela en plaçant `p4` dans notre code où nous voulons recevoir une valeur.

```csound
instr Add
  asig = oscili(0.25, p4)
  out(asig, asig)
endin

schedule("Add", 0, 2, 440)
```

Dans ce qui précède, nous avons apporté deux modifications:

1. Mise à jour de notre instrument pour utiliser une valeur p4. Les pfields de Csound vont être soit des nombres, soit des chaînes de caractères (données textuelles). Pour ce tutoriel, nous utiliserons pfields comme nombres. En outre, partout où nous avons un nombre statique dans notre code, nous pouvons le remplacer par un pfield. (Vous pouvez remplacer le 0.25 par un p5, par exemple.)
2. Mise à jour de notre appel de planification pour utiliser la valeur 440 comme quatrième argument. Cela sera affecté à la variable `p4` lors de l'exécution de l'instrument `Add`.

À ce stade, nous avons rendu l’instrument un peu plus polyvalent en faisant de la fréquence de l’oscillateur un paramètre. Changez la valeur que vous utilisez pour `p4` (par exemple, 440 en 220, 330, 880, etc.) et réévaluez la ligne de programme pour entendre des sinus de fréquences différentes.

## Ajoutons un oscillateur 

Un simple oscillateur est un bon point de départ, mais rendons maintenant l’instrument un peu plus intéressant.

Tout d'abord, ajoutons un oscillateur à notre instrument:

```csound
instr Add
  asig = oscili(0.25, p4)
  asig2 = oscili(0.25, p4 * 2)
  asum = asig + asig2
  out(asum, asum)
endin
```

Nous avons ajouté ici un oscillateur `oscili` supplémentaire, fonctionnant à deux fois la fréquence p4. Nous avons ensuite ajouté les deux signaux ensemble que nous avons affecté à la variable asum, puis utilisé cette valeur comme sortie. Evaluez l’appel `schedule()` maintenant pour entendre le nouveau son.

Une chose que nous pouvons faire à présent est d’utiliser une opération d’affectation légèrement différente pour raccourcir un peu le code:

```csound
instr Add
  asig = oscili(0.25, p4)
  asig += oscili(0.25, p4 * 2)
  out(asig, asig)
endin
```

Cette version de l'instrument sonne exactement comme la version précédente. Il utilise une affectation `+=` pour ajouter la valeur générée à droite du signe `+=` à la valeur à gauche, puis la réenregistrer dans la variable de gauche. La ligne avec le `+=` équivaut à l'écriture `asig = asig + oscili (0.25, p4 * 2)`. 

Au cours de ce tutoriel, chaque fois que nous apportons une modification à notre code, il est important de tester la modification. Dans ce cas, nous sélectionnons à nouveau le code de l'instrument, nous l'évaluons, puis sélectionnons le code schedule() et nous l'évaluons. Il est préférable de tester souvent afin d'éviter de trop nombreux changements, de constater que vous avez un problème, puis de vous gratter la tête pour déterminer lequel de tous les nouveaux changements est à l'origine du problème. Nous pouvons témoigner qu'il peut être très fastidieux de chercher une erreur dans un code même modestement étendu (note du traducteur).

## Modelons la sortie

L'instrument `Add` commence à produire des sons intéressants, mais le jouer à plein volume pendant toute la durée de la note peut être un peu fatiguant. Modifions maintenant le code pour définir l'amplitude du son en utilisant un générateur d'enveloppe exponentiel, comme suit:


```csound
instr Add
  asig = oscili(0.25, p4)
  asig += oscili(0.25, p4 * 2)
  asig *= expon(1, p3, 0.001)
  out(asig, asig)
endin
```

Le changement clé consistait à ajouter une ligne, `asig *= expon (1, p3, 0.001)`. Cette ligne utilise l'affectation `*=` qui fonctionne comme le `+=` mais multiplie la valeur du côté gauche (c’est-à-dire, code à gauche de l’opérateur d’affectation) par les résultats du code à droite. Cette ligne est équivalente à `asig = asig * expon (1, p3, 0.001)`.

`expon` est un opcode Csound classique prenant 3 valeurs: une valeur de début, une durée et une valeur de fin. L'opcode génère une courbe exponentielle allant de la valeur initiale à la valeur finale sur la durée donnée. (Ici, nous utilisons p3, la durée de l'instance d'instrument donnée lors de l'appel de `schedule()`.) Les enveloppes exponentielles ne peuvent pas être calculées à zéro. Nous utilisons donc 0,001 comme cible.

Le son commence à avoir de la vie. Nous pourrions également façonner le son de différentes manières en modifiant les valeurs d'amplitude des oscillateurs pour obtenir un mixage différent, en introduisant des générateurs d'enveloppe tels que `expon` ou `line` pour remplacer les valeurs statiques (chaque oscillateur pourrait avoir une enveloppe différente), en modifiant la fréquence temps, et ainsi de suite. Il est assez naturel dans Csound (et en réalité, dans n'importe quel système de synthèse) de commencer simplement avec des valeurs statiques, puis d'ajouter et de modifier de façon itérative notre code pour façonner et définir plus précisément le son jusqu'à obtenir le résultat souhaité.

Pour l'instant, mettons le design sonore de côté et voyons comment nous jouons de l'instrument lors de la planification d'événements.


## La palette des évènements

Jusqu'à présent, nous utilisions un seul appel d'opcode `schedule()` pour jouer exactement une instance de notre instrument. Cela conduit à un mappage individuel de la ligne de code au son généré et constitue un point de départ important. Même avec cela seul, nous pourrions nous asseoir et coder et jouer de la musique. Cependant, si nous ne faisions que modifier la ligne de code et la réévaluer pour obtenir des notes différentes à des moments différents, cela peut être un peu lent et limiter probablement le type de musique que nous vivons.

Une étape naturelle consiste à avoir plusieurs lignes de code pré-écrites que nous pourrions ensuite sélectionner et évaluer. Pensez-y comme si vous avez un clavier de piano devant vous: vous avez plusieurs touches qui produisent différentes notes sur le même instrument et vous sélectionnez et appuyez sur une touche pour obtenir un son différent. Cependant, dans notre cas, au lieu des clés physiques, nous aurons différentes lignes de code que nous pouvons sélectionner et évaluer. 
Entrez le code suivant:

```csound
schedule("Add", 0, 2, 440) 
schedule("Add", 0, 2, 550)
schedule("Add", 0, 2, 660)
schedule("Add", 0, 2, 880)
```

Evaluez chaque ligne de code une à la fois (sans sélectionner de code, vous pouvez appuyer sur ctrl-enter dans l’éditeur live.csound.com et la ligne de code actuelle ne sera exécutée que si elle n’est pas dans un instrument). Vous devriez ici obetnir un A, C #, E et A une octave ci-dessus. Chaque fois que vous évaluez le code, il programmera et ajoutera l’instrument de démarrage immédiat, fonctionnera pendant deux secondes, à la fréquence indiquée.  

Écrire plusieurs lignes comme celle-ci pour créer une palette de sons est un bon moyen d'explorer les capacités sonores d'un instrument et de lancer le processus d'improvisation et de performance.  

## Evènements composés

L’utilisation d'un mappage one-to-one event-to-sound est un point de départ. La prochaine étape consiste à produire plusieurs sons en utilisant one-to-many action. Commençons par réutiliser le dernier exemple de code. Toutefois, au lieu d’évaluer une ligne à la fois, sélectionnez deux lignes consécutives et évaluez le code. C'est une étape simple à suivre pour commencer à produire plusieurs notes avec des gestes simples.

La prochaine étape consiste à modifier la minuterie de début dans notre code:

```csound
schedule("Add", 0, 2, 440) 
schedule("Add", 2, 2, 550)
schedule("Add", 4, 2, 660)
schedule("Add", 6, 2, 880)
```

Voici que nous avons changé chaque appel `schedule()` pour utiliser des moments de début de 0, 2, 4 et 6. Si nous évaluons l'ensemble du bloc de code, nous aurons une séquence de notes. Encore une fois, nous avons une action un-à-un produisant plusieurs tonalités, mais nous commençons maintenant à étendre notre processus de réflexion, qui consiste à travailler avec du texte et un instrument, à penser aux développements musicaux dans le temps. 

Une chose à noter est différente de l'étape précédente, le code ne se prête plus à la lecture de notes individuellement. Si nous essayons d’évaluer uniquement les deux dernières notes, la première note sera programmée à 4 secondes et la seconde à 6 secondes. Cela signifie que le code que nous avons écrit a commencé à utiliser des relations entre les éléments et doit être utilisé dans son ensemble plutôt que dans ses parties. (Il existe des moyens de contourner ce problème en adoptant différentes approches basées sur les données, ce qui dépasse le cadre de ce tutoriel.)

Maintenant que nous travaillons avec un ensemble de code qui commence à fonctionner comme un simple geste, emballons notre code de manière à exprimer cette intention à l'aide d'un instrument:

```csound
instr Arpeggio 
  schedule("Add", 0, 2, 440) 
  schedule("Add", 2, 2, 550)
  schedule("Add", 4, 2, 660)
  schedule("Add", 6, 2, 880)
endin

schedule("Arpeggio", 0, 0)
```

Essayez d’évaluer l’arpège puis le `schedule` final. Vous devriez maintenant entendre l'arpège exécuté chaque fois que vous utilisez l'un des instruments. Evaluez la ligne de planification des arpèges à plusieurs reprises sans attendre que les précédentes soient achevées, vous entendrez l'arpège s'enrouler sur lui-même. 

Une notion intéressante ici est que nous utilisons une durée de 0 pour la ligne `schedule()`. La raison pour laquelle nous faisons cela ici est que notre instrument Arpeggio est composé de code qui ne s'exécute qu'au moment de l'initialisation. Cependant, les instruments seront généralement toujours exécutés pour la durée donnée lors de la création d'une instance de l'instrument. Si nous n'utilisons pas la durée 0, l'instrument fonctionnera au moment de l'exécution (comme notre instrument Add), mais il ne fera rien, car il n'y a pas de code performance-time. L’utilisation de la durée 0 présente donc deux avantages: elle garantit que nous ne gaspillons aucun cycle de calcul pour un instrument réellement vide au moment des performances et qu’il est également facile de voir dans notre code que nous appelons des instruments conçus pour démarrer au moment prévu

## Exemple complet

```csound
instr Add
  alfo = 1 + oscili(random(0.002, 0.01), random(0.2,3))
  
  asig = oscili(1, p4 * alfo)
  asig += oscili(1, p4 * 2 * alfo)
  
  asig *= 0.25 * p5 * expon(1, p3, 0.001)
  
  out(asig, asig)
endin

instr Chord
  isd = random(0, 12)
  schedule("Add", 0, 30, in_scale(rand(array(-1,0)), isd), ampdbfs(-12))
  schedule("Add", 0, 30, in_scale(rand(array(-1,0)), isd + 4), ampdbfs(-12))
endin

instr Run
  schedule("Chord", 0, 0)
  
  if(p4 < 5) then
    schedule(p1, 10, 1, p4 + 1)
  endif
endin

schedule("Run", 0, 0)
```
