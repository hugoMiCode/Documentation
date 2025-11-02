# Système de Positionnement UWB pour Voitures RC

<!-- <div style="text-align: center;">
  <img src="assets/logo.png" alt="Logo UWB RC System" width="200"/>
</div> -->

!!! info "Version Actuelle"
    **Version** : 1.0.0  
    **Dernière mise à jour** : {{ git_revision_date_localized }}  
    **Statut** : 🟡 En développement actif

---

## 🎯 Bienvenue

Bienvenue dans la documentation du **Système de Positionnement UWB pour Voitures RC** ! 

Ce projet open-source permet de créer un système complet de chronométrage et de positionnement en temps réel pour des courses de voitures RC utilisant la technologie **Ultra-Wideband (UWB)** avec les modules **DW3000**.

---

## 🚀 Démarrage Rapide

=== "Utilisateur"
    Vous voulez juste utiliser le système ?
    
    1. 📥 [Installation du système](user-guide/installation.md)
    2. ⚙️ [Configuration initiale](user-guide/initial-setup.md)
    3. 🎮 [Utilisation quotidienne](user-guide/daily-usage.md)

=== "Développeur"
    Vous voulez contribuer ou modifier le code ?
    
    1. 💻 [Environnement de développement](dev-guide/environment.md)
    2. 🔨 [Build et flash](dev-guide/build-flash.md)
    3. 🐛 [Debugging](dev-guide/debugging.md)

=== "Chef de Projet"
    Vous gérez le projet ?
    
    1. 📋 [Vision et objectifs](project/vision.md)
    2. 🗓️ [Planification](project/planning.md)
    3. 🛣️ [Roadmap](project/roadmap.md)

---

```puml
@startuml
' !theme plain
left to right direction

package "Système UWB RC" {
    component "Tags UWB\n(Voitures RC)\n• Positionnement temps réel\n• Réception IR\n• Transmission WiFi" as Tags
    component "Anchors UWB\n(Points fixes)\n• Mesure de distances\n• Auto-calibration\n• Maillage réseau" as Anchors
    component "Station de Base\n(Hub central)\n• Interface web\n• Enregistrement SD\n• Télécommande" as Station
    component "Application Desktop\n(Analyse)\n• Import données SD\n• Traitement avancé\n• Stockage cloud" as App
}

Tags --> Anchors : UWB\nDistances
Anchors --> Station : Données\nCalibration
Tags --> Station : WiFi\nPositions & IR
Station --> App : Export SD / API
App --> Station : Configuration / Restauration

note left of Tags
    Modules mobiles embarqués
end note

note right of Anchors
    Référence pour le positionnement
end note

note right of Station
    Collecte et contrôle centralisé
end note

@enduml
```

---

## 📊 Diagramme d'Architecture Globale

```puml
@startuml

' Définir les composants
package "Circuit RC" {
  [Anchor 1] as A1 
  [Anchor 2] as A2
  [Anchor 3] as A3
  [Anchor N] as AN
  [Tag 1] as T1
  [Tag 2] as T2
  [Tag N] as TN
  [Station de Base] as BS
}

@enduml
```

---

## 🎬 Comment ça Fonctionne ?

### 1. Positionnement UWB

```puml
@startuml
participant T as "Tag (Voiture RC)"
participant A1 as "Anchor 1"
participant A2 as "Anchor 2"
participant A3 as "Anchor 3"
participant BS as "Station Base"

T -> A1: Poll UWB (broadcast, t=0)
T -> A2: Poll UWB (broadcast, t=0)
T -> A3: Poll UWB (broadcast, t=0)

par Réponses simultanées
    A1 -> T: Distance = 1.23m
    A2 -> T: Distance = 2.45m
    A3 -> T: Distance = 3.67m
end

T -> BS: Envoi distances (lot)
BS -> BS: Calcul position (trilatération)
BS -> BS: Filtrage Kalman
BS -> BS: Stockage données
BS -> BS: Affichage temps réel
@enduml
```

### 2. Chronométrage IR

```puml
@startuml
participant Car as "Voiture"
participant Balise as "Balise IR"
participant Base as "Station Base"

Car -> Balise: Passage devant balise
Balise -> Car: Signal IR
Car -> Car: Décodage Balise
alt Start/Finish
    Car -> Car: Calcul temps tour
else Secteur
    Car -> Car: Calcul temps secteur
end
Car -> Base: Envoi données WiFi
Base -> Base: Traitement & stockage
@enduml
```

### 3. Calibration Auto des Anchors

```puml
@startuml

state Anchor as "Anchor Mode"
state Tag as "Tag Mode"

[*] --> Anchor
Anchor --> Tag : Start calibration
state Tag {
    state "Accumulateting Samples" as Measure_Distances
    state "Sending Results" as ProcessData
    [*] --> Measure_Distances
    Measure_Distances --> Measure_Distances : New Sample
    Measure_Distances --> ProcessData : Enough Samples
    ProcessData --> [*] 
}

Tag --> Anchor : Fin calibration
Anchor --> Anchor : Waiting for next calibration
@enduml
```

---

## 📈 Fonctionnalités Principales

### ✅ Implémenté

- [x] Positionnement UWB temps réel (précision < 30cm)
- [x] Chronométrage IR (précision < 10ms)
- [x] Calibration automatique des anchors
- [x] Transmission des données
- [x] Affichage OLED local
- [x] Gestion multi-tags (jusqu'à 8 voitures)

### 🚧 En Développement

- [ ] Station de base avec stockage SD
- [ ] Application desktop d'analyse
- [ ] Stockage cloud par utilisateur

### 🔮 Futur

- [ ] Support 3D (positionnement en hauteur)
- [ ] Machine learning pour prédiction trajectoire
- [ ] Mode multi-circuits
- [ ] API REST publique
- [ ] Application mobile (Android/iOS)

---

## 🛠️ Technologies Utilisées

### Hardware

| Composant | Modèle | Fonction |
|-----------|--------|----------|
| **Microcontrôleur** | ESP32-DevKit | Processing & WiFi |
| **Module UWB** | DW3000 | Mesure distances |
| **Écran** | SSD1306 OLED 128x64 | Affichage local |
| **Récepteur IR** | TSOP38238 | Chronométrage |
| **Alimentation** | LiPo 3.7V / 5V USB | Power |

### Software

| Technologie | Usage |
|-------------|-------|
| **PlatformIO** | Build system |
| **Arduino Framework** | Firmware base |
| **ArduinoJson** | Parsing messages |
| **Adafruit GFX** | Affichage OLED |
| **WiFi ESP32** | Communication réseau |
| **puml** | Diagrammes UML |
| **MkDocs Material** | Documentation |

---

## 📚 Navigation de la Documentation

<div class="grid" markdown>

!!! abstract "Vue d'ensemble"
    - [Introduction](overview/introduction.md)
    - [Architecture](overview/architecture.md)
    - [Spécifications](overview/specifications.md)
    - [Glossaire](overview/glossary.md)

!!! note "Gestion de Projet"
    - [Vision & Objectifs](project/vision.md)
    - [Planification](project/planning.md)
    - [Roadmap](project/roadmap.md)
    - [User Stories](project/user-stories.md)

!!! example "Composants"
    **Hardware**
    - [Tags](hardware/tag.md)
    - [Anchors](hardware/anchor.md)
    - [Puces IR](hardware/ir-beacons.md)
    - [Station](hardware/base-station.md)
    
    **Software**
    - [Firmware Tag](software/tag/architecture.md)
    - [Firmware Anchor](software/anchor/architecture.md)
    - [Station Base](software/base-station/architecture.md)
    - [App Desktop](software/desktop/architecture.md)

!!! tip "Guides"
    **Utilisateur**
    - [Installation](user-guide/installation.md)
    - [Configuration](user-guide/initial-setup.md)
    - [Utilisation](user-guide/daily-usage.md)
    - [Dépannage](user-guide/troubleshooting.md)
    
    **Développeur**
    - [Environnement](dev-guide/environment.md)
    - [Build & Flash](dev-guide/build-flash.md)
    - [Debugging](dev-guide/debugging.md)
    - [Tests](dev-guide/testing.md)

</div>

---

## 📞 Support & Contact

- 📧 Email : support@uwb-rc.com
- 💬 Discord : [Rejoindre le serveur](https://discord.gg/uwb-rc)
- 🐛 Issues : [GitHub Issues](https://github.com/hugo/UWB-ESP32/issues)
- 📖 Wiki : [GitHub Wiki](https://github.com/hugo/UWB-ESP32/wiki)
