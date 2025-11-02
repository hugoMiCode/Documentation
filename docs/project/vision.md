# Vision et Objectifs du Projet

!!! quote "Vision"
    Créer un système de chronométrage et de positionnement **précis, fiable et accessible** pour les courses de voitures RC, permettant une analyse détaillée des performances en temps réel.

---

## 🎯 Objectifs Principaux

### 1. Positionnement Précis en Temps Réel

**Objectif** : Localiser chaque voiture RC avec une précision < 30cm à 10Hz

**Bénéfices** :
- Visualisation en direct des trajectoires
- Analyse des lignes de course optimales
- Détection de zones à problème
- Comparaison entre pilotes

**Critères de Succès** :
- ✅ Précision < 30cm en conditions réelles
- ✅ Taux de rafraîchissement ≥ 10Hz
- ✅ Support simultané de 8 voitures minimum
- ✅ Latence totale < 100ms

---

### 2. Chronométrage Ultra-Précis

**Objectif** : Chronométrer tours et secteurs avec précision < 10ms

**Bénéfices** :
- Temps au tour officiels
- Temps secteurs pour analyse fine
- Classement en temps réel
- Détection photo-finish

**Critères de Succès** :
- ✅ Précision IR < 10ms
- ✅ Aucune perte de signal en passage
- ✅ Décodage Manchester fiable
- ✅ Distinction Start/Finish et secteurs

---

### 3. Système Auto-Calibré

**Objectif** : Configuration automatique sans intervention manuelle

**Bénéfices** :
- Installation rapide sur nouveau circuit
- Pas besoin de mesures manuelles
- Recalibration automatique si nécessaire
- Réduction erreurs humaines

**Critères de Succès** :
- ✅ Calibration complète en < 2 minutes
- ✅ Précision inter-anchor < 5cm
- ✅ Persistance données calibration
- ✅ Détection automatique topologie réseau

---

### 4. Analyse Post-Course Approfondie

**Objectif** : Fournir outils d'analyse détaillée des performances

**Bénéfices** :
- Amélioration technique des pilotes
- Comparaison sessions multiples
- Statistiques avancées
- Export données personnalisé

**Critères de Succès** :
- ✅ Stockage 100% des données brutes
- ✅ Import depuis carte SD
- ✅ Visualisations interactives
- ✅ Export CSV/JSON/PDF

---

## 🌟 Valeurs du Projet

### Accessibilité

!!! tip "Open Source"
    - Code entièrement open-source
    - Documentation complète et pédagogique
    - Composants abordables (< 50€ par tag)
    - DIY-friendly

### Fiabilité

!!! success "Robustesse"
    - Tests exhaustifs en conditions réelles
    - Mode dégradé si composants défaillants
    - Redondance des données
    - Recovery automatique après erreurs

### Extensibilité

!!! note "Modularité"
    - Architecture modulaire
    - APIs bien définies
    - Support nouveaux capteurs
    - Intégration facile avec autres systèmes

### Performance

!!! warning "Optimisation"
    - Temps réel garanti
    - Faible latence réseau
    - Minimisation consommation batterie
    - Scalabilité (jusqu'à 16 tags)

---

## 👥 Personas Utilisateurs

### 1. Le Pilote Amateur

**Profil** : Pierre, 35 ans, pilote RC le weekend

**Besoins** :
- Connaître ses temps au tour
- Comparer avec ses amis
- Améliorer progressivement
- Interface simple

**Frustrations** :
- Systèmes pro trop chers
- Chronos manuels imprécis
- Pas de données exploitables

**Solution apportée** :
- Système abordable < 200€
- Temps précis automatiques
- App simple avec classement

---

### 2. Le Coach Technique

**Profil** : Marie, 28 ans, coach d'équipe RC

**Besoins** :
- Analyser trajectoires détaillées
- Identifier points d'amélioration
- Comparer avant/après coaching
- Préparer sessions training

**Frustrations** :
- Retours subjectifs peu exploitables
- Pas de données objectives
- Difficile de prouver progrès

**Solution apportée** :
- Trajectoires visualisées
- Statistiques secteurs
- Comparaisons multiples
- Export rapports PDF

---

### 3. L'Organisateur d'Événements

**Profil** : Luc, 42 ans, organise compétitions RC

**Besoins** :
- Gérer 20+ pilotes simultanément
- Affichage temps réel public
- Classements automatiques
- Fiabilité absolue

**Frustrations** :
- Systèmes complexes à installer
- Coûts location énormes
- Bugs en pleine course

**Solution apportée** :
- Installation rapide (< 30min)
- Interface web spectateurs
- Système éprouvé fiable
- Coût fixe (pas de location)

---

### 4. Le Développeur Tinkerer

**Profil** : Sophie, 24 ans, dev et maker

**Besoins** :
- Intégrer avec ses outils
- Accès données brutes
- Modifier/étendre système
- Contribuer au projet

**Frustrations** :
- Systèmes fermés propriétaires
- APIs limitées ou absentes
- Documentation inexistante

**Solution apportée** :
- Code 100% open-source
- APIs REST complètes
- Documentation technique
- Architecture extensible

---

## 🎯 User Stories Prioritaires

### Epic 1 : Chronométrage de Base

```gherkin
En tant que pilote
Je veux voir mes temps au tour en temps réel
Afin de savoir si je progresse pendant la session

Critères d'acceptation :
- Le temps s'affiche < 500ms après passage ligne
- Précision < 10ms
- Historique des 10 derniers tours visible
- Best lap mis en évidence
```

---

### Epic 2 : Positionnement sur Circuit

```gherkin
En tant que coach
Je veux visualiser la trajectoire exacte de mon pilote
Afin d'identifier les zones où il perd du temps

Critères d'acceptation :
- Rafraîchissement position ≥ 10Hz
- Précision < 30cm
- Overlay trajectoire sur plan circuit
- Comparaison 2 trajectoires simultanées
```

---

### Epic 3 : Analyse Post-Session

```gherkin
En tant qu'utilisateur
Je veux importer mes données de course sur PC
Afin d'analyser en détail mes performances

Critères d'acceptation :
- Import fichier SD en < 10 secondes
- Graphiques interactifs (zoom, pan)
- Export CSV pour traitement externe
- Stockage cloud optionnel
```

---

### Epic 4 : Installation Facile

```gherkin
En tant qu'organisateur
Je veux installer le système sur un nouveau circuit
Afin de l'utiliser en moins de 30 minutes

Critères d'acceptation :
- Guide installation illustré
- Calibration automatique anchors
- Vérification connexions auto
- Wizard configuration web
```

---

## 📊 Indicateurs de Succès (KPIs)

### Métriques Techniques

| Indicateur | Objectif | Mesure |
|------------|----------|--------|
| **Précision positionnement** | < 30cm | Écart vs mesures laser |
| **Précision chronométrage** | < 10ms | Tests cellule photo |
| **Latence end-to-end** | < 100ms | Tag → Station |
| **Disponibilité système** | > 99.5% | Uptime par session |
| **Durée batterie tag** | > 4h | Course continue |
| **Taux perte paquets WiFi** | < 0.1% | Analyse logs |

### Métriques Utilisateurs

| Indicateur | Objectif | Mesure |
|------------|----------|--------|
| **Temps installation** | < 30min | Feedback terrain |
| **Temps formation utilisateur** | < 15min | Observation |
| **Satisfaction (NPS)** | > 8/10 | Questionnaire |
| **Taux adoption** | > 80% | Clubs équipés |
| **Bugs critiques** | 0 | Issues GitHub |

---

## 🗺️ Roadmap Vision Long Terme

```mermaid
timeline
    title Roadmap Projet UWB RC System
    
    section 2024 Q4
        MVP Fonctionnel : Tag + Anchor
                         : Chronométrage IR
                         : WiFi basique
    
    section 2025 Q1
        Station de Base : Interface web
                        : Enregistrement SD
                        : Multi-tags
    
    section 2025 Q2
        Application Desktop : Import données
                            : Visualisation
                            : Export rapports
    
    section 2025 Q3
        Améliorations : Cloud storage
                      : OTA updates
                      : Tests unitaires
    
    section 2025 Q4
        Features Avancées : Positionnement 3D
                          : ML trajectoires
                          : API publique
    
    section 2026+
        Expansion : App mobile
                  : Intégrations
                  : Communauté
```

---

## 🚀 Phases du Projet

### Phase 1 : MVP (Minimum Viable Product) ✅

**Objectif** : Prouver le concept avec fonctionnalités de base

**Livrables** :
- [x] Tag UWB fonctionnel
- [x] Anchor UWB avec calibration
- [x] Réception IR chronométrage
- [x] Communication WiFi basique
- [x] Affichage OLED

**Statut** : ✅ **COMPLÉTÉ**

---

### Phase 2 : Station de Base 🔄

**Objectif** : Hub central pour collecte et contrôle

**Livrables** :
- [ ] ESP32 serveur web
- [ ] Interface temps réel
- [ ] Enregistrement SD
- [ ] Télécommande tags/anchors
- [ ] Gestion multi-utilisateurs

**Statut** : 🟡 **EN COURS**

---

### Phase 3 : Application Desktop 📋

**Objectif** : Outils d'analyse post-course

**Livrables** :
- [ ] Application Electron/Qt
- [ ] Import données SD
- [ ] Graphiques interactifs
- [ ] Comparaisons multiples
- [ ] Export rapports

**Statut** : 📋 **PLANIFIÉ**

---

### Phase 4 : Cloud & Mobile 🔮

**Objectif** : Écosystème complet connecté

**Livrables** :
- [ ] Backend cloud (Node.js/Python)
- [ ] API REST publique
- [ ] App mobile (React Native)
- [ ] Synchronisation multi-devices
- [ ] Communauté en ligne

**Statut** : 🔮 **FUTUR**

---

## 💡 Principes de Conception

### 1. Fail-Safe

!!! danger "Sécurité Avant Tout"
    - Aucune perte de données en cas de coupure
    - Mode dégradé si composant défaillant
    - Watchdog timers sur tous les devices
    - Validation des données critiques

### 2. User-Centric

!!! info "Centré Utilisateur"
    - Interface intuitive (pas de manuel nécessaire)
    - Feedback immédiat des actions
    - Messages d'erreur clairs et actionnables
    - Workflow optimisé pour cas d'usage réels

### 3. Data-Driven

!!! note "Décisions Basées sur Données"
    - Logging exhaustif pour debug
    - Métriques performance collectées
    - Tests A/B pour UX
    - Feedback utilisateurs analysé

### 4. Scalable

!!! tip "Évolutivité"
    - Support 8 → 16 → 32 tags sans refonte
    - Architecture micro-services
    - APIs versionnées
    - Backward compatibility garantie

---

## 🎓 Apprentissages Clés

### Leçons du Développement

!!! success "Ce qui fonctionne bien"
    - Architecture modulaire avec LinkNodes
    - Calibration automatique anchors
    - Format JSON pour messages
    - PlatformIO pour multi-projets

!!! warning "Défis rencontrés"
    - Interférences WiFi sur circuit
    - Gestion mémoire limitée ESP32
    - Synchronisation temporelle
    - Switch mode Anchor/Tag délicat

!!! failure "Erreurs à éviter"
    - Code temporaire non nettoyé
    - Valeurs hardcodées (magic numbers)
    - Pas assez de logs pour debug
    - Manque tests unitaires

---

## 📞 Parties Prenantes

| Rôle | Nom | Responsabilité | Contact |
|------|-----|----------------|---------|
| **Product Owner** | Hugo | Vision produit, priorités | hugo@email.com |
| **Tech Lead** | TBD | Architecture, code reviews | - |
| **UX Designer** | TBD | Interface, expérience utilisateur | - |
| **Beta Testers** | Club RC Local | Tests terrain, feedback | - |
| **Communauté** | Open-Source | Contributions, support | GitHub |

---

## 🔄 Processus d'Amélioration Continue

```mermaid
graph LR
    A[Feedback Utilisateurs] --> B[Analyse Données]
    B --> C[Priorisation]
    C --> D[Développement]
    D --> E[Tests]
    E --> F[Déploiement]
    F --> G[Monitoring]
    G --> A
    
    style A fill:#e1f5fe
    style D fill:#fff3e0
    style F fill:#e8f5e9
```

### Cycle de Release

- **Sprints** : 2 semaines
- **Releases Minor** : Mensuelle
- **Releases Major** : Trimestrielle
- **Hotfixes** : Dès que nécessaire

---

<div style="text-align: center; margin-top: 50px;">
  <p><strong>Cette vision guide toutes nos décisions techniques et fonctionnelles.</strong></p>
  <p><em>Prochain chapitre : <a href="../planning/">Planification Détaillée</a></em></p>
</div>
