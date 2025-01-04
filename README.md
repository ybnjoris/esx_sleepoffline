# esx_sleepoffline

Script ESX qui crée des peds endormis pour les joueurs hors ligne

## Caractéristiques 

- Création automatique de peds endormis lorsque les joueurs se déconnectent
- Synchronisation complète des tenues des joueurs (y compris vêtements, accessoires, masques)
- Retrait automatique des peds après un temps configurable
- Affichage de texte 3D configurable au-dessus du lecteur en veille
- Masquage des noms de famille pour plus d'intimité - Multilingue (allemand/anglais)
- Nombreuses options de configuration
- Performances optimisées grâce à une gestion intelligente des ressources
- Mode débogage pour un dépannage facile
- Commande de test admin pour les tests manuels

## Dépendances 

- es_extended
- oxmysql

## L'installation 

1. Téléchargez la ressource dans le dossier Ressources de votre serveur
2. Ajoutez la ligne suivante à votre fichier server.cfg :
```cfg
 ensure esx_sleepoffline
```
3. Adaptez la configuration de config.lua à vos besoins
4. Redémarrez votre serveur

## Configuration 

Le config.lua offre de nombreuses possibilités de paramétrage :

### Paramètres de base 
```Lua 
Config.Debug = false -- activer/désactiver les messages de débogage 
Config.Locale = 'fr' -- Langue (fr/en) 
```

### Paramètres Ped
```Lua
Config.PedTimeout = 15 -- Temps en minutes pour supprimer
Config.PedCheckInterval = 1 -- Intervalle de vérification en minutes
Config.PedOffset = -1.0 -- Décalage Z pour la position
```

### Paramètres de texte 
```Lua 
Config.TextSettings = { font = 4, 
      Scale = 0,35, 
      Color = {r = 255, g = 255, b = 255, a = 255}, 
      DrawDistance = 15,0 
}
```
### Affichage du nom 
```Lua 
Config.NameDisplay = { 
      Enabled = true, 
      MaskLastname = true, 
      MaskLength = 3, 
      Format = « ~y~Le joueur dort\n~w~Nom : %s » }
```

## Commandes d'administration 
- '/fakesleep' - Crée un faux ped à votre emplacement (Nécessite des droits d'administrateur)
  
