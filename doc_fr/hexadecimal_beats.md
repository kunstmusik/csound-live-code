# Hexadecimal Beats

Hexadécimal Beats est un système hexadécimal (base 16) pour la notation des patterns rythmiques. Il permet de noter un jeu de quatre seizièmes de notes (doubles croches) en utilisant un seul caractère. Le système correspond bien aux pratiques de programmation de batterie et de séquenceur modulaire et est utile pour la programmation de batterie et de lignes mélodiques pour la musique synchronisée.

NOTE: J'avais développé (Steven Yi) et travaillé avec ce système pendant quelques années avant de rencontrer un travail antérieur de Bernhard Wagner dans [Rythmics Patterns As Binary Numbers](http://bernhardwagner.net/musings/RPABN.html) ou Wagner discute de l'utilisation de la notation et donne des exemples interprétés par des instrumentistes, ainsi que des opérations de décalage de bits et de complémentation.

## Hexadecimal (Base 16), Binary (Base 2), et Base 10

Un chiffre hexadécimal est écrit en utilisant les chiffres 0 à 9 et les lettres a-f. Chaque chiffre correspond à l'un des chiffres de base 10 compris entre 0 et 15. Un seul chiffre hexadécimal équivaut à un nombre de base 2 à quatre chiffres (c'est-à-dire 4 bits). Si les 1 et les 0 de la base 2 sont interprétés comme des notes brisées et des silences, un seul chiffre hexadécimal peut représenter un temps composé de quatre seizièmes notes. 

| Hex | Binary | Base 10 | 
|:--:|:--:|:--:|
|0 | 0000 | 00 | 
|1 | 0001 | 01 | 
|2 | 0010 | 02 | 
|3 | 0011 | 03 | 
|4 | 0100 | 04 | 
|5 | 0101 | 05 | 
|6 | 0110 | 06 | 
|7 | 0111 | 07 | 
|8 | 1000 | 08 | 
|9 | 1001 | 09 | 
|a | 1010 | 10 | 
|b | 1011 | 11 | 
|c | 1100 | 12 | 
|d | 1101 | 13 | 
|e | 1110 | 14 | 
|f | 1111 | 15 | 

## Conversion du rythme en Hex

Noter en Hex peut nécessiter un peu d'entraînement, mais une fois maîtrisé, il se révèle très rapide pour noter des idées rythmiques. Pour interpréter un motif de quatre double-croches en hex:

1. Visualisez d’abord les seizièmes de notes, puis voyez les on et off comme 1 et 0 et convertissez le rythme en binaire. Par exemple, deux huitièmes de notes (croches) peuvent ressembler à «1010».
2. Convertir en binaire: chaque chiffre représente une puissance de 2 et correspond à «8421». Si le chiffre du rythme est un 1, regardez la correspondance et utilisez cette valeur. Par exemple, pour «1010», nous avons un 8 et un 2, ce qui revient à 10.
3. Convertir en hexadécimal: à partir de 10, vous pouvez rechercher dans le tableau quelle est la valeur hexadécimale correspondante, qui est `a`.   

## Valeurs de la notation Hex Beat

1. Avec la pratique, on se familiarise avec chacune des valeurs hexadécimales et comment les utiliser pour noter un rythme.
2. Les valeurs hexadécimales ressortent et facilitent la mémorisation des rythmes courants (par exemple, `9228` est un rythme 4/4 _Son Clave_).
3. L'Hexadécimal est un format de données compressé. Il faut moins de caractères pour exprimer un rythme que dans une représentation binaire ou une notation [Time Unit Box System (TUBS)] (https://en.wikipedia.org/wiki/Time_unit_box_system).

## Inconvénients de la notation Hex Beat

1. Les beats hexadécimaux ne fonctionnent qu’avec les divisions d'un seixième de note (double-croche) pour 1 beat. (Bien qu'il y ait des astuces pour développer des modèles au 32ème, voir "Pirater des 32ème de noire" ci-dessous)

## hexbeat() et hexplay()

livecode.orc fournit deux opcodes pour interpréter les chaînes de beats hexadécimales comme des patterns. Tout d'abord, hexbeat() prend la chaîne hexadécimale comme premier argument et une valeur d'index optionnelle. Si aucune valeur d'index n'est donnée, le tick d'horloge actuel est utilisé. L'opcode renvoie un 1 si le tick donné correspond à un hit et un 0 s'il correspond à un silence. Par exemple, avec une valeur hexadécimale de «8» --, qui se traduit par «1000» en binaire --, le code suivant produira les valeurs suivantes:

```csound
  ival1 = hexbeat("8", 0) ;; ival1 equals 1
  ival2 = hexbeat("8", 1) ;; ival2 equals 0
  ival3 = hexbeat("8", 2) ;; ival3 equals 0
  ival4 = hexbeat("8", 3) ;; ival4 equals 0
```

La valeur de sortie de `hexbeat()` étant un 1 ou 0, elle peut être utilisée pour contrôler les apparitions soit par test conditionnel, soit par multiplication pour l'amplitude. Par exemple:

```csound
  if (hexbeat("80") == 1) then
    schedule("Sub1", 0, ticks(1), in_scale(0,0), ampdbfs(-12))
  endif
```

vérifie que le tic actuel d'horloge correspond à la chaîne de beat hexadécimale et, si le tic correspond au réglage, le test renvoir un 1 et autorise l'exécution du bloc "if".

Une autre façon d'utiliser la sortie `hexbeat()` consiste à la coupler avec `cause()` et à multiplier l'amplitude par le résultat de `hexbeat()`. Par exemple, ce qui suit donnera le même résultat que l'exemple précédent:

```csound
cause("Sub1", 0, ticks(1), in_scale(0,0), ampdbfs(-12) * hexbeat("80"))
```

`cause ()` est conçu pour ne se déclencher que lorsque son cinquième argument (amplitude) est supérieur à 0, les notes de `Sub1` ne se déclencheront que conformément à la notation de temps hexadécimal.

## Apprentissage de la notation en Hex Beats

Le circuit d'apprentissage suggérée est de commencer de façon simple pour aller vers plus complexe progressivement.

1. Commencez par essayer de travailler uniquement avec les chaînes `8` et` 0`. Cela équivaudra à noter avec seulement des noires et des pauses (sur 1 temps de la mesure). Essayez d’utiliser un appel `hexplay()` avec un instrument `BD` et un pattern `8`. Essayez de modifier la chaîne hexagonale en "80", puis "8000", et voyez comment cela affecte le rythme. Ensuite, essayez d’ajouter un appel `hexplay()` supplémentaire avec un modèle d’instrument `SD` de` 08`. Essayez ensuite de modifier le rythme `SD` en` 0800` et voyez comment cela affecte le rythme.

2. Après avoir noté les rythmes de noires, essayez de travailler avec des rythmes de 8eme de noire (croches). Celles-ci seraient `8`,` 0`, `2` et` a`. Encore une fois, commencez avec un motif `BD`, puis travaillez à nouveau avec un deuxième motif` SD` avec un rythme complémentaire.

3. Après avoir travaillé à la 8ème, essayez de travailler avec les différents rythmes avec une seule 16ème de note. Ce sont «8», «4», «2» et «1». Essayez-les chacun de leur côté, puis combinez-les avec des rythmes de 8ème et de noire.

4. Ensuite, essayez les rythmes à deux 16ème de notes. Celles-ci seraient «a», «9», «c», «6», «3» et «5».

5. Enfin, expérimentez les rythmes à trois 16ème de notes (`b`,` d`, `e`) et puis seulement des 16ème (` f`).

De plus, je recommanderais fortement de pratiquer en:

1. Notant les rythmes que vous entendez dans la musique.

2. Reproduisant les 808 patterns trouvés sur le site Web [808 Drum Patterns] (http://808.pixll.de/). Il existe de nombreux modèles à choisir et dans de nombreux styles différents. 

## Pirater des 32eme de Noire (triples croches)

Tandis que Hex Beats fonctionne au 16ème de noire, un hack permet de développer les rythmes en 32ème en utilisant un décalage du temps de début. Dans l'exemple ci-dessous, deux modèles sont configurés pour déclencher l'instrument _CHH_ (Closed High Hat). Le premier utilise un appel standard hexplay() pour générer les 16emes habituelles. La seconde utilise un appel cause() avec une heure de début `p3/2` (p3 est égal à la longueur actuelle du tick ou à la durée d’une croche). Les deux ensemble donneront au rythme généré une 32ème de noire de remplissage sur le quatrième temps de chaque mesure. 

```csound
set_tempo(85)

instr P1
  
  hexplay("a",
      "Sub2", p3,
      in_scale(-1, 2),
      fade_in(11, 128) * ampdbfs(xlin(phsm(8), -18, -30)))

  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, ((p4 % 16) == 13) ? 7 : 0),
      fade_in(10, 128) * ampdbfs(-12))
  
  hexplay("00000aaa",
      "Clap", p3,
      in_scale(-1, 0),
      fade_in(9, 128) * ampdbfs(xlin(phsm(4), -20, -12)))

  hexplay("aaff",
      "CHH", p3,
      in_scale(-1, 0),
      ampdbfs(-12))

  cause("CHH", p3/2, p3, 0, ampdbfs(-12) * hexbeat("0000000f"))

  hexplay("080c",
      "SD", p3,
      in_scale(-1, 0),
      fade_in(8, 128) * ampdbfs(-12))

  hexplay("91569154",
      "BD", p3,
      in_scale(-1, 0),
      fade_in(7, 128) * ampdbfs(-9))

endin
```

## Manipuler la courbe des hauteurs (Pitch Curve)

Dans l'exemple précédent, des calculs numériques ont été utilisés pour déterminer si un tick particulier a été trouvé et, le cas échéant, pour générer un degré dans la gamme:

```csound
  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, ((p4 % 16) == 13) ? 7 : 0),
      fade_in(10, 128) * ampdbfs(-12))
```

Le calcul vérifie si le `p4` (le tick actuel ou la 16e de noire) est égal à 13 (ce qui correspond au second hit du motif `c` hex) et, le cas échéant, à générer un 7, sinon un 0. Cela signifie que nous voulons que toutes les notes soient 0 sauf pour un 7 quand est sur le tick 13.

Une autre façon d’exprimer le même calcul consiste à utiliser `hexbeat()` pour générer un 1 ou un 0, puis à le multiplier par 7, comme suit:

```csound
  hexplay("f00c",
      "Sub5", p3,
      in_scale(-2, hexbeat("0004") * 7),
      fade_in(10, 128) * ampdbfs(-12))
```

Utiliser `hexbeat()` de cette manière peut être un moyen rapide de générer des modèles de hauteur alternant deux valeurs. `hexbeat()` pourrait être utilisé pour affecter la durée, l'octave, l'accent, etc. 
