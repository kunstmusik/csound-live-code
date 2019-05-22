# Horloge, Tempo, and les valeurs liées au temps

Csound prend en charge les tempos et les valeurs temporelles sous forme de beats (temps de la mesure), mais uniquement pour sa langue de partition et son système de partition. Au moment de l'exécution, tous les événements générés via le langage orchestra utilisent des valeurs de temps en secondes, pas des beats. Cette conception a évolué à partir depuis les origines non temps réel de Csound aux racines MUSIC-N et de la performance en multiple-pass. Cependant, Csound est fourni avec tous les outils nécessaires à la création d’un système central de métronome, de tempo et de valeurs temporelles. livecode.orc fournit des outils prédéfinis liés au temps que vous pourrez utiliser dans vos projets.

## L'horloge

livecode.orc fournit un instrument d'horloge centrale qui gère l'heure en fonction d'un tempo défini par l'utilisateur (par défaut, le tempo est de 120). Dès que livecode.orc est évalué (par exemple, dans le cas d'un #include dans un projet CSD; elle est automatiquement exécutée pour l’utilisateur lors de l’utilisation de live.csound.com), l’horloge s’exécute.

L'horloge effectue les opérations suivantes:

1. Met à jour une variable globale k-rate gk\_now avec l’heure actuelle en beats par bloc de traitement.
2. Vérifie si un nouveau compte d'horloge a lieu. L'horloge livecode.orc utilise les 16e de notes comme valeur d'horloge principale.
3. Si un nouveau tick d'horloge est prêt, mise à jour de la variable gk\_clock\_tick et déclenchement d'un événement sur l'instrument `Perform`. L’instrument Perform déclenche à son tour un instrument `P1` que les utilisateurs peuvent éditer comme instrument de rappel pour l’horloge. (L'instrument intermédiaire Perform est là pour permettre aux utilisateurs de redéfinir et d'ajouter des fonctionnalités de traitement supplémentaires. Voir [livecode-beatviz.csd] (../ livecode-beatviz.csd) pour un exemple.)

Voici les opcodes fournis pour interagir avec l'horloge:

* reset\_clock() - Réinitialise l'heure de l'horloge à 0
* adjust\_clock(iadjust) - Ajuste l’heure de l’horloge en donnant une valeur donnée. Utile pour la synchronisation manuelle de l'horloge avec un autre artiste.

## Tempo

L'horloge centrale utilise une valeur de tempo globale stockée dans la variable `gk_tempo`. Les utilisateurs peuvent utiliser les opcodes suivants pour travailler avec le tempo:

1. set\_tempo(itempo) - définit le tempo de l'horloge globale en beats par minute.
2. get\_tempo() - récupère le tempo actuel de l’horloge globale au moment de l’initialisation.
3. go\_tempo(itarget\ _tempo, itempo\_adjust) - mise à jour du tempo, en vous dirigeant vers le tempo cible en fonction du montant de l'ajustement. Utile pour se déplacer dans le temps.

## Valeurs de temps

La bibliothèque fournit les opcaodes suivants pour le calcul des valeurs de durée en fonction du tempo actuel. L'utilisateur peut utiliser lui-même ces opcodes et le système de tempo sans utiliser le système d'instrument de rappel. Ces opcodes peuvent également être utilisés avec des valeurs non entières (par exemple, le temps (0,5) renvoie la durée d'un demi-temps ou d'un huitième de note).

1. now() - renvoie la valeur actuelle de gk\_now beat time à l'heure d'initialisation.
2. now\_tick() - retourne la valeur actuelle du tick d'horloge au moment de l'initialisation.
3. ticks(inumticks) - calcule et renvoie la durée dans le nombre de ticks donné (16e de notes).
4. beats(inumbeats) - calcule et renvoie la durée dans le nombre de beats donné (noires).
5. measures(inummeasures) - calcule et renvoie la durée dans le nombre donné de mesures en 4/4.

## Les fonctions de temps pour le Scheduling

Csound étant un système de traitement basé sur des blocs, les événements peuvent se déclencher lorsque leurs heures de début se produisent n'importe où dans la durée du bloc. Pour tenir compte de cela lors de la planification d'une note suivante (comme lors de l'utilisation d'une récursion temporelle), les fonctions suivantes doivent être utilisées pour calculer des heures de début alignées sur l'horloge.

1. next\_beat(ibeatcount) - calcule et renvoie l'heure en beats à partir de maintenant, en l'alignant sur la limite de battement. ibeat count est facultatif et la valeur par défaut est 1.
2. next\_measure() - calcule et renvoie l'heure de la prochaine mesure, en l'alignant sur la limite de battement.
