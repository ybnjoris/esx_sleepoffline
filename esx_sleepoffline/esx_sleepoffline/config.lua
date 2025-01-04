Config = {}

Config.Debug = false -- Activer/désactiver les messages de débogage
Config.Locale = 'en' -- (fr/en)

-- Paramètres Ped
Config.PedTimeout = 15 -- Temps en minutes après lequel un Ped endormi est retiré
Config.PedCheckInterval = 1 -- Intervalle en minutes pendant lequel les anciens peds sont fouillés
Config.PedOffset = -1.0 -- Décalage Z pour la position Ped (hauteur au-dessus du sol)

-- Paramètres de texte
Config.TextSettings = {
    Font = 4, -- ID de police pour le texte 3D
    Scale = 0.55, -- Mise à l'échelle de base du texte 3D
    Color = {r = 255, g = 255, b = 255, a = 255}, -- Couleur du texte (RVB + alpha)
    DrawDistance = 15.0, -- Distance maximale à partir de laquelle le texte est affiché
}

-- Paramètres d'animation
Config.Animation = {
    Dict = "timetable@tracy@sleep@", -- Paramètres d'animation
    Name = "idle_c", -- Nom de l'animation
    Flag = 1, -- Drapeau d'animation
    BlendIn = 8.0, -- Vitesse de transition vers l'animation
    BlendOut = -8.0, -- Vitesse de transition de l'animation
}

-- Paramètres d'affichage du nom
Config.NameDisplay = {
    Enabled = true, -- Activer/désactiver l'affichage du nom
    MaskLastname = true, -- Masquez les noms de famille (par exemple « John Doe » devient «John Do*»)
    MaskLength = 2, -- Nombre de lettres visibles dans le nom de famille masqué
    Format = "~y~Le joueur dort\n~w~Name: %s" -- Format d'affichage du nom (%s sera remplacé par le nom)
}

-- Paramètres MySQL
Config.MySQL = {
    Tables = {
        Users = "users", -- Nom de la table des utilisateurs
        Fields = {
            Identifier = "identifier", -- Nom de la colonne pour l'ID du joueur
            Skin = "skin", -- Nom de la colonne pour les données de l'habillage
            Firstname = "firstname", -- Nom de la colonne pour le prénom
            Lastname = "lastname" -- Nom de colonne pour le nom de famille
        }
    }
}

-- Autorisations
Config.Permissions = {
    FakeCommand = "admin",
    FakeCommandName = "fakesleep"
}

-- Langues
Config.Locales = {
    ['fr'] = {
        ['sleeping'] = 'Le joueur dort',
        ['name'] = 'Name: %s',
        ['unknown'] = 'Inconnu'
    },
    ['en'] = {
        ['sleeping'] = 'Player Sleeping',
        ['name'] = 'Name: %s',
        ['unknown'] = 'Unknown'
    }
}
