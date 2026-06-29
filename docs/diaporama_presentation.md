---
marp: true
theme: default
paginate: true
size: 16:9
header: "FitAI — Titre Professionnel CDA"
footer: "Loïc Botsy · StyleShop SAS · Juin 2026"
---

<style>
/* ── Palette ── */
:root {
  --primary:   #1a1a2e;
  --accent:    #6c63ff;
  --accent2:   #0ea5e9;
  --light:     #f8f9fe;
  --text:      #1e293b;
  --muted:     #64748b;
  --success:   #10b981;
  --danger:    #ef4444;
  --warning:   #f59e0b;
}

/* ── Base ── */
section {
  font-family: 'Segoe UI', system-ui, sans-serif;
  background: #ffffff;
  color: var(--text);
  font-size: 20px;
  padding: 48px 64px;
}

/* ── Titres ── */
h1 { color: var(--primary); font-size: 2em; margin-bottom: 0.2em; }
h2 { color: var(--primary); font-size: 1.5em; border-bottom: 3px solid var(--accent); padding-bottom: 6px; margin-bottom: 0.6em; }
h3 { color: var(--accent); font-size: 1.1em; margin: 0.4em 0; }

/* ── Code ── */
code { background: #f1f5f9; color: #0f172a; border-radius: 4px; padding: 1px 5px; font-size: 0.85em; }
pre  { background: #0f172a; border-radius: 10px; padding: 18px 22px; font-size: 0.72em; line-height: 1.55; box-shadow: 0 4px 16px rgba(0,0,0,0.18); }
pre code { background: transparent; color: #e2e8f0; }

/* ── Tableaux ── */
table { border-collapse: collapse; width: 100%; font-size: 0.82em; margin-top: 0.5em; }
th    { background: var(--primary); color: #fff; padding: 8px 12px; text-align: left; }
td    { padding: 7px 12px; border-bottom: 1px solid #e2e8f0; }
tr:nth-child(even) td { background: #f8fafc; }

/* ── Utilitaires ── */
.lead    { color: var(--accent); font-size: 1.15em; font-weight: 600; }
.muted   { color: var(--muted); font-size: 0.88em; }
.chip    { display: inline-block; background: var(--accent); color: #fff; border-radius: 20px; padding: 2px 12px; font-size: 0.8em; margin: 2px; }
.chip-ok { background: var(--success); }
.chip-warn { background: var(--warning); color: #000; }
.ok   { color: var(--success); font-weight: bold; }
.ko   { color: var(--danger);  font-weight: bold; }
.warn { color: var(--warning); font-weight: bold; }

/* ── Slide de titre ── */
section.title-slide {
  background: linear-gradient(135deg, #1a1a2e 60%, #16213e 100%);
  color: #ffffff;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
section.title-slide h1 { color: #ffffff; font-size: 2.6em; border: none; }
section.title-slide h2 { color: #a5b4fc; border: none; font-size: 1.3em; font-weight: 400; }
section.title-slide .meta { color: #cbd5e1; font-size: 0.9em; margin-top: 2em; }

/* ── Slide de section ── */
section.section-slide {
  background: linear-gradient(120deg, var(--accent) 0%, var(--accent2) 100%);
  color: #fff;
  display: flex; align-items: center; justify-content: center;
  text-align: center;
}
section.section-slide h2 { color: #fff; border: none; font-size: 2.2em; }
section.section-slide p  { color: #e0e7ff; font-size: 1.1em; }

/* ── Grilles ── */
.cols-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 32px; }
.cols-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; }
.card   { background: var(--light); border-radius: 10px; padding: 16px 20px; border-left: 4px solid var(--accent); }
.card h3 { margin-top: 0; }

/* ── Numéro de page ── */
section::after { color: var(--muted); font-size: 0.75em; }

/* ── Placeholder screenshot ── */
.screenshot {
  background: #e2e8f0;
  border: 2px dashed #94a3b8;
  border-radius: 10px;
  text-align: center;
  color: #64748b;
  font-size: 0.85em;
  padding: 20px;
  min-height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 1 — TITRE
     ═══════════════════════════════════════════════════════════ -->

<!-- _class: title-slide -->
<!-- _paginate: false -->
<!-- _header: "" -->
<!-- _footer: "" -->

# FitAI

## Application d'essayage virtuel de vêtements par Intelligence Artificielle

<div class="meta">

**Loïc Botsy** · Titre Professionnel Concepteur Développeur d'Applications (Niveau 6)
StyleShop SAS · Juin 2026

</div>

<!--
NOTES ORATEUR — Slide 1 [~30 secondes]

"Bonjour. Je m'appelle Loïc Botsy et je suis candidat au Titre Professionnel Concepteur Développeur d'Applications de niveau 6.

Durant ma période en entreprise chez StyleShop SAS, j'ai développé FitAI : une application mobile d'essayage virtuel de vêtements propulsée par l'intelligence artificielle.

Je vais vous présenter ce projet en une vingtaine de minutes, organisé en trois parties : la conception, la réalisation technique, puis une conclusion sur les principes de programmation orientée objet et les perspectives d'évolution."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 2 — ENTREPRISE
     ═══════════════════════════════════════════════════════════ -->

## StyleShop SAS — L'entreprise d'accueil

<div class="cols-2">

<div>

### Qui sont-ils ?

- **Startup française** fondée en 2022, Paris 11ème
- **Activité** : Marketplace de vêtements de mode en ligne
- **14 collaborateurs** — équipe tech de 6 personnes
- **CA 2025** : 1,2 M€ · **32 000** utilisateurs actifs
- Stack : Django (back) · Flutter (mobile) · AWS (infra)

### Mon rôle

**Stagiaire CDA — développeur full-stack**
Sous la supervision de **Thomas Dupont** (CTO)

</div>

<div>

```
Sophie Mercier — PDG
│
├── Thomas Dupont — CTO  ← tuteur
│   ├── 2× Back-end (Django)
│   ├── 1× Front-end (React)
│   ├── 1× DevOps (AWS)
│   └── Loïc Botsy (stagiaire)  ←
│
├── Juliette Arnaud — Produit
│   ├── Product Manager
│   └── UX Designer
│
└── Camille Renard — Commercial
```

</div>

</div>

<!--
NOTES ORATEUR — Slide 2 [~1 minute]

"StyleShop est une startup parisienne spécialisée dans la vente de vêtements de mode en ligne via une application mobile. Elle compte 14 collaborateurs dont une équipe technique de 6 personnes.

J'ai intégré cette équipe en tant que développeur full-stack, sous la supervision de Thomas Dupont, le CTO. Ma mission principale était de concevoir et développer la fonctionnalité d'essayage virtuel, de A à Z — du modèle de données Django aux écrans Flutter."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 3 — EXPRESSION DES BESOINS
     ═══════════════════════════════════════════════════════════ -->

## Expression des besoins — Le problème business

<div class="cols-2">

<div>

### Le problème identifié

> **35 %** des achats de vêtements en ligne sont retournés.
> Raison principale : *"Ce n'est pas ce que j'imaginais sur moi."*

**Impact business** :
- Coûts logistiques retours : ~15 €/colis
- Insatisfaction client · churn
- Empreinte carbone élevée

### La solution FitAI

L'utilisateur **visualise le vêtement porté sur sa propre photo** avant d'acheter.

</div>

<div>

### Besoins fonctionnels prioritaires

| ID | Fonctionnalité | Priorité |
|----|---------------|---------|
| F1 | Authentification sécurisée (JWT) | 🔴 Haute |
| F2 | Upload 2 photos + description | 🔴 Haute |
| F3 | Génération IA (30-90 s) | 🔴 Haute |
| F4 | Affichage sécurisé du résultat | 🔴 Haute |
| F5 | Historique des essayages | 🟡 Moyenne |
| F6 | Téléchargement / Partage | 🟡 Moyenne |

</div>

</div>

<!--
NOTES ORATEUR — Slide 3 [~1 min 30]

"Le problème que StyleShop m'a demandé de résoudre est très concret : 35% de leurs commandes sont retournées, principalement parce que les clients ne savent pas à quoi ressemblera le vêtement sur eux.

La solution est l'essayage virtuel : on demande à l'utilisateur de prendre deux photos — une d'eux-mêmes et une du vêtement — et on génère via intelligence artificielle une image réaliste du résultat en quelques dizaines de secondes.

Les fonctionnalités prioritaires ont été définies avec Sophie Mercier, la Product Owner, lors des sessions de backlog : l'authentification, le flux d'upload, la génération IA et l'accès sécurisé au résultat."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 4 — ARCHITECTURE TECHNIQUE
     ═══════════════════════════════════════════════════════════ -->

## Architecture technique — Vue globale

<div class="cols-2">

<div>

```
📱 Flutter 3 · Riverpod · GoRouter
     │
     │ HTTPS · Bearer JWT
     │ multipart/form-data
     ▼
⚙️  Django 5 · DRF · SimpleJWT
  ├─ /api/auth/    (register, login, refresh)
  ├─ /api/tryon/   (POST=créer, GET=lister)
  └─ /media/:path  (accès protégé JWT)
          │
          ├── ORM ──► 🗄️ PostgreSQL 15
          │           (users · tryon_requests)
          │
          └── Gradio ► 🤗 HuggingFace
                        IDM-VTON (IA)
                        ~30-90 s
```

**Architecture N-tiers** : présentation → API → service → persistance

</div>

<div>

### Justification des choix

| Choix | Alternative | Raison |
|-------|-------------|--------|
| **Flutter** | React Native | Stack existante StyleShop |
| **Django 5** | FastAPI | ORM + SimpleJWT intégrés |
| **PostgreSQL** | MySQL | UUID natif + ACID |
| **JWT stateless** | Sessions | Mobile multi-appareils |
| **IDM-VTON** | API payante | Budget startup (gratuit) |

### Modèle de déploiement

- **Backend** : conteneur Docker
- **Media** : volume persistant local → S3 (future)
- **IA** : HuggingFace Spaces (cloud)

</div>

</div>

<!--
NOTES ORATEUR — Slide 4 [~2 minutes]

"L'architecture est en 4 couches.

D'abord, le frontend mobile en Flutter 3 avec Riverpod pour la gestion d'état. Flutter a été choisi car c'est déjà le framework mobile de StyleShop — pas de changement de technologie pour l'équipe.

Au centre, l'API Django 5 avec Django REST Framework. Django a été privilégié à FastAPI pour son ORM puissant et pour l'intégration native de SimpleJWT — ce qui nous a économisé beaucoup de temps sur la partie authentification.

Pour la persistance, PostgreSQL 15 avec support natif des UUIDs. Et enfin, le modèle open-source IDM-VTON hébergé sur HuggingFace Spaces — gratuit et état de l'art pour le virtual try-on.

C'est une architecture N-tiers classique, avec une séparation nette des responsabilités à chaque couche."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 5 — MODÈLE DE DONNÉES
     ═══════════════════════════════════════════════════════════ -->

## Modèle de données — Entités et relations

<div class="cols-2">

<div>

### Diagramme Entité-Relation

```
┌────────────────┐           ┌───────────────────────┐
│     User       │  1 ──── N │    TryOnRequest        │
│────────────────│           │───────────────────────│
│ id         PK  │           │ id (UUID)          PK  │
│ username       │           │ user_id            FK  │
│ email          │           │ person_image           │
│ password (hash)│           │ garment_image          │
└────────────────┘           │ result_image           │
                              │ description            │
                              │ status  ──────────┐   │
                              │ created_at         │   │
                              └───────────────────┘   │
                                                   │
                              ┌────────────────────┘
                              │  Status <<enum>>
                              │  PENDING
                              │  PROCESSING
                              │  COMPLETED
                              │  FAILED
                              └────────────────
```

</div>

<div>

### Décisions de conception

**UUID comme clé primaire**
→ Non prédictible : impossible d'énumérer les ressources d'autrui (résistance BOLA)
→ Distribué : pas de contention sur auto-incrément

**Enum `Status`**
→ Machine à états explicite : transitions contrôlées
→ Traçabilité en base à chaque étape de la génération IA

**`on_delete=CASCADE` sur `user_id`**
→ Droit à l'effacement RGPD : suppression du compte → toutes les images supprimées automatiquement

**Séparation `person_image` / `garment_image` / `result_image`**
→ Validator MIME uniquement sur les entrées utilisateur, pas sur la sortie IA

</div>

</div>

<!--
NOTES ORATEUR — Slide 5 [~1 min 30]

"Le modèle de données ne comporte que deux tables principales : User, fournie par Django, et TryOnRequest, que j'ai créée.

Quatre décisions de conception méritent d'être expliquées.

Premièrement, l'UUID comme clé primaire. Contrairement à un entier auto-incrémenté, un UUID v4 est impossible à deviner — ce qui protège contre les attaques BOLA où un attaquant modifie l'identifiant dans une URL pour accéder aux ressources d'un autre utilisateur.

Deuxièmement, l'enum Status. Le cycle de vie d'un essayage passe par quatre états : PENDING à la création, PROCESSING pendant l'appel IA, COMPLETED en cas de succès, FAILED en cas d'erreur. C'est une machine à états explicite qui facilite le débogage et la traçabilité.

Troisièmement, la cascade de suppression sur la clé étrangère utilisateur — essentielle pour le RGPD.

Quatrièmement, la séparation des champs images : person et garment viennent de l'utilisateur et sont validés, result_image est générée par le backend et n'a pas besoin d'être validée."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 6 — DIAGRAMME DE CLASSES
     ═══════════════════════════════════════════════════════════ -->

## Conception OO — Principales classes et relations

<div class="cols-2">

<div>

### Côté Django (backend)

```
ModelViewSet (DRF)
    ▲
    │ héritage
TryOnViewSet
    │ utilise
    ├──► TryOnSerializer ──► (ModelSerializer)
    │
    └──► TryOnService
              │ lève
              └──► TryOnAPIException ──► (Exception)

ModelSerializer (DRF)
    ▲
TryOnSerializer
    │ appelle
    └──► validate_image_file()   (Validator)

ProtectedMediaView
    │ vérifie
    └──► JWT + chemin fichier ∈ dossier user
```

</div>

<div>

### Côté Flutter (frontend)

```
AsyncNotifier<AuthState> (Riverpod)
    ▲
    │ héritage
AuthNotifier
    │ utilise
    └──► ApiService (HTTP client)
              │
              └──► AuthInterceptor
                        │ gère
                        └──► refresh JWT automatique

AsyncNotifier<TryOnState> (Riverpod)
    ▲
    │ héritage
TryOnNotifier
    │ utilise
    └──► ApiService
```

**Pattern Repository** : `ApiService` isole Flutter de l'API HTTP

**Immutabilité** : `AuthState` et `TryOnState` sont des `data class` (Dart `sealed class`)

</div>

</div>

<!--
NOTES ORATEUR — Slide 6 [~1 min 30]

"Je vais vous présenter les principales classes de l'application et leurs relations.

Côté Django, l'architecture suit le pattern MVT de Django complété par une couche Service.

TryOnViewSet hérite de ModelViewSet de Django REST Framework — on récupère gratuitement les opérations CRUD, la pagination, et les codes HTTP corrects. Il utilise TryOnSerializer pour valider et sérialiser les données, et délègue la logique métier IA à TryOnService.

TryOnService est la classe la plus importante du backend : c'est elle qui encapsule toute l'interaction avec HuggingFace. Si demain on change de fournisseur IA, seule cette classe change.

Côté Flutter, j'ai utilisé le pattern Riverpod avec des AsyncNotifiers. AuthNotifier gère le cycle de vie du token JWT. TryOnNotifier gère l'état de la génération. Les deux passent par ApiService qui centralise la configuration HTTP — notamment l'injection automatique du Bearer token via l'AuthInterceptor."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 7 — FLUX MÉTIER / DIAGRAMME DE SÉQUENCE
     ═══════════════════════════════════════════════════════════ -->

## Flux métier — Diagramme de séquence : génération IA

<div class="cols-2">

<div>

```
Flutter      Django API      TryOnService    HuggingFace
  │               │               │               │
  │─── POST ─────►│               │               │
  │  /api/tryon/  │               │               │
  │  (2 images)   │               │               │
  │               │ validate()    │               │
  │               │ Sérialise     │               │
  │               │ INSERT PENDING│               │
  │               │               │               │
  │               │──generate()──►│               │
  │               │               │──predict()───►│
  │               │               │   ~30-90 s    │
  │               │               │◄──result[0]───│
  │               │               │               │
  │               │ save media/   │               │
  │               │ UPDATE COMPLETED               │
  │◄─ HTTP 201 ───│               │               │
  │  {result_url} │               │               │
  │               │               │               │
  │ navigate →    │               │               │
  │ ResultScreen  │               │               │
```

</div>

<div>

### Points de défaillance gérés

**Timeout HuggingFace** (cold start 90s)
→ Délai configuré à 300s (5 min)
→ Retour HTTP 502 + `request_id` si dépassé

**Erreur IA (quota, réseau)**
→ `TryOnAPIException` levée par le service
→ Statut `FAILED` enregistré en base
→ Message d'erreur retourné à Flutter

**Requête double (double tap)**
→ `AbsorbPointer` Flutter bloque toutes les interactions pendant la génération
→ Impossible de soumettre deux fois

### États de l'essayage

```
[PENDING] → [PROCESSING] → [COMPLETED]
                 │
                 └──────────► [FAILED]
```

</div>

</div>

<!--
NOTES ORATEUR — Slide 7 [~1 min 30]

"Le flux de génération est le cœur fonctionnel de l'application. Laissez-moi vous le décrire étape par étape.

Flutter envoie les deux images en multipart à l'API Django. Django valide les données via le serializer et les validators MIME, enregistre en base avec le statut PENDING, puis délègue à TryOnService.

TryOnService appelle synchroniquement HuggingFace via le client Gradio. C'est ici qu'on attend — entre 30 et 90 secondes selon l'état du modèle IDM-VTON.

Une fois le résultat reçu, Django sauvegarde l'image dans le dossier media, met à jour le statut en COMPLETED, et retourne l'URL de l'image à Flutter. Flutter navigue alors automatiquement vers l'écran ResultScreen.

Trois points de défaillance ont été anticipés : le timeout de HuggingFace géré à 300 secondes, les erreurs IA capturées et converties en exception typée, et la double soumission bloquée par AbsorbPointer côté Flutter."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 8 — GESTION DE PROJET
     ═══════════════════════════════════════════════════════════ -->

## Gestion de projet — Méthode Agile Scrum

<div class="cols-2">

<div>

### 6 sprints × 2 semaines

| Sprint | Focus | Dates |
|--------|-------|-------|
| S0 | Cadrage, maquettes Figma, setup | 7–18 avr. |
| S1 | Auth backend (JWT + profil) | 21 avr.–2 mai |
| S2 | API TryOn + intégration HuggingFace | 5–16 mai |
| S3 | Frontend Flutter (5 écrans) | 19–30 mai |
| S4 | Sécurité + Historique + Médias | 2–13 juin |
| S5 | Tests + Documentation + Recette | 16–27 juin |

### Outils

<span class="chip">GitHub</span>
<span class="chip">Figma</span>
<span class="chip">Insomnia</span>
<span class="chip">Jira</span>

</div>

<div>

### Gestion des risques identifiés

| Risque | Impact | Mitigation |
|--------|--------|-----------|
| Latence HuggingFace (30-90s) | UX dégradée | Indicateur de chargement + AbsorbPointer |
| Cold start IDM-VTON (90s) | Timeout réseau | Timeout 300s + HTTP 502 propre |
| Format Gradio non documenté | Blocage intégration | Lecture source HuggingFace Space |
| Permissions galerie iOS/Android | Comportement différent | Test sur 2 plateformes |
| Dépendance abandonnée (magic-bin) | Risque sécurité | Remplacement par `filetype` |

### Difficulté principale (Sprint 2)

Le paramètre `person` d'IDM-VTON attend un **dict `ImageEditor`**, pas une simple image — non documenté. Résolu après 2 jours d'analyse du code source du Space.

</div>

</div>

<!--
NOTES ORATEUR — Slide 8 [~1 min 30]

"J'ai conduit ce projet en méthode Agile Scrum avec 6 sprints de 2 semaines chacun.

Les trois premiers sprints ont posé les fondations : cadrage, authentification JWT, puis l'intégration HuggingFace. C'est pendant le sprint 2 que j'ai découvert la principale difficulté technique : le format d'appel du modèle IDM-VTON. La documentation Gradio était incomplète — le paramètre personne est un dictionnaire au format ImageEditor et non une simple image. J'ai dû lire le code source du Space HuggingFace pour comprendre le format attendu. C'est une leçon sur l'importance de tester les API tierces très tôt dans un projet.

Le sprint 3 a développé les 5 écrans Flutter. Le sprint 4 a renforcé la sécurité. Le sprint 5 a finalisé les tests et la documentation.

Les outils utilisés sont ceux de StyleShop : GitHub pour le versioning, Jira pour le suivi du backlog, Figma pour les maquettes, Insomnia pour tester l'API."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 9 — SÉCURITÉ OWASP
     ═══════════════════════════════════════════════════════════ -->

## Sécurité — Approche OWASP Top 10

<div class="cols-2">

<div>

| OWASP 2021 | Statut | Mesure appliquée |
|-----------|--------|-----------------|
| A01 — Access Control | <span class="ok">✅</span> | `filter(user=request.user)` · UUID non prédictible |
| A02 — Crypto Failures | <span class="ok">✅</span> | JWT HS256 · `FlutterSecureStorage` (keychain/keystore) |
| A03 — Injection | <span class="ok">✅</span> | ORM Django exclusivement (0 SQL brut) |
| A04 — Insecure Design | <span class="ok">✅</span> | Rate limiting 10 req/h · UUID |
| A05 — Misconfiguration | <span class="ok">✅</span> | `DEBUG=False` · `ALLOWED_HOSTS` strict |
| A07 — Auth Failures | <span class="ok">✅</span> | Access 15 min · Refresh 7 j · Refresh auto Flutter |
| A08 — Integrity | <span class="ok">✅</span> | Validation magic bytes (filetype) + taille 10 Mo |
| A09 — Logging | <span class="ok">✅</span> | Logger `tryon.services` INFO/ERROR structuré |
| A10 — SSRF | <span class="ok">✅</span> | URL HuggingFace codée en dur (pas d'entrée user) |

</div>

<div>

### Couches de protection

```
[Flutter]
  ├─ Stockage JWT chiffré (keystore/keychain)
  ├─ AbsorbPointer (anti double-submit)
  └─ Refresh automatique transparent

[API Django]
  ├─ Authentification JWT sur toutes routes
  ├─ Isolation par user (filter ORM)
  ├─ Rate limiting 10/h par user
  └─ Validation MIME magic bytes

[Modèle données]
  ├─ UUID (résistance BOLA)
  ├─ Cascade RGPD
  └─ Media protégée (ProtectedMediaView)
```

### A06 — Composants vulnérables

Veille active → CVE-2024-56374 Django (corrigée en 5.0.14)
Remplacement `python-magic-bin` → `filetype`

</div>

</div>

<!--
NOTES ORATEUR — Slide 9 [~1 min 30]

"La sécurité a été prise en compte dès la conception, pas ajoutée à la fin. Je vais vous montrer les trois couches de protection.

Côté Flutter, les tokens JWT sont stockés dans le keystore Android ou le keychain iOS — des espaces chiffrés par le système d'exploitation, contrairement à SharedPreferences qui est en clair.

Côté API Django, toutes les routes protégées filtrent les données par utilisateur authentifié. Le rate limiting limite chaque utilisateur à 10 générrations par heure. La validation MIME inspecte les magic bytes des fichiers.

Côté modèle, les UUIDs rendent l'énumération des ressources impossible. Le CASCADE garantit la suppression des données lors du droit à l'effacement RGPD. La ProtectedMediaView vérifie que le chemin demandé appartient bien à l'utilisateur connecté.

Sur les 10 risques OWASP 2021, 9 sont directement adressés dans le code."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 10 — VEILLE TECHNOLOGIQUE
     ═══════════════════════════════════════════════════════════ -->

## Veille technologique & sécurité

<div class="cols-2">

<div>

### Sources consultées

<span class="chip">CVE Mitre</span>
<span class="chip">OWASP News</span>
<span class="chip">PyPI Advisories</span>
<span class="chip">Django Security Blog</span>
<span class="chip">CERT-FR</span>
<span class="chip">GitHub Dependabot</span>
<span class="chip">PortSwigger Research</span>

### CVE identifiées et traitées

| CVE | Composant | Risque | Action |
|-----|----------|--------|--------|
| CVE-2024-56374 | Django < 5.0.11 | DoS | Mise à jour 5.0.14 ✅ |
| CVE-2024-3116 | pgAdmin < 8.6 | RCE | Mise à jour immédiate ✅ |

</div>

<div>

### Action majeure — Risque supply chain

**Problème détecté** :
`python-magic-bin` (bibliothèque de validation MIME)
→ Abandonnée depuis 2023
→ Encapsule une DLL `libmagic` v1.0.17 de **2009** (non patchée)
→ Fork suspect avec le même nom sur PyPI

**Risque** : DLL binaire non auditée + possible typosquatting

**Correction** :
Remplacement par `filetype`
→ Python pur, aucune dépendance binaire
→ Maintenus activement (v1.2+)
→ Résistance identique : lecture des magic bytes

<span class="chip chip-ok">0 dépendance binaire système</span>
<span class="chip chip-ok">Maintenu activement</span>

</div>

</div>

<!--
NOTES ORATEUR — Slide 10 [~1 minute]

"La veille sécurité repose sur 7 sources consultées entre hebdomadairement et mensuellement.

Deux CVE ont eu un impact direct.

La première, CVE-2024-56374, affecte Django avant la version 5.0.11. Notre projet utilise la 5.0.14 — correctif déjà inclus.

La deuxième, CVE-2024-3116, est une vulnérabilité critique dans pgAdmin permettant l'exécution de code arbitraire. Mise à jour immédiate.

L'action la plus significative reste le remplacement de python-magic-bin. Cette bibliothèque abandonnée encapsule une DLL binaire de 2009 — sans patches de sécurité depuis 17 ans. Un fork suspect avec le même nom circulait sur PyPI. J'ai remplacé par filetype, une bibliothèque Python pure, activement maintenue, avec une résistance équivalente — analyse des magic bytes pour détecter le spoofing d'extension."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SECTION — RÉALISATION TECHNIQUE
     ═══════════════════════════════════════════════════════════ -->

<!-- _class: section-slide -->
<!-- _paginate: false -->

## Réalisation technique

Démonstration des composants clés du code

<!--
NOTES ORATEUR — [~10 secondes]
"Passons maintenant à la réalisation technique avec trois extraits de code représentatifs."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 11 — INTERFACE FLUTTER — AUTH
     ═══════════════════════════════════════════════════════════ -->

## Interface Flutter — Authentification

<div class="cols-2">

<div>

<!-- INSÉRER : screenshot LoginScreen sur émulateur Android -->
<div class="screenshot" style="height: 320px; font-size: 1.1em;">
  📱 <strong>[CAPTURE D'ÉCRAN]</strong><br>
  Écran de Connexion<br>
  <small>Champs username + password<br>Bouton "Se connecter"<br>Lien "S'inscrire"</small>
</div>

<div class="muted" style="margin-top: 10px;">
Validation côté client avant envoi réseau
</div>

</div>

<div>

### `login_screen.dart` — Logique de connexion

```dart
Future<void> _submit() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Délègue au AuthNotifier (Riverpod)
      // → appel POST /api/auth/token/
      await ref.read(authProvider.notifier)
               .login(_usernameCtrl.text.trim(),
                      _passwordCtrl.text);

      // Succès → GoRouter vers '/home'
      if (mounted) context.go('/home');

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()),
          backgroundColor: Theme.of(context)
                             .colorScheme.error),
      );
    }
  }
}
```

**Token JWT stocké dans `FlutterSecureStorage`**
*(keychain iOS / keystore Android — chiffré OS)*

</div>

</div>

<!--
NOTES ORATEUR — Slide 11 [~1 min 30]

"L'écran de connexion illustre le pattern Provider de Riverpod.

La logique est propre : _submit() valide le formulaire côté client, puis délègue au AuthNotifier. C'est le notifier qui appelle l'API et met à jour l'état global de l'application. L'écran ne fait qu'observer et réagir.

Point de sécurité important : le token JWT n'est jamais stocké dans SharedPreferences, qui est en clair sur le système de fichiers Android. On utilise FlutterSecureStorage qui s'appuie sur le keystore Android et le keychain iOS — espaces chiffrés par le système d'exploitation.

L'intercepteur HTTP injecte automatiquement le Bearer token dans chaque requête suivante, et gère le refresh silencieux quand le token d'accès expire."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 12 — INTERFACE FLUTTER — TRYON
     ═══════════════════════════════════════════════════════════ -->

## Interface Flutter — Écran Try-On & Riverpod

<div class="cols-2">

<div>

<div class="screenshot" style="height: 160px;">
  📱 <strong>[CAPTURE]</strong> TryOnScreen vide<br>
  <small>Deux cartes "Appuyez pour sélectionner"</small>
</div>
<div class="screenshot" style="height: 130px; margin-top: 10px;">
  📱 <strong>[CAPTURE]</strong> Chargement IA<br>
  <small>CircularProgressIndicator + "Génération en cours…"</small>
</div>

</div>

<div>

### Gestion d'état — `TryOnNotifier`

```dart
// ref.listen réagit aux changements d'état
// sans logique dans build()
ref.listen<AsyncValue<TryOnState>>(
  tryOnProvider, (prev, next) {
    if (next.value?.errorMessage != null)
      ScaffoldMessenger.of(context)
        .showSnackBar(...);            // ← effet de bord

    if (next.value?.resultImageUrl != null
        && prev?.value?.resultImageUrl == null)
      context.push('/result');         // ← navigation
  }
);

// Bloque TOUTES les interactions pendant la génération
// → anti double-submit, anti-navigation accidentelle
return AbsorbPointer(
  absorbing: state.isLoading,
  child: /* Formulaire + bouton Générer */ ...
);
```

</div>

</div>

<!--
NOTES ORATEUR — Slide 12 [~1 min 30]

"L'écran TryOn présente deux cartes de sélection d'image — photo de l'utilisateur et photo du vêtement — et un bouton Générer.

Deux patterns techniques importants.

Premier : le ref.listen. En Riverpod, l'idée est de ne jamais mettre de logique impérative — navigation, SnackBars — dans la méthode build. On utilise ref.listen pour réagir aux changements d'état et déclencher ces effets de bord. Ici, on navigue vers ResultScreen quand resultImageUrl passe de null à une URL valide, et on affiche une SnackBar rouge si errorMessage est renseigné.

Deuxième : l'AbsorbPointer. Pendant les 30 à 90 secondes de génération IA, l'utilisateur ne doit pas pouvoir interagir — pas de double-clic sur Générer, pas de navigation accidentelle. L'AbsorbPointer bloque physiquement tous les events tactiles sur l'arbre de widgets enfant."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 13 — BACKEND DJANGO + JEUX D'ESSAI
     ═══════════════════════════════════════════════════════════ -->

## Backend Django — Code clé & Jeu d'essai

<div class="cols-2">

<div>

### `services.py` + `validators.py`

```python
class TryOnService:
    SPACE_ID = "yisol/IDM-VTON"

    @classmethod
    def generate_tryon(cls, person_path,
                       garment_path, description):
        try:
            client = Client(cls.SPACE_ID,
              httpx_kwargs={"timeout": 300})
            result = client.predict(
              {"background": handle_file(person_path),
               "layers": [], "composite": None},
              handle_file(garment_path),
              description, True, False, 30, 42,
              api_name="/tryon"
            )
            return result[0]
        except Exception as exc:
            raise TryOnAPIException(str(exc))

# Validation magic bytes (résiste au spoofing)
def validate_image_file(file):
    file.seek(0); header = file.read(2048); file.seek(0)
    kind = filetype.guess(header)
    mime = kind.mime if kind else 'unknown'
    if mime not in ['image/jpeg','image/png','image/webp']:
        raise ValidationError(f"Type invalide : {mime}")
```

</div>

<div>

### Jeu d'essai — 8 cas de test

| N° | Scénario | Résultat attendu | Statut |
|----|---------|-----------------|--------|
| T01 | Inscription valide | HTTP 201 | <span class="ok">✅</span> |
| T02 | Connexion JWT | HTTP 200 + tokens | <span class="ok">✅</span> |
| T03 | PDF renommé en .jpg | HTTP 400 MIME | <span class="ok">✅</span> |
| T04 | 11ème requête en 1h | HTTP 429 + Retry-After | <span class="ok">✅</span> |
| T05 | Isolation user1/user2 | Liste vide user2 | <span class="ok">✅</span> |
| T06 | Accès fichier autre user | HTTP 403 | <span class="ok">✅</span> |
| T07 | Route sans token | HTTP 401 | <span class="ok">✅</span> |
| T08 | Token expiré (Flutter) | Refresh auto · 0 erreur | <span class="ok">✅</span> |

<span class="chip chip-ok">8/8 — 100 % conformes</span>

</div>

</div>

<!--
NOTES ORATEUR — Slide 13 [~2 minutes]

"Je vais présenter deux composants backend puis commenter le jeu d'essai.

TryOnService encapsule l'appel Gradio. Le point technique clé : le paramètre person n'est pas une image directe mais un dictionnaire au format ImageEditor — background, layers, composite — c'est ce que j'ai découvert après 2 jours d'analyse du code source HuggingFace.

Le validator MIME lit les magic bytes du fichier. Un PDF renommé en .jpg commence toujours par les bytes 25 50 44 46 — impossible à masquer. La bibliothèque filetype le détecte malgré l'extension et le Content-Type HTTP falsifiés.

Sur le jeu d'essai, je vais commenter trois tests. T03 : j'ai pris un vrai PDF, renommé en photo.jpg, envoyé avec Content-Type image/jpeg. Résultat : HTTP 400 avec le message 'Type invalide : application/pdf'. T04 : après 10 requêtes, la 11ème reçoit un 429 avec le header Retry-After à 3600 secondes. T08, le plus intéressant : j'ai réduit l'ACCESS_TOKEN_LIFETIME à 1 seconde pour simuler l'expiration. L'AuthInterceptor a détecté le 401, refreshé automatiquement, et rejoué la requête sans que l'utilisateur ne voie rien."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SECTION — CONCLUSION & PERSPECTIVES
     ═══════════════════════════════════════════════════════════ -->

<!-- _class: section-slide -->
<!-- _paginate: false -->

## Conclusion & Perspectives

Programmation orientée objet et évolutions futures

<!--
NOTES ORATEUR — [~10 secondes]
"Pour conclure, je vais revenir sur les principes de programmation orientée objet appliqués dans ce projet, puis sur les axes d'évolution."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 14 — POO DANS FITAI
     ═══════════════════════════════════════════════════════════ -->

## Programmation Orientée Objet dans FitAI

<div class="cols-2">

<div>

### Les 4 piliers appliqués

<div class="card" style="margin-bottom: 12px;">

### 🔒 Encapsulation
`TryOnService` cache toute la complexité HuggingFace.
La vue Django appelle `generate_tryon()` sans savoir comment l'IA est interrogée.
→ Changement de fournisseur IA : **une seule classe à modifier**

</div>

<div class="card" style="margin-bottom: 12px;">

### 🧬 Héritage
`TryOnViewSet` ← `ModelViewSet` (DRF) : CRUD + pagination gratuits
`TryOnSerializer` ← `ModelSerializer` : validation + sérialisation automatiques
`TryOnNotifier` ← `AsyncNotifier<TryOnState>` (Flutter/Riverpod)

</div>

</div>

<div>

<div class="card" style="margin-bottom: 12px;">

### 🔄 Polymorphisme
**Exceptions typées** : `TryOnAPIException` étend `Exception`
→ `except TryOnAPIException` vs `except Exception` : traitement différencié selon l'origine de l'erreur (IA vs code interne)
**Serializers** : redéfinition de `validate()` et `create()` pour la logique métier FitAI

</div>

<div class="card">

### 🪟 Abstraction
Architecture en couches : **Vue → Serializer → Service → ORM → DB**
Chaque couche expose une interface sans révéler son implémentation.
Flutter ignore la structure interne de Django.
Django ignore que Flutter appelle via HTTP.
IDM-VTON ignore la logique métier de StyleShop.

</div>

</div>

</div>

<!--
NOTES ORATEUR — Slide 14 [~1 min 30]

"Je vais maintenant revenir sur comment les quatre piliers de la programmation orientée objet se retrouvent concrètement dans FitAI.

L'encapsulation est le principe le plus visible dans TryOnService. La vue Django appelle generate_tryon avec les chemins de fichiers et reçoit un chemin de fichier en retour. Elle ignore totalement comment HuggingFace est appelé, quel format Gradio est utilisé, quel timeout est configuré. Si demain on passe d'IDM-VTON à un autre modèle, seule la classe TryOnService change — la vue et le serializer ne bougent pas.

L'héritage est omniprésent avec Django REST Framework. TryOnViewSet hérite de ModelViewSet et reçoit gratuitement toutes les opérations CRUD, la pagination, les codes HTTP corrects. On n'écrit que les personnalisations nécessaires — get_queryset pour filtrer par utilisateur.

Le polymorphisme se manifeste dans les exceptions typées : en attrapant TryOnAPIException séparément d'Exception, on peut retourner un HTTP 502 quand c'est l'IA qui est en faute, et un 500 quand c'est notre code.

L'abstraction est le principe architectural fondateur : chaque couche a un contrat clair avec la couche voisine, sans connaître les détails d'implémentation."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 15 — PERSPECTIVES ET ÉVOLUTIONS
     ═══════════════════════════════════════════════════════════ -->

## Perspectives — Évolutions futures de FitAI

<div class="cols-3">

<div class="card">

### Court terme
*Production-ready*

- **Redis** : rate limiting partagé entre workers (Django-ratelimit nécessite Redis en multi-process)
- **Celery + Redis** : passer l'appel HuggingFace en asynchrone — Django rend la main immédiatement, Flutter poll le statut
- **S3 AWS** : remplacer le stockage fichier local par un bucket S3 (scalabilité, durabilité)
- **HTTPS + HSTS** : certificat TLS obligatoire avant mise en production

</div>

<div class="card">

### Moyen terme
*Qualité & UX*

- **WebSocket** : notification temps réel à Flutter en fin de génération IA — supprime le besoin de polling
- **Tests iOS** : validation des permissions galerie (comportement différent d'Android)
- **Redirection auto** vers login si token de refresh expiré
- **Historique filtrable** : tri par date, recherche par description
- **Partage social** : export image résultat vers les réseaux

</div>

<div class="card">

### Long terme
*Valeur métier*

- **IA self-hosted** : déployer IDM-VTON sur AWS SageMaker ou RunPod — supprimer la dépendance HuggingFace et les latences de cold start
- **Recommandation** : moteur ML suggérant des vêtements du catalogue StyleShop selon le morphotype
- **Try-on multi-vêtements** : assembler haut + bas + accessoires en une seule génération
- **Intégration catalogue** : lien direct produit → achat depuis l'écran résultat

</div>

</div>

<!--
NOTES ORATEUR — Slide 15 [~1 min 30]

"Je distingue trois horizons d'évolution.

À court terme, les améliorations de robustesse pour la mise en production. La plus urgente est Celery : aujourd'hui Django est bloqué pendant 30 à 90 secondes par requête IA, ce qui n'est pas scalable. Avec Celery, Django lance la tâche en background et retourne immédiatement un identifiant de tâche à Flutter. Flutter interroge périodiquement le statut — et à terme, on peut même remplacer ce polling par une connexion WebSocket.

À moyen terme, la qualité UX. Les WebSockets élimineraient le polling. Les tests iOS sont prioritaires car les permissions de galerie se comportent différemment de Android.

À long terme, les évolutions à haute valeur métier. Héberger IDM-VTON en propre sur AWS SageMaker supprimerait les latences de cold start et la dépendance à HuggingFace. Le moteur de recommandation permettrait de passer de 'essayer un vêtement' à 'découvrir ce qui me convient' — un changement de paradigme pour StyleShop."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 16 — MERCI
     ═══════════════════════════════════════════════════════════ -->

<!-- _paginate: false -->

<br>

<div style="text-align: center; margin-top: 48px;">

## FitAI — Bilan

<div class="cols-3" style="margin: 32px 0; text-align: left;">

<div class="card">

### ✅ Livré
- 5 écrans Flutter fonctionnels
- API REST 8 endpoints sécurisés
- Intégration IA IDM-VTON
- Sécurité OWASP 9/10
- 8/8 cas de test conformes

</div>

<div class="card">

### 🎓 Appris
- Architecture N-tiers en conditions réelles
- OO appliqué à Django + Flutter
- Gestion du risque supply chain
- Contraintes IA (latence, format API)
- Veille CVE et audits de dépendances

</div>

<div class="card">

### 🚀 Prochaine étape
- Celery async (priorité 1)
- Redis rate limiting
- AWS S3 media
- IA self-hosted (long terme)

</div>

</div>

### Merci pour votre attention — Questions ?

<span class="muted">Loïc Botsy · loic.botsy@hotmail.com · GitHub privé StyleShop · MSP1_BL</span><br>
<span class="muted">Stack : Flutter 3 · Django 5 · PostgreSQL 15 · HuggingFace IDM-VTON</span>

</div>

<!--
NOTES ORATEUR — Slide 16 [~30 secondes]

"Pour conclure : FitAI est une application mobile fonctionnelle qui répond au besoin de StyleShop — réduire les retours en permettant l'essayage virtuel. Elle applique les principes de la programmation orientée objet à travers une architecture N-tiers propre, avec une attention particulière à la sécurité.

Les principaux apprentissages sont l'application concrète des 4 piliers OO dans un projet full-stack, la gestion des dépendances et de la veille CVE, et la complexité réelle de l'intégration d'une API IA non documentée.

Je suis maintenant disponible pour vos questions."

─────────────────────────────────────────────────
TIMING GLOBAL (objectif ~20 min)
─────────────────────────────────────────────────
Slide  1 — Titre              :  0:30
Slide  2 — Entreprise         :  1:00
Slide  3 — Besoins            :  1:30
Slide  4 — Architecture       :  2:00
Slide  5 — Modèle données     :  1:30
Slide  6 — Diag. classes      :  1:30
Slide  7 — Flux métier        :  1:30
Slide  8 — Gestion projet     :  1:30
Slide  9 — Sécurité OWASP     :  1:30
Slide 10 — Veille             :  1:00
Section — Réalisation         :  0:10
Slide 11 — Flutter Auth       :  1:30
Slide 12 — Flutter TryOn      :  1:30
Slide 13 — Backend + tests    :  2:00
Section — Conclusion          :  0:10
Slide 14 — POO                :  1:30
Slide 15 — Perspectives       :  1:30
Slide 16 — Merci              :  0:30
─────────────────────────────────────
TOTAL                         : ~22:00 min
─────────────────────────────────────

RÉPARTITION CONCEPTUEL / CODE :
• Slides 2-10 (conceptuel)  : 9 slides — 69 %
• Slides 11-13 (code/demo)  : 3 slides — 23 %
• Slides 14-15 (POO/futur)  : 2 slides — 15 %
• Section dividers + titre/merci : neutres
─────────────────────────────────────
-->
