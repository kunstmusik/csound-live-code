# Références de Live Code pour Csound

## Opcodes

**set\_tempo**(itempo)

Règle le tempo sur une valeur `itempo` en beats par minute. 

---

ival = **get\_tempo**()

Retourne le tempo en beats par minute. 

---

**go\_tempo**(inewtempo, incr)

Ajuste le tempo de inewtempo incrémentation positive. 

---

ival = **now**()

Retourne la nouvelle valeur de tempo
(Code utilisé depuis le LivecodeLib.csd de Thorin Kerr's) 

---

ival = **now\_tick**()

Retourne la valeur du tick d'horloge au moment de l'intialisation 

---

ival = **beats**(inumbeats)

Retourne la durée en nombre de beats (noires) 

---

ival = **measures**(inummeasures)

Retourne la durée en nombre de mesures (4 noires)

---

ival = **ticks**(inumbeats)

Retourne la durée en nombre de ticks (doubles croches) 

---

ival = **next\_beat**(ibeatcount)

Retourne le temps à partir de maintenant pour le temps suivant, en arrondissant l'alignement
sur la limite du beat.
(Code utilisé depuis le LivecodeLib.csd de Thorin Kerr's)

---

ival = **next\_measure**()

Retourne le temps de maintenant à la mesure suivante, arrondit à la limite de la mesure. 

---

**reset\_clock**()

Réinitialiser l'horloge pour que le prochain tick commence à 0.

---

**adjust\_clock**(iadjust)

Ajuste l'horloge d'un nombre iadjust de beats.
La valeur doit être positive ou négative. 

---

ival = **choose**(iamount)

Avec une valeur aléatoire comprise entre 0 et 1, calcule une valeur aléatoire et
renvoie 1 si la valeur est inférieure à la valeur du hasard. Par exemple, donnant une valeur de 0,7,
il peut indiquer "70% du temps, renvoyer 1; sinon 0"

---

ival = **cycle**(indx, kvals[])

Parcourt karray en utilisant l’index. 

---

ival = **contains**(ival, iarr[])

Vérifie si l'élément existe dans le tableau. Retourne 1 si
vrai et 0 si faux. 

---

ival = **contains**(ival, karr[])

Vérifie si l'élément existe dans le tableau. Retourne 1 si
vrai et 0 si faux. 

---

k[]val = **remove**(ival, karr[])

Créer un nouveau tableau en supprimant toutes les occurrences d’un
numéro donné à partir d'un tableau existant.

---

ival = **rand**(kvals[])

Retourne une donnée aléatoire depuis karray. 

---

Sval = **rand**(Svals[])

Retourne une donnée aléatoire depuis un tableau String. 

---

kval = **randk**(kvals[])

Retourne une valeur aléatoire depuis karray. 

---

Sval = **randk**(Svals[])

Retourne une valeur aléatoire depuis karray. 

---

**cause**(Sinstr, istart, idur, ifreq, iamp)

Opcode wrapper qui appelle la planification uniquement si iamp> 0. 

---

ival = **hexbeat**(Spat, itick)

Étant donné un modèle de chaîne de temps hexadécimal et facultatif
itick (par défaut, current\_tick()), renvoie la valeur 1 si
le tick donnée correspond à un hit dans le temps hexadécimal, ou
renvoie 0 sinon.

---

**hexplay**(Spat, itick, Sinstr, idur, ifreq, iamp)

Pour un pattern de hex beat, utilise le itick pour un instrument, une durée, une fréquence et
amplitude

---

**hexplay**(Spat, Sinstr, idur, ifreq, iamp)

Pour un pattern de hex beat, utilise l'horloge globale pour un instrument, une durée, une fréquence et
amplitude

---

ival = **octalbeat**(Spat, itick)

Pour un patterne en octal beat et un itick optionnel (par défaut, current\_tick()), renvoie la valeur 1 si
le tick donnée correspond à un hit dans le temps octal, ou
renvoie 0 sinon.

---

**octalplay**(Spat, ibeat, Sinstr, idur, ifreq, iamp)



---

**octalplay**(Spat, Sinstr, idur, ifreq, iamp)



---

ival = **phs**(icount, iperiod)

Pour un compte et une période donné, retourne une valeur dans la plage [0-1)

---

ival = **phs**(iticks)

Pour une période en ticks, retourne la phase de l'horloge dans la plage [0-1) 

---

ival = **phsb**(ibeats)

Pour une période donnée en beats, retourne la phase de l'horloge pour la plage [0-1) 

---

ival = **phsm**(imeasures)

Pour une période donnée en mesures, retourne la phase de l'horloge pour la plage [0-1)

---

Sval = **euclid\_str**(ihits, isteps)



---

ival = **euclid**(ihits, isteps, itick)

Pour un nombre ihits pour la période isteps et un itick optionnel (par défaut, current\_tick()), renvoie la valeur 1 si
le tick donnée correspond à un hit du rythme euclidien, ou
renvoie 0 sinon.

---

**euclidplay**(ihits, isteps, itick, Sinstr, idur, ifreq, iamp)



---

**euclidplay**(ihits, isteps, Sinstr, idur, ifreq, iamp)



---

ival = **xcos**(iphase)

Retourne le cosinus de la phase (0-1.0) 

---

ival = **xcos**(iphase, ioffset, irange)

Range version of xcos, similar à Impromptu's cosr 

---

ival = **xsin**(iphase)

Retourne la sinusoïde de la phase (0-1.0) 

---

ival = **xsin**(iphase, ioffset, irange)

Range version of xsin, similar to Impromptu's sinr 

---

ival = **xosc**(iphase, kvals[])

Non-interpolating oscillateur. Donne une phase dans un intervale 0-1,
retourne une valeur comprise dans la table k-array donnée. 

---

ival = **xosci**(iphase, kvals[])

Linearly-interpolating oscillateur. Donne une phase dans un intervale 0-1,
retourne une valeur d'interpolation entre deux points de phase compris dans la table k-array donnée. 

---

ival = **xoscb**(ibeats, kvals[])

Non-interpolating oscillateur. Pour une phase donnée en beats, retourne une valeur comprise dans une tabel k-array. (raccourcis pour xosc(phsb(ibeats), karr) )

---

ival = **xoscm**(ibeats, kvals[])

Non-interpolating oscillateur. Pour une phase donnée en mesures, retourne une valeur comprise dans une table k-array. (raccourcis pour xosc(phsm(ibeats), karr) )

---

ival = **xosci**(iphase, kvals[])

Linearly-interpolating oscillateur. Pour une phase dans une plage de 0-1,
retourne une valeur interpolée entre deux points dasn un table k-array
table. 

---

ival = **xoscib**(ibeats, kvals[])

Linearly-interpolating oscillator. Given phase duration in beats,
returns value intepolated within the two closest points of phase within k-array
table. (shorthand for xosci(phsb(ibeats), karr) )

---

ival = **xoscim**(ibeats, kvals[])

Linearly-interpolating oscillateur. Pour une phase donnée en mesures, retourne une valeur interpolée entre deux points dans une phase comprise dans une table k-array. (raccourcis pour xosci(phsm(ibeats), karr) )

---

ival = **xlin**(iphase, istart, iend)

Line (Ramp) oscillateur.  Donne une phase dans un intervale 0-1, retourne la valeur d'interpolation comprise entre istart et iend. 

---

ival = **dur\_seq**(itick, kdurs[])

Étant donné une valeur de tick et un tableau de durées, retourne une nouvelle durée ou 0 selon que tick correspond à une nouvelle valeur de durée. Les valeurs
peuvent être positives ou négatives différentes de zéro. Les valeurs négatives peuvent être interprétées comme des durées de repos.

---

ival = **dur\_seq**(kdurs[])

Compte tenu d'un tableau de durées, renvoie la nouvelle durée ou 0 selon que le tick d'horloge actuel atteint ou non une nouvelle valeur de durée. Les valeurs
peuvent être positives ou négatives différentes de zéro. Les valeurs négatives peuvent être interprétées comme des durées de repos.

---

Sval = **rotate**(Sval, irot)

rotate - Rotation de la phrase autour d'un nombre irot de valeurs.
(Inspiré du rotate de Charlie Roberts' Gibber.)


---

Sval = **strrep**(Sval, inum)

Répète une chaîne String donnée x nombre de fois. Par exemple, `Sval = strrep (" ab6a ", 2)` produira la valeur de "ab6aab6a". Utile pour travailler avec les chaînes en Hex Beat.

---

ival = **xchan**(SchanName, initVal)

xchan
Initialise un canal avec une valeur initiale si le canal a une valeur par défaut de 0 et
renvoie ensuite la valeur actuelle du canal. Utile dans le codage en direct pour définir
un point dynamique qui sera automatisé ou défini en dehors de l'instrument qui utilise le canal.

L'opcode est oversloadé pour renvoyer la valeur i ou k. Assurez-vous d'utiliser xchan:i ou xchan:k
pour spécifier quelle valeur utiliser.

---

kval = **xchan**(SchanName, initVal)

xchan
Initialise un canal avec une valeur initiale si le canal a une valeur par défaut de 0 et
renvoie ensuite la valeur actuelle du canal. Utile dans le codage en direct pour définir
un point dynamique qui sera automatisé ou défini en dehors de l'instrument qui utilise le canal.

L'opcode est oversloadé pour renvoyer la valeur i ou k. Assurez-vous d'utiliser xchan:i ou xchan:k
pour spécifier quelle valeur utiliser.


---

**set\_root**(iscale_root)

Set root note of scale in MIDI note number. 

---

ival = **from\_root**(ioct, ipc)

Calculate frequency from root note of scale, using
octave and pitch class. 

---

**set\_scale**(Scale)

Définit la fondamentale de la gamme.  Supporte "maj" et "min" pour majeure ou mineure. 

---

ival = **in\_scale**(ioct, idegree)

Calcule la fréquence de la note fondament de la gamme, utilise les octaves ou les degrés. 

---

kval = **in\_scale**(koct, kdegree)

Calcule la fréquence depuis la note fondamentale de la gamme, utilise les octaves et les degrés (version k-rate de l'opcode) 

---

ival = **pc\_quantize**(ipitch_in, iscale[])

Quantifie le numéro de note MIDI donné pour la gamme donnée
(Base sur pc: quantize from Extempore)

---

ival = **pc\_quantize**(ipitch_in)

Quantifie le numéro de note MIDI donné pour la gamme active
(Base sur pc: quantize from Extempore)

---

**set\_chord**(ichord_root, ichord_intervals[])



---

**set\_chord**(Schord)



---

ival = **in\_chord**(ioct, idegree)



---

aval = **declick**(ain)

Opcode utilisé pour "décliquer" un signal audio. Ne doit être utilisé que dans des instruments ayant une durée positive de p3.

---

kval = **oscil**(kfreq, kin[])

Oscillateur personnalisé non-interpolant prenant kfrequency et un tableau à utiliser comme table d'oscillateur. Émet un signal de taux-k. 

---

**kill**(Sinstr)

Désactive les instances d’instruments en cours. Utile en livecoding
sur le traitement des signaux audio et de contrôle des instruments. Peut ne pas être efficace pour les
instruments en récursion temporelle, car ils peuvent ne pas fonctionner mais être programmés dans le
système d'événements. Dans ce cas, essayez d’utiliser clear\ _instr pour écraser la
définition de l'instrument.

---

**clear\_instr**(Sinstr)

Redéfinit l'instr dans un éditeur vierge. Utile pour tuer les
fonctions de récursion temporelle ou de rappel d'horloge. 

---

**start**(Sinstr)

Commence à exécuter un instrument nommé pour une durée indéterminée en utilisant p2 = 0 et p3 = -1.
Commencez par désactiver toutes les occurrences de l'instrument nommé existant. Utile
lors du codage en direct des signaux audio toujours actifs et des instruments de traitement de signal de commande.

---

**stop**(Sinstr)

Stop un instrument en cours d'execution, permet de libérer des segments pour fonctionner. 

---

**eval\_at\_time**(Scode, istart)

Evalue le code à un temps donné 

---

**set\_fade\_range**(irange)

Définit une plage de fading en db. Par défaut, la plage est -30 (i.e., de -30dbfs à 0dbfs) 

---

ival = **fade\_in**(ident, inumticks)

Pour un canal identifié (nombre) donne un nombre de ticks de fading dans le temps, le fading progresse sur ce canal vers 0dbfs (1.0) en utilisant la plage de fading définie globalement. (Par défaut, le fading démarre à -30dBfs et s’arrête à 0dbfs.)

---

ival = **fade\_out**(ident, inumticks)

Pour un canal identifié (nombre) et un nombre de ticks donnés pour le fading de sortie, progresse de la valeur actuelle vers 0 suivant la définition globale du fading. (Par défaut le fading commence à 0dBfs et s'arrête à -30dbfs.) 

---

ival = **fade\_read**(ident)

Lit la valeur de fading du canale. Utilisé en cas de copié/collé pour contrôler les valeurs. 

---

**set\_fade**(ident, ival)

 Définit les valeurs de fading du canal. Valeurs comprises entre 0-1.0.  (Généralement définies par 0 ou 1) 

---

**sbus\_write**(ibus, al, ar)

Écrire deux signaux audio sur le bus stéréo à un index donné 

---

**sbus\_mix**(ibus, al, ar)

Mixer deux signaux audio dans un bus stéréo à un index donné

---

**sbus\_clear**(ibus)

Effacer les signaux audio du canal de bus 

---

aaval = **sbus\_read**(ibus)

Lire les signaux depuis le canal de bus 

---

**pan\_verb\_mix**(asig, kpan, krvb)

Opcode pour régler le signal panoramique, envoie les valeurs au mixeur et envoie en amont le signal à réverbérer. Si ReverbMixer n’est pas activé, la sortie ne se fera que sur le signal panoramique utilisant l'opcode.

---

aval = **saturate**(asig, ksat)

Saturation avec tanh 

---

## Instruments

|Instrument Name | Description |
| ---- | ---- | 
|  ReverbMixer | Mixer Always-on avec une Reverb au canal. Utiliser start("ReverbMixer") pour l'activation. Utilisé avec pan\_verb\_mix to simplify signal-based live coding.  | 
|  FBReverbMixer | Mixer Always-on avec une Reverb et un delay en feedback. Utiliser start("FBReverbMixer") pour l'activation. utilisé avec pan\_verb\_mix to simplify signal-based live coding.  | 
|  Sub1 | Substractive Synth, 3osc  | 
|  Sub2 | Subtractive Synth, two saws, fifth freq apart  | 
|  Sub3 | Subtractive Synth, three detuned saws, swells in  | 
|  Sub4 | Subtractive Synth, detuned square/saw, stabby. Nice as a lead in octave 2, nicely grungy in octave -2, -1  | 
|  Sub5 | Subtractive Synth, detuned square/triangle  | 
|  Sub6 | Subtractive Synth, saw, K35 filters  | 
|  Sub7 | Subtractive Synth, saw + tri, K35 filters  | 
|  SynBrass | SynthBrass subtractive synth  | 
|  SSaw | SuperSaw sound using 9 bandlimited saws (3 sets of detuned saws at octaves) | 
|  Mode1 | Modal Synthesis Instrument: Percussive/organ-y sound  | 
|  Plk | Pluck sound using impulses, noise, and waveguides | 
|  Organ2 | Organ sound based on M1 Organ 2 patch  | 
|  Bass | 303-style Bass sound  | 
|  ms20_bass | MS20-style Bass Sound  | 
|  VoxHumana | VoxHumana Patch  | 
|  FM1 | FM 3:1 C:M ratio, 2->0.025 index, nice for bass  | 
|  Noi | Filtered noise, exponential envelope  | 
|  Wobble | Wobble patched based on Jacob Joaquin's "Tempo-Synced Wobble Bass"  | 
|  Sine | Simple Sinewave instrument with exponential envelope  | 
|  Mono | Monophone synth using sawtooth wave and 4pole lpf. Use "start("Mono") to run the monosynth, then use MonoNote instrument to play the instrument.  | 
|  MonoNote | Note playing instrument for Mono synth. Be careful to use this and not try to create multiple Mono instruments!  | 
|  Clap | Modified clap instrument by Istvan Varga (clap1.orc)  | 
|  BD   | Bass Drum - From Iain McCurdy's TR-808.csd  | 
|  SD   | Snare Drum - From Iain McCurdy's TR-808.csd  | 
|  OHH  | Open High Hat - From Iain McCurdy's TR-808.csd  | 
|  CHH  | Closed High Hat - From Iain McCurdy's TR-808.csd  | 
|  HiTom  | High Tom - From Iain McCurdy's TR-808.csd  | 
|  MidTom  | Mid Tom - From Iain McCurdy's TR-808.csd  | 
|  LowTom   | Low Tom - From Iain McCurdy's TR-808.csd  | 
|  Cymbal   | Cymbal - From Iain McCurdy's TR-808.csd  | 
|  Rimshot  | Rimshot - From Iain McCurdy's TR-808.csd  | 
|  Claves | Claves - From Iain McCurdy's TR-808.csd  | 
|  Cowbell | Cowbell - From Iain McCurdy's TR-808.csd  | 
|  Maraca   | Maraca - from Iain McCurdy's TR-808.csd  | 
|  HiConga  | High Conga - From Iain McCurdy's TR-808.csd  | 
|  MidConga   | Mid Conga - From Iain McCurdy's TR-808.csd  | 
|  LowConga   | Low Conga - From Iain McCurdy's TR-808.csd  | 
