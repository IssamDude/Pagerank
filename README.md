# Projet_PIM_ADA
Code du projet pim en 1ere année N7. Language: ADA
## Usage de git
### Cloner un dépôt (chez vous ou sur les ordis de l'n7) :
```console
Ayman@LAPTOP:~$ git clone https://github.com/Voyinno/Projet_PIM_ADA.git
```

### Mettre à jour le dépôt:

```git pull```

Synchronise votre dossier sur la derniere version de depo github.

### Faire des ajouts:
Aprés avoir copier ou modifier un fichier ou un dossier dans `Projet_PIM_ADA` pour l'envoyer sur le dépôt il faut:


- Ajouter les modifications (ajout à l'**INDEX**)

```git add <filename>```

ou plus simplement (pour enregistrer toute les modifications)

```git add --all```

- Valider les modifications 

```git commit -a -m "Message de validation"```

- Envoyer les modifications (sur la branche principale)

```git push```

Normalement vous allez devoir donner vos identifiant github pour le push.

Il est impossible de push si vous n'etes pas a jour sur le depo du serveur, si c'est le cas vous aller avoir une erreur.
Il faut alors faire ```git pull``` (il va essayer de fusionner la mise a jour et vos modifications) puis ```git push```.
