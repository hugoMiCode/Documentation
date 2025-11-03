# Système de Positionnement UWB pour Voitures RC

Ce projet implémente un système complet de positionnement en temps réel et de chronométrage pour voitures RC, basé sur la technologie **Ultra-Wideband (UWB)** avec les modules **DW3000**.


## Architecture Système

Le système se compose de trois composants principaux qui travaillent en synergie :

```puml
@startuml
!theme plain
skinparam componentStyle rectangle
skinparam linetype ortho
skinparam padding 8
skinparam backgroundColor transparent

component "Tags UWB (Voitures RC)" as Tags #LightBlue {
    component compTag [
        Module DW3000
        ESP32
        Écran OLED
        Récepteur IR
        WiFi
    ]
}

component "Anchors UWB (Points Fixes)" as Anchors #LightGreen {
    component compAnchor [
        Module DW3000
        ESP32
        Écran OLED
        Émetteur IR
        WiFi
    ]
}

component "Station de Base" as Base #LightPink {
    component compBase [
        Interface User
        Stockage SD
        Gestionnaire WiFi
        Moteur Positionnement
        Interface Config
    ]
}


' Relations principales
' Tags <-> Anchors : UWB\nMesure distances
' Tags -> Base : WiFi\nDonnées temps réel
' Anchors -> Base : WiFi\nCalibration
' Base --> Anchors : Contrôle
' Base --> Tags : Configuration

note bottom of Tags
  • Mesure des distances UWB
  • Détection IR passages
  • Transmission temps réel
  • Affichage local
end note

note bottom of Anchors
  • Point de référence fixe
  • Auto-calibration réseau
  • Balise IR (secteurs)
  • Maillage coordonné
end note

note bottom of Base
  • Calcul positions
  • Interface temps réel
  • Stockage données
  • Télécommande système
end note

@enduml
```

## Tag UWB (Module Mobile)

Le Tag est le dispositif embarqué dans chaque voiture RC. Il assure le positionnement précis grâce aux mesures UWB avec les anchors, gère le chronométrage via la détection IR des passages, transmet les données en temps réel par WiFi et affiche les informations localement sur un écran OLED. Ce module compact intègre plusieurs composants matériels : un module DW3000 pour l'UWB, un ESP32 comme processeur principal avec WiFi intégré, un écran OLED SSD1306 pour l'affichage, un récepteur IR pour le chronométrage, le tout alimenté par une batterie embarquée.

## Anchor UWB (Point Fixe)
Les Anchors sont les points de référence fixes du système. Ils assurent plusieurs fonctionnalités essentielles : la mesure précise des distances avec les tags mobiles via UWB, l'auto-calibration automatique du réseau d'anchors, une communication WiFi bidirectionnelle avec la station de base, l'affichage de leur état sur un écran OLED intégré, et l'émission de signaux IR pour la détection des passages et secteurs. Au niveau matériel, les anchors utilisent les mêmes composants que les tags, à la différence qu'ils sont équipés d'un émetteur IR au lieu d'un récepteur.

## Station de Base

La station de base est le cerveau du système. Elle assure plusieurs fonctionnalités essentielles: le calcul précis des positions par trilatération, le traitement en temps réel des données provenant des tags et anchors, l'enregistrement complet des sessions sur carte SD, la télécommande centralisée de tous les composants du système, ainsi qu'une interface intuitive pour le contrôle et la visualisation.

## Flux de Communication

```puml
@startuml
participant "Tag" as T
participant "Anchors" as A
participant "Station Base" as B

T -> B: Connexion
A -> B: Connexion

group Loop Contrôle Système
    B -> T: Configuration
    B -> A: Configuration
    B -> A: Commande calibration
    activate A
    A -> A: Auto-calibration
    A -> B: Vecteur calibration
    deactivate A
    activate B
    B -> B: Calcul position Anchors
    deactivate B
end

group Loop UWB
    A ->> T: AT+RANGE (range data)
    activate T
    T -> T: Data extraction & buffering
    T -> B: Envoi données (WiFi)
    deactivate T
    activate B
    B -> B: Calcul position
    B -> B: Filtrage
    B -> B: Stockage SD
    deactivate B
end

group Loop IR
    A ->> T: Signal IR (passage)
    activate T
    T -> T: Décodage secteur
    T -> B: Temps secteur
    deactivate T
    activate B
    B -> B: Mise à jour temps
    deactivate B
end
@enduml
```

# Calibration des Anchors

La **calibration des anchors** vise à déterminer les positions relatives des différentes ancres (points fixes) du système, à partir des **distances mutuelles mesurées** par les modules UWB.  
Cette étape permet de construire un **repère cohérent**, dans lequel les positions ultérieures des *tags* pourront être exprimées.


## Digramme d'état 

```plantuml
@startuml
title Diagramme d'état détaillé — Calibrator (version étendue)

[*] --> ANCHOR_MODE
ANCHOR_MODE --> TAG_MODE
TAG_MODE --> ANCHOR_MODE

note right of ANCHOR_MODE
Mode anchor normal : répond aux polls,
reçoit commandes de calibration.
end note

state ANCHOR_MODE {
  [*] --> COLLECTING_TAG_DATA
  COLLECTING_TAG_DATA --> COLLECTING_TAG_DATA : onRangingData() / update_tag_data()
  COLLECTING_TAG_DATA --> [*] : startCalibration()
}

note right of TAG_MODE
Le device est configuré en TAG 
pour mesurer les distances 
avec les autres anchors.
end note

state TAG_MODE {
  state c <<choice>>

  [*] --> COLLECTING : onRangingStart()
  COLLECTING --> COLLECTING : onMeasurementReceived() / update_calibration_data()
  COLLECTING --> c
  c --> SENDING_DATA : enoughSamples()
  c --> [*] : timeout
  SENDING_DATA --> [*]
}
@enduml
```

## Diagramme de séquence

```plantuml
@startuml
title Séquence — Démarrage et déroulé d'une calibration
participant Wifi as "WifiCommunication"
participant MessageDecoder as "MessageDecoder"
participant Calibrator as "Calibrator"
participant UWBAnchor as "UWBAnchor"
participant Display as "DisplayManager"


Wifi -> MessageDecoder : StartCalibration(deviceId)
activate MessageDecoder
MessageDecoder -> Calibrator : StartCalibration
deactivate MessageDecoder
activate Calibrator
Calibrator -> Calibrator : resetCalibrationData()

Calibrator -> UWBAnchor : switch to TAG mode
activate UWBAnchor
UWBAnchor -> UWBAnchor : apply TAG configuration
deactivate UWBAnchor


loop until calibration is finished
UWBAnchor -> Calibrator : onRangingData()
Calibrator -> Calibrator : updateCalibrationData()
Calibrator -> Display : update display
end


alt enoughSamples
Calibrator -> Calibrator : makeJSONFromCalibrationData()
Calibrator -> Wifi : sendCalibrationData()
end
Calibrator -> Display : update display
Calibrator -> Calibrator : endCalibration()
deactivate Calibrator
```

### La matrice de distances

Une fois les mesures de distances inter-anchors collectées, elles sont organisées dans une **matrice de distance** pour le traitement ultérieur :

$$
D =
\begin{bmatrix}
0 & d_{12} & d_{13} & \cdots & d_{1n} \\
d_{21} & 0 & d_{23} & \cdots & d_{2n} \\
d_{31} & d_{32} & 0 & \cdots & d_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
d_{n1} & d_{n2} & d_{n3} & \cdots & 0
\end{bmatrix}
$$

où $d_{ij}$ désigne la distance mesurée entre les anchors $i$ et $j$.  
En théorie, $D$ est symétrique ($d_{ij} = d_{ji}$), mais des écarts peuvent apparaître à cause du bruit de mesure ou d’erreurs de synchronisation.


## Reconstruction des positions

L’objectif est de retrouver les coordonnées $\mathbf{p}_i = (x_i, y_i)$ des $n$ anchors telles que :

$$
\|\mathbf{p}_i - \mathbf{p}_j\| \approx d_{ij}, \quad \forall (i, j)
$$

C’est un **problème de multidimensional scaling** (MDS) ou d’**ajustement géométrique par moindres carrés non linéaires**.

## Mise en place du repère

Pour lever l’ambiguïté liée aux rotations et translations, deux anchors sont fixées comme références :

- $A_0$ est placée à l’origine : $\mathbf{p}_0 = (0, 0)$  
- $A_1$ est placée sur l’axe des x : $\mathbf{p}_1 = (d_{01}, 0)$

Les autres anchors $A_k$ sont initialisées par **triangulation** à partir de ces deux références :

$$
\begin{cases}
x_k = \dfrac{d_{0k}^2 - d_{1k}^2 + d_{01}^2}{2d_{01}} \\
y_k = \sqrt{d_{0k}^2 - x_k^2}
\end{cases}
$$

Cette étape fournit une **estimation initiale** cohérente des positions.

## Optimisation par descente de gradient

Les positions initiales sont ensuite **optimisées numériquement** afin de minimiser l’erreur entre les distances mesurées et les distances géométriques reconstruites :

$$
E = \sum_{i<j} \left( \|\mathbf{p}_i - \mathbf{p}_j\| - d_{ij} \right)^2
$$

Une **descente de gradient** met à jour les positions à chaque itération selon :

$$
\mathbf{p}_i \leftarrow \mathbf{p}_i - \eta \, \nabla_{\mathbf{p}_i} E
$$

où $\eta$ est le taux d’apprentissage, et le gradient s’écrit :

$$
\nabla_{\mathbf{p}_i} E = 2 \sum_{j \ne i} \left( \|\mathbf{p}_i - \mathbf{p}_j\| - d_{ij} \right) \frac{\mathbf{p}_i - \mathbf{p}_j}{\|\mathbf{p}_i - \mathbf{p}_j\|}
$$

Pendant cette optimisation :
- L’anchor $A_0$ reste fixe (origine du repère),
- L’anchor $A_1$ reste sur l’axe des x (contrainte de rotation).

L’algorithme converge lorsque l’erreur moyenne devient stable ou inférieure à un seuil défini.

## Normalisation et échelle

Une fois les positions obtenues, elles peuvent être **normalisées** afin de tenir dans un cadre cohérent (utile pour l’affichage ou le traitement ultérieur).  
On calcule le **rectangle englobant** de toutes les positions, puis on met à l’échelle :

$$
\mathbf{p}_i^{(norm)} = \dfrac{\mathbf{p}_i - \mathbf{p}_{min}}{\max(\Delta x, \Delta y)}
$$

où $\Delta x$ et $\Delta y$ représentent les dimensions maximales du nuage de points.

## Évaluation de l’erreur relative

L’erreur finale est exprimée en **erreur quadratique moyenne relative** :

$$
\text{Erreur} = \frac{\sqrt{\dfrac{1}{N}\sum_{i<j} (\|\mathbf{p}_i - \mathbf{p}_j\| - d_{ij})^2}}{\bar{d}} \times 100
$$

avec $\bar{d}$ la distance moyenne entre anchors.  
Cette mesure reflète la cohérence géométrique du réseau d’anchors après calibration.
