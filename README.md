# Documentation - Système de Positionnement UWB pour Voitures RC

Ce dossier contient la documentation complète du projet utilisant **MkDocs** avec le thème **Material**.

## 📚 Structure de la Documentation

La documentation est organisée en plusieurs sections :

- **Vue d'ensemble** : Introduction, architecture globale, spécifications
- **Gestion de Projet** : Vision, planification, roadmap, user stories
- **Architecture** : Diagrammes UML, communication, flux de données
- **Composants Hardware** : Tag, Anchor, Puces IR, Station de Base
- **Composants Software** : Firmware, librairies, station, application desktop
- **Protocoles & API** : Tous les protocoles de communication
- **Guides** : Utilisateur et développeur
- **Amélioration Continue** : Plans d'action pour chaque composant

## 🚀 Installation et Utilisation

### 1. Installer MkDocs

```bash
# Installer Python 3.8+ si nécessaire
python3 --version

# Installer MkDocs et le thème Material
pip install mkdocs-material

# Installer les plugins
pip install mkdocs-git-revision-date-localized-plugin
pip install mkdocs-plantuml-plugin
```

### 2. Lancer le serveur de développement

```bash
cd /home/hugo/Repositories/UWB\ ESP32/documentation
mkdocs serve
```

Ouvrir http://127.0.0.1:8000 dans le navigateur.

Le serveur se recharge automatiquement à chaque modification !

### 3. Build la documentation statique

```bash
mkdocs build
```

Les fichiers HTML sont générés dans `site/`.

### 4. Déployer sur GitHub Pages

```bash
mkdocs gh-deploy
```

## 📝 Écrire la Documentation

### Format des fichiers

Tous les fichiers sont en **Markdown** (`.md`) dans le dossier `docs/`.

### Utiliser PlantUML

```markdown
​```puml
@startuml
class UWBTag {
  +setup()
  +loop()
  +sendPosition()
}
@enduml
​```
```

### Utiliser Mermaid (alternative)

```markdown
​```mermaid
graph TD
    A[Tag] --> B[Anchor 1]
    A --> C[Anchor 2]
    B --> D[Station]
    C --> D
​```
```

### Admonitions (notes, warnings)

```markdown
!!! note "Information"
    Ceci est une note importante.

!!! warning "Attention"
    Ceci est un avertissement.

!!! tip "Astuce"
    Ceci est une astuce utile.
```

### Onglets de code

```markdown
=== "C++"
    ​```cpp
    void setup() {
        Serial.begin(115200);
    }
    ​```

=== "Python"
    ​```python
    import serial
    ser = serial.Serial('/dev/ttyUSB0', 115200)
    ​```
```

## 🎨 Personnalisation

### Couleurs

Modifier dans `mkdocs.yml` :

```yaml
theme:
  palette:
    primary: indigo  # ou blue, red, green, etc.
    accent: blue
```

### Logo

Ajouter votre logo :

```yaml
theme:
  logo: assets/logo.png
  favicon: assets/favicon.png
```

## 📦 Structure des Fichiers

```
documentation/
├── mkdocs.yml              # Configuration principale
├── README.md               # Ce fichier
├── docs/                   # Contenu de la documentation
│   ├── index.md           # Page d'accueil
│   ├── overview/          # Vue d'ensemble
│   ├── project/           # Gestion de projet
│   ├── architecture/      # Architecture système
│   ├── hardware/          # Composants hardware
│   ├── software/          # Composants software
│   ├── protocols/         # Protocoles et API
│   ├── user-guide/        # Guide utilisateur
│   ├── dev-guide/         # Guide développeur
│   ├── improvement/       # Plans d'amélioration
│   ├── annexes/           # Annexes
│   ├── assets/            # Images, logos, etc.
│   └── stylesheets/       # CSS personnalisé
└── site/                   # Généré par mkdocs build
```

## 🔧 Commandes Utiles

| Commande | Description |
|----------|-------------|
| `mkdocs serve` | Lancer serveur dev avec hot-reload |
| `mkdocs build` | Construire site statique |
| `mkdocs gh-deploy` | Déployer sur GitHub Pages |
| `mkdocs new .` | Créer nouveau projet |
| `mkdocs -h` | Aide |

## 📖 Ressources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [PlantUML](https://plantuml.com/)
- [Markdown Guide](https://www.markdownguide.org/)

## ✅ Checklist Documentation

- [ ] Remplir tous les fichiers template
- [ ] Créer tous les diagrammes UML
- [ ] Ajouter screenshots et photos
- [ ] Rédiger user stories
- [ ] Documenter API REST
- [ ] Écrire guides installation
- [ ] Créer exemples de code
- [ ] Ajouter FAQ
- [ ] Tester tous les liens
- [ ] Déployer version finale

