# Modélisation et commande d’un convertisseur Boost sous MATLAB/Simulink

Ce dépôt contient un projet complet de **modélisation** et de **commande non linéaire** d’un convertisseur DC-DC **Boost** sous MATLAB/Simulink, avec rapport et figures de résultats.

---

## 1. Contenu du dépôt

```text
.
├── code/
│   ├── [fichier_modélisation_boost].slx     # Modèle Simulink du convertisseur Boost
│   ├── [fichier_commande_boost].slx         # Schéma Simulink avec les lois de commande
│   └── fonction.m                           # Copie de la fonction utilisée dans le bloc MATLAB Function
│
├── documentation/
│   └── rapport_projet_boost.pdf             # Rapport de projet (modélisation + commande + résultats)
│
└── results/
    ├── figure_reponse_tension.png           # Exemple de figure de réponse de la tension de sortie
    ├── figure_courant_inductance.png        # Exemple de figure de courant dans l’inductance
    └── ...                                  # Autres figures de simulation

