#!/bin/bash

# Script d'installation automatique pour la documentation MkDocs
# Usage: ./setup.sh

set -e

echo "=========================================="
echo "Installation Documentation MkDocs"
echo "=========================================="
echo ""

# Vérifier Python
echo "📦 Vérification de Python..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 n'est pas installé."
    echo "   Installer avec : sudo apt install python3 python3-pip"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d ' ' -f 2)
echo "✅ Python $PYTHON_VERSION trouvé"
echo ""

# Vérifier pip
echo "📦 Vérification de pip..."
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 n'est pas installé."
    echo "   Installer avec : sudo apt install python3-pip"
    exit 1
fi

echo "✅ pip trouvé"
echo ""

# Installer MkDocs et plugins
echo "📥 Installation de MkDocs et plugins..."
echo ""

pip3 install --upgrade pip

echo "   → MkDocs Material..."
pip3 install mkdocs-material

echo "   → Plugin PlantUML..."
pip3 install mkdocs-plantuml-plugin

echo "   → Plugin Git Revision Date..."
pip3 install mkdocs-git-revision-date-localized-plugin

echo ""
echo "✅ Installation terminée !"
echo ""

# Vérifier installation
echo "🔍 Vérification de l'installation..."
mkdocs --version
echo ""

# Proposer de lancer le serveur
echo "=========================================="
echo "Installation réussie ! 🎉"
echo "=========================================="
echo ""
echo "Pour lancer le serveur de développement :"
echo ""
echo "  cd \"$(pwd)\""
echo "  mkdocs serve"
echo ""
echo "Puis ouvrir http://127.0.0.1:8000 dans votre navigateur."
echo ""

read -p "Voulez-vous lancer le serveur maintenant ? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🚀 Lancement du serveur..."
    echo "   Appuyez sur Ctrl+C pour arrêter"
    echo ""
    mkdocs serve
fi
