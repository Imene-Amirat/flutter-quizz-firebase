# 📱 TP Flutter & Firebase — Quiz Culture

## 🎯 Objectif du TP

Ce travail pratique a pour objectif de se familiariser avec le développement
d’une application mobile avec **Flutter**, en exploitant plusieurs services
de **Firebase**, ainsi qu’une solution de gestion d’état (**Provider**).

L’application réalisée est un **quiz de culture générale**, permettant
l’authentification des utilisateurs, la gestion dynamique des questions,
et l’utilisation de contenus multimédias stockés dans le cloud.

---

## 📸 Snapshots et preuves

![alt text](<WhatsApp Image 2025-12-23 at 7.09.36 PM.jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (1).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (2).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (3).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (4).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (5).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM (6).jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.13 PM.jpeg>) ![alt text](<WhatsApp Image 2025-12-23 at 10.48.14 PM.jpeg>)

---

## 🧩 Fonctionnalités principales

- 🔐 Authentification utilisateur (Email / Mot de passe)
- 🏠 Écran d’accueil personnalisé
- 🧠 Quiz de culture générale dynamique
- ➕ Ajout de nouvelles questions
- 👤 Avatar utilisateur (image uploadée)
- ☁️ Stockage et récupération des données via Firebase

---

## 🛠️ Technologies utilisées

- **Flutter**
- **Firebase Authentication**
- **Cloud Firestore**
- **Firebase Storage**
- **Provider** (gestion d’état)
- **Dart**

---

## 🏗️ Architecture du projet

L’application suit une architecture modulaire avec séparation des responsabilités :

lib/
├── data/
│ ├── models/
│ └── repositories/
├── business_logic/
│ └── providers/
└── presentation/
├── screens/
└── theme/

- **Repositories** : accès aux services Firebase
- **Providers** : gestion de l’état global
- **Screens** : interface utilisateur
- **Theme** : styles et couleurs de l’application

---

## 🔐 Question 2 — Firebase Authentication

L’authentification est implémentée à l’aide de **Firebase Authentication**
avec le fournisseur **Email / Mot de passe**.

### Fonctionnalités :

- inscription d’un utilisateur
- connexion sécurisée
- gestion de la session utilisateur
- déconnexion

Deux écrans ont été développés :

- `LoginScreen`
- `RegisterScreen`

---

## 🗃️ Question 1 — Cloud Firestore (Quiz Culture)

Les questions du quiz sont stockées dynamiquement dans **Cloud Firestore**.

### Modélisation des données

Collection : `questions`

Chaque document contient :

- `theme` : thématique de la question
- `question` : énoncé
- `answers` : liste des réponses possibles
- `correctIndex` : index de la réponse correcte (0–3)

### Fonctionnalités :

- récupération des questions depuis Firestore
- filtrage par thématique (Culture)
- affichage dynamique dans l’interface
- calcul du score
- réinitialisation du quiz
- ajout de nouvelles questions via un formulaire dédié

---

## 🖼️ Question 3 — Firebase Storage

**Firebase Storage** est utilisé pour stocker des fichiers multimédias.

### Fonctionnalités :

- sélection d’une image depuis la galerie
- upload de l’avatar utilisateur
- stockage dans le dossier `avatars/<uid>.jpg`

Un bouton interactif permet à l’utilisateur de modifier son avatar depuis l’écran d’accueil.

---

## 🎨 Interface utilisateur (UI/UX)

L’interface adopte une identité visuelle cohérente basée sur une **palette bordeaux**.
Des cartes arrondies, des icônes et des feedbacks visuels ont été intégrés
afin d’améliorer l’expérience utilisateur.

---

## 🎬 Démonstration

Une vidéo de démonstration accompagne ce projet et présente :

1. l’authentification utilisateur
2. l’écran d’accueil
3. le déroulement du quiz
4. l’ajout d’une question
5. la modification de l’avatar
