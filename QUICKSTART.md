# Guide de Démarrage Rapide

Ce guide vous permettra de lancer la documentation et de commencer à la rédiger.

---

## 🚀 Installation (5 minutes)

### 1. Prérequis

- Python 3.8 ou supérieur
- pip (installé avec Python)
- Git (optionnel)

Vérifier l'installation :

```bash
python3 --version
pip3 --version
```

### 2. Installer MkDocs et les plugins

```bash
# Installer MkDocs avec Material theme
pip install mkdocs-material

# Installer plugins pour PlantUML et Git
pip install mkdocs-plantuml-plugin
pip install mkdocs-git-revision-date-localized-plugin
```

### 3. Lancer le serveur de développement

```bash
cd "/home/hugo/Repositories/UWB ESP32/documentation"
mkdocs serve
```

Ouvrir http://127.0.0.1:8000 dans votre navigateur.

Le serveur se recharge automatiquement à chaque modification de fichier !

---

## 📝 Workflow de Rédaction

### 1. Créer une nouvelle page

```bash
# Créer fichier dans le bon dossier
touch docs/hardware/new-component.md
```

### 2. Utiliser le template

Copier le contenu de `docs/_templates/template-module.md` et adapter.

### 3. Ajouter au menu (mkdocs.yml)

```yaml
nav:
  - Hardware:
      - New Component: hardware/new-component.md
```

### 4. Voir le résultat en temps réel

Le navigateur se rafraîchit automatiquement !

---

## 🎨 Syntaxe Markdown Avancée

### Admonitions (Notes colorées)

```markdown
!!! note "Titre"
    Contenu de la note

!!! warning "Attention"
    Ceci est un avertissement

!!! tip "Astuce"
    Ceci est une astuce

!!! danger "Danger"
    Ceci est critique
```

### Tabs de Code

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

### Diagrammes PlantUML

```markdown
​```puml
@startuml
Alice -> Bob: Hello
Bob --> Alice: Hi!
@enduml
​```
```

### Diagrammes Mermaid

```markdown
​```mermaid
graph LR
    A[Tag] --> B[Anchor]
    B --> C[Station]
​```
```

### Tableaux

```markdown
| Colonne 1 | Colonne 2 | Colonne 3 |
|-----------|-----------|-----------|
| Valeur 1  | Valeur 2  | Valeur 3  |
```

### Listes de tâches

```markdown
- [x] Tâche complétée
- [ ] Tâche en cours
- [ ] Tâche à faire
```

---

## 🏗️ Structure Recommandée

Pour chaque module/composant, créer :

### 1. Vue d'ensemble
- Description générale
- Objectifs
- Cas d'usage

### 2. Architecture
- Diagrammes UML (classes, composants)
- Flux de données
- Dépendances

### 3. Implémentation
- Structure fichiers
- Classes principales
- Exemples de code

### 4. API
- Fonctions publiques
- Paramètres
- Format messages

### 5. Configuration
- Paramètres disponibles
- Valeurs par défaut
- Exemples

### 6. Tests
- Tests unitaires
- Tests d'intégration
- Scénarios

### 7. Dépannage
- Problèmes communs
- Solutions

---

## 📋 Checklist de Documentation

Pour chaque composant :

- [ ] Fichier créé dans bon dossier
- [ ] Ajouté au menu mkdocs.yml
- [ ] Vue d'ensemble rédigée
- [ ] Diagrammes UML créés
- [ ] Code examples fournis
- [ ] API documentée
- [ ] Tests décrits
- [ ] Section dépannage complétée
- [ ] Liens internes créés
- [ ] Revue orthographe/grammaire

---

## 🔧 Commandes Utiles

### Développement

```bash
# Lancer serveur local
mkdocs serve

# Lancer sur port différent
mkdocs serve -a localhost:8001

# Mode verbose pour debug
mkdocs serve --verbose
```

### Build

```bash
# Construire site statique
mkdocs build

# Build avec vérification liens
mkdocs build --strict

# Nettoyer fichiers générés
mkdocs build --clean
```

### Déploiement

```bash
# Déployer sur GitHub Pages
mkdocs gh-deploy

# Déployer avec message custom
mkdocs gh-deploy -m "Update documentation"
```

---

## 🎯 Prochaines Étapes

### Priorité 1 : Sections Existantes

Compléter les sections déjà créées :

1. ✅ `docs/index.md` - Page d'accueil (FAIT)
2. ✅ `docs/project/vision.md` - Vision projet (FAIT)
3. ✅ `docs/architecture/global.md` - Architecture (FAIT)
4. 🔄 Remplir les autres pages avec template

### Priorité 2 : Documentation Hardware

1. [ ] `docs/hardware/tag.md` - Tag UWB détaillé
2. [ ] `docs/hardware/anchor.md` - Anchor UWB détaillé
3. [ ] `docs/hardware/ir-beacons.md` - Puces IR
4. [ ] `docs/hardware/base-station.md` - Station de base

### Priorité 3 : Documentation Software

1. [ ] `docs/software/tag/` - Tous les fichiers Tag
2. [ ] `docs/software/anchor/` - Tous les fichiers Anchor
3. [ ] `docs/software/base-station/` - Station software
4. [ ] `docs/software/desktop/` - Application desktop

### Priorité 4 : Guides Pratiques

1. [ ] `docs/user-guide/installation.md`
2. [ ] `docs/user-guide/initial-setup.md`
3. [ ] `docs/dev-guide/environment.md`
4. [ ] `docs/dev-guide/build-flash.md`

---

## 💡 Conseils de Rédaction

### 1. Être Clair et Concis

❌ Mauvais :
> "Ce composant permet de faire des choses avec les données"

✅ Bon :
> "Le MessageDecoder parse les messages JSON UWB et déclenche les callbacks appropriés"

### 2. Utiliser des Exemples

Toujours inclure exemples de code concrets :

```cpp
// ✅ Bon exemple : complet et exécutable
MessageDecoder decoder;
decoder.setRangeCallback([](JsonDocument* doc) {
    float range = (*doc)["range"];
    Serial.println(range);
});
```

### 3. Documenter les Edge Cases

```markdown
!!! warning "Cas Particuliers"
    - Si `data` est NULL, retourne erreur
    - Si `size` > MAX_SIZE, tronque automatiquement
    - Thread-safe uniquement avec mutex activé
```

### 4. Créer des Liens Internes

```markdown
Voir aussi : [Architecture Globale](../architecture/global.md)
```

### 5. Utiliser Visuels

Un diagramme vaut mille mots !

---

## 📚 Ressources Utiles

### MkDocs

- [Documentation MkDocs](https://www.mkdocs.org/)
- [Material Theme](https://squidfunk.github.io/mkdocs-material/)
- [Extensions Markdown](https://python-markdown.github.io/extensions/)

### PlantUML

- [PlantUML Guide](https://plantuml.com/fr/)
- [PlantUML Examples](https://real-world-plantuml.com/)
- [PlantUML Online Editor](http://www.plantuml.com/plantuml/)

### Mermaid

- [Mermaid Documentation](https://mermaid.js.org/)
- [Mermaid Live Editor](https://mermaid.live/)

### Markdown

- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

---

## 🤝 Contribuer à la Documentation

1. Créer/modifier fichiers `.md` dans `docs/`
2. Tester localement avec `mkdocs serve`
3. Vérifier que tout s'affiche correctement
4. Commit et push

---

## ❓ FAQ

### Comment ajouter une image ?

```markdown
![Description](../assets/images/mon-image.png)
```

Placer images dans `docs/assets/images/`.

### Comment créer un lien externe ?

```markdown
[Texte du lien](https://example.com)
```

### Comment centrer du texte ?

```markdown
<div style="text-align: center;">
  Texte centré
</div>
```

### Comment changer les couleurs ?

Modifier dans `mkdocs.yml` :

```yaml
theme:
  palette:
    primary: indigo  # Couleur principale
    accent: blue     # Couleur accent
```

---

<div style="text-align: center; margin-top: 50px;">
  <p><strong>Bonne rédaction ! 📝</strong></p>
  <p><em>La documentation est au cœur de la réussite du projet.</em></p>
</div>
