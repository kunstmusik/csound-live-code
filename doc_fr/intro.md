# csound-live-code 

Auteur: Steven Yi\<stevenyi@gmail.com\>
Traducteur: Argenty Jean\<jean.argenty@gmail.com\>

## Introduction 

* csound-live-code * est une bibliothèque, un framework et une application Web permettant le Live Coding et de créer de la musique avec Csound. Le noyau est une bibliothèque, [livecode.orc] (../ livecode.orc), qui contient un certain nombre d'opcode (code d'opération) et d'instruments définis par l'utilisateur. Ces opcodes et instruments fournissent une base pour le codage en direct de la musique avec Csound et fournissent des abstractions comme un métronome, le tempo, des unités de durée (c.-à-d. Ticks, beats, mesures), des échelles et des outils de création de motifs. Les parties travaillent toutes ensemble pour former un cadre de codage en direct avec des instruments de rappel ou de récursion temporelle. Cette bibliothèque est utilisée avec les distributions de Csound pour ordinateurs individuels et est également utilisée dans le cadre de l’application Web [http://live.csound.com] (http://live.csound.com).

## Documentation

__Pour commencer__

* [Utilisation de l'application internet live.csound.com](webinterface.md)

__Concepts__

* Concepts du Live Coding 
* [Session Lifecycle](session_lifecycle.md)
* [Introduction rapide à Csound](csound_bases.md)
* [Horloge, Tempo, et unités de temps](time.md)
* Utiliser des User-defined Opcodes (UDO)
* Synthesizer Instruments

* Temporal Recursion
* Callback Instrument

* [Event Time Oscillators](oscillators.md)
* [Hexadecimal Beats](hexadecimal_beats.md)

__Tutoriels__

* [Tutoriel 1: Faisons un son!](tutoriel1.md)
* [Tutoriel 2: Faisons notre propre son!](tutoriel2.md)
* [Tutoriel 3: Performing with a Feedback Delay](tutoriel3.md)
* [Tutoriel 4: Making Music in a Modular Style](tutoriel4.md)

<!-- 
* [Events 1: Simple Events](tutorial2.md)
* [Events 2: Compound Events](tutorial3.md)
* [Events 3: Generating Notes with Loops](tutorial4.md)
* [Realtime Process Score Generation](tutorial5.md)
* [Temporal Recursion](tutorial6.md)
* [Callback Instrument](tutorial7.md)
* [Hex Beats](tutorial8.md)
* [Hex Melodic Lines](tutorial9.md)
-->

__Reference__

* [Cheatsheet](cheatsheet.md)
* [Reference](reference.md)



