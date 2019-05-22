# Utiliser l'application web de live.csound.com 

## Introduction

[https://live.csound.com](https://live.csound.com) est une application web pour
coder en direct avec Csound. Cette application utilise la version WebAssembly de
Csound et attend seulement que l'utilisateur ouvre le site Web dans un navigateur capable de
prendre en charge Javascript, WebAudio et WebAssembly. Les navigateurs Chrome, Safari, Firefox et Edge sur les
systèmes de bureau (Windows 10, Linux, OSX, par exemple), Chrome, Safari et Firefox
sur les appareils mobiles (c'est-à-dire Android et iOS) sont capables de satisfaire à ces exigeances.

Lors du chargement de l’application Web, Csound se lance et évalue la
[livecode.orc] (../ livecode.orc) et démarre le framework (c'est-à-dire,
allume l'horloge globale). Le site est prêt à l'emploi et l'utilisateur peut sélectionner et
évaluer du code.  

## Ajouter à l'écran d'accueil

live.csound.com est une application Web progressive
(PWA)] (https://developers.google.com/web/progressive-web-apps/). Les PWA peuvent être
chargées normalement dans un navigateur Web, mais elles peuvent également être installées sur votre bureau ou sur l'écran d'accueil de l'appareil mobile. Une fois installé, l’application live.csound.com peut
être exécutée comme s'il s'agissait d'une application standard et ceci même lorsqu'elle est hors ligne.
Cela peut s'avérer utile pour tester de courtes idées lors de vos déplacements et dans des zones
où il n'y a pas de connectivité Internet. 

Les navigateurs prenant en charge les PWA disposent généralement d'une option de menu qui propose : "Ajouter à l'écran d'accueil" ou "Créer un raccourci ...". Si vous ne trouvez pas l’option de menu permettant d’installer l’application, veuillez consulter la documentation pour votre navigateur pour plus d'informations. 


## L'interface utilisateur

L'application live.csound.com comporte les éléments d'interface suivants:

* Un bouton pause / lecture qui permet de suspendre et de reprendre le moteur WebAudio de la page.
* Un bouton de redémarrage qui réinitialise et redémarre Csound, en rechargeant livecode.orc.
* Un bouton "Evaluer maintenant" qui évalue le code immédiatement.
* Un bouton "Evaluer à la mesure" qui évalue le code à la mesure 4/4 suivante.
* Un bouton d’aide qui renvoie à cette documentation.
* L'éditeur de code principal pour le codage en direct utilisant le langage Csound Orchestra.

Les utilisateurs interagiront principalement avec l'application en écrivant et en évaluant
le code Csound qu'ils auront écrit dans l'interface. Des raccourcis clavier permettent de déclencher immédiatement l'évaluation du code ou à la mesure suivante, ainsi que pour l'insertion de code de modèle. 

## Evaluer le code

L'éditeur utilise un ensemble intelligent de règles pour l'évaluation du code. Lorsque l'utilisateur appuie sur
un raccourci d'évaluation:

1. Si un code est explicitement sélectionné, le code sélectionné est évalué.
2. Si aucun code n'est sélectionné, l'éditeur vérifie si le curseur est actuellement
    dans un instrument ou un code d'opération et, le cas échéant, évalue l'ensemble définit par ce code.
3. Sinon, l'éditeur évalue uniquement la ligne de texte sur laquelle se trouve le curseur.

Lorsque le code est évalué, l'éditeur fait clignoter visuellement le texte sélectionné indiquant ainsi que la partie clignotante a été évalée.


## Raccourcis clavier

_Les raccourcis suivants fonctionnent avec OSX cmd- key ou ctrl-._

|Raccourci | Description |
| ------- | ------------|
| ctrl-e  | évalue immédiatement l'ensemble du code |
| ctrl-enter  | évalue immédiatement le code sélectionné |
| ctrl-shift-enter  | évalue le code toutes les 4 mesures |
| ctrl-h  | insère un modèle du code hexplay() |
| ctrl-j  | insère un modèle du code euclidplay() |
| ctrl-;  | démarre une ligne de commentaire|
