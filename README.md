# Template manuscrit pour HDR

Utiliser le Makefile principal pour voir les options de compilation du manuscrit.

Essentiellement : `make hdr`, `make hdr-full-silent`, `make quick`. Puis `make hdr-cv.pdf` et `make final`.
Puis `make clean` si besoin. Attention, dans certains cas, le pdf résultant reste dans `auxiliary`.

Chaque chapitre peut être compilé individuellement dans le dossier `Chapters`. Exemple : `make part1-conclusion.pdf`. (le pdf résultant sera dans `auxiliary`)
