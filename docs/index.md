# Système de Positionnement UWB pour Voitures RC

<!-- <div style="text-align: center;">
  <img src="assets/logo.png" alt="Logo UWB RC System" width="200"/>
</div> -->


## Bienvenue

Bienvenue dans la documentation du **Système de Positionnement UWB pour Voitures RC** ! 

Ce projet open-source permet de créer un système complet de chronométrage et de positionnement en temps réel pour des courses de voitures RC utilisant la technologie **Ultra-Wideband (UWB)** avec les modules **DW3000**.


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
