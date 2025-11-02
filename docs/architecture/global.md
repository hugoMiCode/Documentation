# Architecture Globale du Système

!!! abstract "Vue d'ensemble"
    Cette section présente l'architecture complète du système de positionnement UWB, de la vue 10,000 pieds jusqu'aux détails d'implémentation.

---

## 🏗️ Vue d'Ensemble de l'Architecture

Le système suit une **architecture distribuée en couches** avec séparation claire des responsabilités :

```plantuml
@startuml
' !theme blueprint
skinparam componentStyle rectangle

package "Couche Matérielle (Hardware Layer)" {
  [Tags UWB] as Tags
  [Anchors UWB] as Anchors
  [Puces IR] as IR
  [Station ESP32] as Station
}

package "Couche Communication (Communication Layer)" {
  [WiFi Network] as WiFi
  [UWB Protocol] as UWB
  [IR Protocol] as IRP
}

package "Couche Traitement (Processing Layer)" {
  [Position Engine] as PosEngine
  [Timing Engine] as TimeEngine
  [Calibration Engine] as CalEngine
}

package "Couche Application (Application Layer)" {
  [Web Interface] as WebUI
  [Desktop App] as DesktopApp
  [Cloud Storage] as Cloud
}

package "Couche Données (Data Layer)" {
  database "SD Card" as SD
  database "Local Storage" as LocalDB
  database "Cloud DB" as CloudDB
}

' Relations
Tags --> UWB
Anchors --> UWB
IR --> IRP
Tags --> WiFi
Anchors --> WiFi
Station --> WiFi

UWB --> PosEngine
WiFi --> PosEngine
IRP --> TimeEngine

PosEngine --> Station
TimeEngine --> Station
CalEngine --> Anchors

Station --> WebUI
Station --> SD
SD --> DesktopApp
DesktopApp --> LocalDB
DesktopApp --> Cloud
Cloud --> CloudDB

@enduml
```

---

## 📦 Architecture en 4 Modules

### Module 1 : Tags UWB (Mobile)

```plantuml
@startuml
' !theme blueprint

package "Tag ESP32" {
  component "UWBTag" as UWB {
    [AT Commands Handler]
    [Distance Measurement]
    [Position Calculation]
  }
  
  component "IRReceiver" as IR {
    [Manchester Decoder]
    [Timing Processor]
    [Sector Detection]
  }
  
  component "DisplayManager" as DISP {
    [OLED Driver]
    [UI Renderer]
    [Status Display]
  }
  
  component "WifiCommunication" as WIFI {
    [TCP Client]
    [JSON Serializer]
    [Message Queue]
  }
  
  component "MessageDecoder" as MSG {
    [Callbacks]
    [State Machine]
    [Data Aggregation]
  }
}

UWB --> MSG : Distance data
IR --> MSG : Timing data
MSG --> WIFI : Aggregated data
MSG --> DISP : Display info

interface "UART" as UART_IF
interface "GPIO" as GPIO_IF
interface "I2C" as I2C_IF
interface "WiFi" as WIFI_IF

UART_IF - UWB
GPIO_IF - IR
I2C_IF - DISP
WIFI_IF - WIFI

@enduml
```

**Responsabilités** :
- ✅ Mesurer distances vers tous les anchors visibles
- ✅ Calculer position 2D par trilatération
- ✅ Détecter signaux IR de chronométrage
- ✅ Agréger et transmettre données temps réel
- ✅ Afficher statut local

---

### Module 2 : Anchors UWB (Fixes)

```plantuml
@startuml
' !theme blueprint

package "Anchor ESP32" {
  component "UWBAnchor" as UWB {
    [AT Commands Handler]
    [Ranging Responder]
    [Mode Switcher]
  }
  
  component "Calibrator" as CAL {
    [Auto-Trigger Logic]
    [Tag Mode Simulation]
    [Data Collection]
    [Average Calculator]
  }
  
  component "DisplayManager" as DISP {
    [OLED Driver]
    [Calibration Progress]
    [Status Display]
  }
  
  component "WifiCommunication" as WIFI {
    [TCP Client]
    [JSON Serializer]
    [Command Receiver]
  }
  
  component "CalibrationLinkNode" as LINK {
    [Linked List]
    [Statistics]
    [Validation]
  }
}

UWB --> CAL : Distance measurements
CAL --> LINK : Store calibration data
LINK --> WIFI : Send to station
WIFI --> CAL : Trigger commands
CAL --> DISP : Progress %
UWB <--> CAL : Mode switch

interface "UART" as UART_IF
interface "I2C" as I2C_IF
interface "WiFi" as WIFI_IF

UART_IF - UWB
I2C_IF - DISP
WIFI_IF - WIFI

@enduml
```

**Responsabilités** :
- ✅ Répondre aux requêtes de distance des tags
- ✅ Auto-calibration en mesurant distances inter-anchors
- ✅ Switch automatique mode Anchor ↔ Tag
- ✅ Transmettre données calibration vers station
- ✅ Afficher progression calibration

---

### Module 3 : Station de Base

```plantuml
@startuml
' !theme blueprint

package "Station ESP32" {
  component "WebServer" as WEB {
    [HTTP Server]
    [WebSocket Server]
    [Static Files]
  }
  
  component "DataCollector" as COLLECT {
    [WiFi Listener]
    [Data Parser]
    [Aggregator]
  }
  
  component "SDStorage" as SD {
    [File Manager]
    [CSV Writer]
    [JSON Writer]
  }
  
  component "RemoteControl" as REMOTE {
    [Command Dispatcher]
    [Device Registry]
    [Config Manager]
  }
  
  component "DisplayDashboard" as DASH {
    [Real-time Updates]
    [Position Map]
    [Timing Board]
  }
}

COLLECT --> WEB : Real-time data
COLLECT --> SD : Store data
WEB --> REMOTE : User commands
REMOTE --> COLLECT : Control devices
COLLECT --> DASH : Update UI

interface "WiFi Server" as WIFI_SRV
interface "SD Card SPI" as SPI_IF
interface "OLED I2C" as I2C_IF

WIFI_SRV - COLLECT
SPI_IF - SD
I2C_IF - DASH

database "SD Files" as SDFILES {
  file "session_001.csv"
  file "calibration.json"
  file "config.ini"
}

SD --> SDFILES

@enduml
```

**Responsabilités** :
- 🚧 Interface web temps réel (HTML/JS)
- 🚧 Collecte données de tous les tags/anchors
- 🚧 Enregistrement sur carte SD
- 🚧 Télécommande des devices (start/stop, config)
- 🚧 Affichage live positions et classement

---

### Module 4 : Application Desktop

```plantuml
@startuml

package "Desktop Application" {
  component "DataImporter" as IMPORT {
    [SD Reader]
    [CSV Parser]
    [JSON Parser]
    [Validator]
  }
  
  component "DataProcessor" as PROCESS {
    [Trajectory Calculator]
    [Statistics Engine]
    [Lap Analyzer]
    [Sector Analyzer]
  }
  
  component "Visualizer" as VIZ {
    [2D Track Renderer]
    [Heatmaps]
    [Charts (Plotly/D3)]
    [Replay Engine]
  }
  
  component "CloudSync" as CLOUD {
    [User Auth]
    [REST Client]
    [Sync Engine]
  }
  
  component "ExportManager" as EXPORT {
    [PDF Generator]
    [CSV Exporter]
    [JSON Exporter]
  }
  
  component "UI" as UI {
    [Main Window]
    [Settings]
    [Session Manager]
  }
}

IMPORT --> PROCESS : Raw data
PROCESS --> VIZ : Processed data
PROCESS --> EXPORT : Reports
VIZ --> UI : Render
CLOUD --> PROCESS : Cloud data
PROCESS --> CLOUD : Upload

database "Local SQLite" as DB

note right of DB
  tables: sessions, laps, positions
end note

PROCESS --> DB
VIZ --> DB

cloud "Cloud Backend" as CLOUD_BE {
  [User API]
  [Data API]
  database "PostgreSQL"
}

CLOUD --> CLOUD_BE

@enduml
```

**Responsabilités** :
- 📋 Import fichiers depuis SD
- 📋 Traitement et analyse avancée
- 📋 Visualisations interactives (trajectoires, graphiques)
- 📋 Comparaisons multi-sessions
- 📋 Export rapports (PDF, CSV)
- 📋 Sync cloud par utilisateur

---

## 🔄 Flux de Données Complet

### Scénario : Course en Temps Réel

```plantuml
@startuml
!theme blueprint

participant "Tag\n(Voiture)" as Tag
participant "Anchor 1" as A1
participant "Anchor 2" as A2
participant "Anchor 3" as A3
participant "Puce IR" as IR
participant "Station\nde Base" as Station
participant "Spectateurs\n(Web)" as Web

== Initialisation ==
Station -> A1 : Check status
Station -> A2 : Check status
Station -> A3 : Check status
Station -> Tag : Start recording

== Boucle Position (10Hz) ==
loop Every 100ms
  Tag -> A1 : Request distance
  A1 --> Tag : 1.23m, -45dBm
  Tag -> A2 : Request distance
  A2 --> Tag : 2.45m, -52dBm
  Tag -> A3 : Request distance
  A3 --> Tag : 3.67m, -48dBm
  
  Tag -> Tag : Calculate position\n(x, y)
  Tag -> Station : {"pos": [1.5, 2.3], "t": 12345}
  Station -> Web : WebSocket update
end

== Événement Chronométrage ==
IR -> Tag : Manchester signal\n[START, ID=1]
Tag -> Tag : Decode IR
Tag -> Station : {"event": "lap", "time": 45.234}
Station -> Web : Update leaderboard
Station -> Station : Write to SD

== Fin de Session ==
Station -> Tag : Stop recording
Station -> Station : Finalize SD files

@enduml
```

---

## 🌐 Architecture Réseau

### Topologie WiFi

```plantuml
@startuml
' !theme blueprint

package "WiFi Network" {
  node "station\n192.168.2.1" as station
  node "anchor1\n192.168.2.5" as anchor1
  node "anchor2\n192.168.2.6" as anchor2
  node "anchor3\n192.168.2.7" as anchor3
  node "anchor4\n192.168.2.8" as anchor4
  node "tag1\n192.168.2.101" as tag1
  node "tag2\n192.168.2.102" as tag2
  node "tag3\n192.168.2.103" as tag3
}

package "Internet" {
  node "Cloud Backend" as cloud_backend
}

station -- cloud_backend

note right of station
   • TCP Server port 80 (HTTP)
   • TCP Server port 8080 (WebSocket)
   • UDP Listener port 5000
end note

@enduml
```

**Adressage** :
- Station : `192.168.2.1` (serveur)
- Anchors : `192.168.2.5-8` (ID + 2)
- Tags : `192.168.2.101-108` (100 + ID)

---

## 💾 Architecture Données

### Modèle de Données

```plantuml
@startuml
!theme blueprint

entity "Session" {
  * session_id : UUID
  --
  * start_time : DateTime
  * end_time : DateTime
  circuit_name : String
  num_laps : Integer
}

entity "Lap" {
  * lap_id : UUID
  --
  * session_id : UUID <<FK>>
  * tag_id : Integer
  * lap_number : Integer
  * lap_time_ms : Integer
  * timestamp : DateTime
}

entity "Position" {
  * position_id : UUID
  --
  * session_id : UUID <<FK>>
  * tag_id : Integer
  * timestamp : DateTime
  x : Float
  y : Float
  speed : Float
}

entity "Sector" {
  * sector_id : UUID
  --
  * lap_id : UUID <<FK>>
  * sector_number : Integer
  * sector_time_ms : Integer
}

entity "Calibration" {
  * calibration_id : UUID
  --
  * timestamp : DateTime
  * anchor_id : Integer
  data : JSON
  is_valid : Boolean
}

Session ||--o{ Lap
Lap ||--o{ Sector
Session ||--o{ Position
Session ||--o{ Calibration

@enduml
```

---

## ⚡ Architecture Performance

### Optimisations Clés

```plantuml
@startuml
!theme blueprint

component "Tag Optimizations" {
  [Message Batching] as BATCH
  [Local Buffering] as BUFFER
  [Adaptive Sampling] as ADAPTIVE
  [Power Management] as POWER
}

component "Station Optimizations" {
  [Connection Pooling] as POOL
  [WebSocket Compression] as WS_COMPRESS
  [SD Write Buffering] as SD_BUFFER
  [Multi-Threading] as THREADS
}

component "Network Optimizations" {
  [UDP for Position] as UDP
  [TCP for Critical] as TCP
  [QoS Prioritization] as QOS
  [Multicast for Broadcast] as MCAST
}

note right of BATCH
  Group messages
  → Reduce overhead
end note

note right of ADAPTIVE
  10Hz when moving
  1Hz when stationary
end note

note right of UDP
  Low latency
  OK to lose packets
end note

@enduml
```

---

## 🧩 Patterns de Conception Utilisés

### 1. Observer Pattern (Callbacks)

```cpp
// MessageDecoder utilise observer pour notifier
class MessageDecoder {
public:
    void setRangeCallback(void (*callback)(JsonDocument*));
    void setSleepCallback(void (*callback)(int));
    void setWakeupCallback(void (*callback)(int));
};
```

### 2. State Machine Pattern

```plantuml
@startuml
!theme blueprint

[*] --> Idle

Idle --> Connecting : WiFi connect
Connecting --> Connected : Success
Connecting --> Idle : Timeout

Connected --> Measuring : Start session
Measuring --> Recording : IR detected
Recording --> Measuring : Lap complete
Measuring --> Connected : Stop session

Connected --> Calibrating : Calibration cmd
Calibrating --> Connected : Complete

Connected --> [*] : Shutdown

@enduml
```

### 3. Factory Pattern (LinkNodes)

```cpp
// Création dynamique de nœuds selon type
AnchorLinkNode* createAnchorNode(uint8_t aid);
TagLinkNode* createTagNode(uint8_t tid);
CalibrationLinkNode* createCalibrationNode(uint8_t aid);
```

### 4. Singleton Pattern (Managers)

```cpp
class DisplayManager {
private:
    static DisplayManager* instance;
    DisplayManager() {}
    
public:
    static DisplayManager& getInstance();
};
```

---

## 🔧 Technologies & Stack

### Embedded Stack (Tags & Anchors)

| Layer | Technology |
|-------|------------|
| **Hardware** | ESP32-DevKit, DW3000 |
| **OS** | FreeRTOS (via Arduino) |
| **Language** | C++ (Arduino Framework) |
| **Build** | PlatformIO |
| **Communication** | WiFi (ESP32), UART (DW3000) |
| **Display** | Adafruit SSD1306 |
| **Data Format** | JSON (ArduinoJson) |

### Station Stack

| Layer | Technology |
|-------|------------|
| **Hardware** | ESP32-DevKit, SD Card Module |
| **Backend** | ESP32 AsyncWebServer |
| **Frontend** | HTML5, JavaScript, WebSocket |
| **Storage** | SD Card (FAT32) |
| **Visualization** | Chart.js / D3.js |

### Desktop Stack

| Layer | Technology (Options) |
|-------|----------------------|
| **Framework** | Electron / Qt / Python (Tkinter) |
| **Language** | JavaScript/TypeScript / C++ / Python |
| **Visualization** | Plotly / Matplotlib / D3.js |
| **Database** | SQLite |
| **Cloud** | REST API (Node.js / FastAPI) |

---

<div style="text-align: center; margin-top: 50px;">
  <p><strong>Architecture complète et modulaire pour garantir évolutivité et maintenabilité.</strong></p>
  <p><em>Prochain chapitre : <a href="../../protocols/uwb/">Protocoles de Communication</a></em></p>
</div>
