# Fiche de notes orateur — Mots-clés
> Format : idées à évoquer dans l'ordre. Une ligne = un point à aborder.

---

## SLIDE 1 — TITRE [30 s]

- Loïc Botsy, candidat **CDA niveau 6**
- Projet : **FitAI** = essayage virtuel vêtements par IA
- Plan : **3 parties** → conception / réalisation / conclusion POO + perspectives

---

## SLIDE 2 — ENTREPRISE [1 min]

- Startup Paris 11e, 2022 · **14 collab**, 6 tech · **1,2 M€ CA**
- Stack : Django / Flutter / AWS → **déjà en place** = contrainte tech
- Mon rôle : **full-stack stagiaire**, tuteur **Thomas Dupont (CTO)**
- Mission : FitAI de **A à Z** — modèle de données → écrans Flutter

---

## SLIDE 3 — BESOINS [1 min 30]

- **35 % des commandes retournées** → "pas ce que j'imaginais sur moi"
- Coût : **~15 €/retour** + churn + empreinte carbone
- Solution : **2 photos** (soi + vêtement) → image générée par IA
- 4 fonctionnalités **haute priorité** : auth JWT, upload, génération IA, affichage sécurisé
- Priorité moyenne : historique, partage (phase 2)

---

## SLIDE 4 — ARCHITECTURE [2 min]

- Architecture **N-tiers** : 4 couches séparées
- **Flutter 3** → déjà stack StyleShop, Riverpod état réactif, GoRouter navigation
- **Django 5 + DRF** → ORM (0 SQL brut) + SimpleJWT intégré → gain de temps
- **PostgreSQL 15** → standard StyleShop, UUID natif, ACID
- **IDM-VTON / HuggingFace** → open-source, **gratuit** (contrainte budget startup)
- Communication via **client Gradio**, timeout **300 s**

---

## SLIDE 5 — MODÈLE DE DONNÉES [1 min 30]

- 2 tables : `User` (Django natif) + `TryOnRequest` → **relation 1:N**
- **UUID PK** → non prédictible → résistance **BOLA** (énumération impossible)
- **Enum Status** → machine à états : PENDING → PROCESSING → COMPLETED / FAILED → traçabilité
- **CASCADE** sur `user_id` → droit à l'**effacement RGPD** automatique
- `person_image` / `garment_image` → **validator MIME** car entrée user
- `result_image` → **pas de validator** car sortie backend (non contrôlable par user)

---

## SLIDE 6 — DIAGRAMME DE CLASSES [1 min 30]

**Côté Django :**
- `TryOnViewSet` ← `ModelViewSet` → CRUD + pagination + HTTP codes **gratuits**
- `TryOnSerializer` ← `ModelSerializer` → validation + JSON **automatiques**
- `TryOnService` → **encapsule HuggingFace** · changer d'IA = changer 1 classe
- `TryOnAPIException` ← `Exception` → distinguer erreur IA vs erreur interne

**Côté Flutter :**
- `AuthNotifier` ← `AsyncNotifier<AuthState>` (Riverpod)
- `TryOnNotifier` ← `AsyncNotifier<TryOnState>` (Riverpod)
- `ApiService` → centralise HTTP · `AuthInterceptor` → inject Bearer + refresh auto
- **Pattern Repository** : Flutter ignore tout de Django

---

## SLIDE 7 — FLUX MÉTIER [1 min 30]

**Chemin nominal :**
1. Flutter → `POST /api/tryon/` multipart + JWT
2. Django → valide (serializer + MIME) → INSERT **PENDING**
3. Django → `TryOnService.generate_tryon()` → Gradio → HuggingFace **30-90 s**
4. Django → save media/ → UPDATE **COMPLETED** → HTTP 201 + URL
5. Flutter → navigate **ResultScreen**

**3 points de défaillance :**
- **Timeout** → 300 s → HTTP **502** + request_id traçabilité
- **Erreur IA** (quota, réseau) → TryOnAPIException → statut FAILED → message à Flutter
- **Double submit** → **AbsorbPointer** `absorbing: isLoading` → bloque TOUS les events tactiles

---

## SLIDE 8 — GESTION DE PROJET [1 min 30]

- **6 sprints × 2 semaines** : cadrage → auth → API IA → Flutter → sécu → tests
- Outils : **GitHub** · **Jira** · **Figma** (maquettes) · **Insomnia** (tests API)
- **Difficulté principale Sprint 2** : format IDM-VTON non documenté
  - `person` = **dict `ImageEditor`** `{background, layers, composite}` (pas une image directe)
  - **2 jours** d'analyse code source HuggingFace Space
  - Leçon : **tester les API tierces dès le début**
- Risques gérés : latence (indicateur chargement) · cold start (timeout 300 s) · supply chain (remplacement filetype)

---

## SLIDE 9 — SÉCURITÉ OWASP [1 min 30]

**3 couches de protection :**

**Flutter**
- JWT → **`FlutterSecureStorage`** (keystore Android / keychain iOS) ≠ SharedPreferences (clair)
- **AuthInterceptor** → inject Bearer + refresh **silencieux** sur 401

**API Django**
- Toutes routes protégées → `filter(user=request.user)` → **isolation stricte**
- **Rate limiting** 10 req/h par user
- **Validation MIME** magic bytes (pas Content-Type : falsifiable)

**Modèle**
- **UUID** → résistance BOLA
- **CASCADE** → RGPD
- `ProtectedMediaView` → vérifie chemin ∈ dossier de l'user connecté

→ **9/10 risques OWASP** adressés dans le code

---

## SLIDE 10 — VEILLE [1 min]

- 7 sources : CVE Mitre · OWASP · PyPI · Django Blog · CERT-FR · Dependabot · PortSwigger
- **CVE-2024-56374** Django < 5.0.11 → DoS → on est en **5.0.14** (corrigé) → leçon : épingler versions
- **CVE-2024-3116** pgAdmin < 8.6 → **RCE** → mise à jour immédiate
- **Action majeure — supply chain :**
  - `python-magic-bin` : **abandonnée 2023** · DLL 2009 non patchée · fork suspect PyPI
  - Remplacée par **`filetype`** : Python pur · maintenu · résistance identique (magic bytes)

---

## [INTERLUDE] RÉALISATION TECHNIQUE [10 s]

*→ "Passons à la réalisation technique."*

---

## SLIDE 11 — FLUTTER AUTH [1 min 30]

- **Delegation** : `_submit()` → valide formulaire → délègue à **`AuthNotifier`**
- L'écran **n'a aucune logique métier** → observe et réagit seulement
- JWT stocké dans **`FlutterSecureStorage`** (keystore/keychain OS chiffré) ≠ SharedPreferences
- **`AuthInterceptor`** : inject Bearer + détecte 401 → **refresh auto** → rejoue requête → 0 erreur visible

---

## SLIDE 12 — FLUTTER TRYON [1 min 30]

- **`ref.listen`** : réagir aux changements d'état **hors du `build`**
  - `resultImageUrl` : null → URL → **navigate ResultScreen**
  - `errorMessage` → **SnackBar rouge**
- **`AbsorbPointer`** `absorbing: state.isLoading`
  - Bloque **tous les events tactiles** pendant la génération (30-90 s)
  - Plus robuste qu'un bouton désactivé : protège aussi la navigation et le reste de l'écran

---

## SLIDE 13 — BACKEND + JEU D'ESSAI [2 min]

**`TryOnService`**
- Paramètre `person` = **dict `ImageEditor`** `{background, layers: [], composite: None}` → non documenté
- Timeout **300 s** → marges cold start IDM-VTON
- `except Exception → raise TryOnAPIException` → traitement différencié dans la vue

**`validate_image_file`**
- Lit les **magic bytes** (premiers octets) → signature binaire indépendante de l'extension
- `filetype.guess()` → `mime` → refus si pas `jpeg / png / webp`
- Résiste au spoofing : PDF renommé `.jpg` + `Content-Type: image/jpeg` → détecté **application/pdf**

**Jeu d'essai — 3 cas à commenter :**
- **T03** : PDF → .jpg → **HTTP 400** "Type invalide : application/pdf" ✅
- **T04** : 11ème requête → **HTTP 429** + `Retry-After: 3600` ✅
- **T08** : token expiré → **refresh auto** → requête rejouée → **0 erreur visible** ✅ (8/8 conformes)

---

## [INTERLUDE] CONCLUSION & PERSPECTIVES [10 s]

*→ "Conclusion sur la POO et les perspectives."*

---

## SLIDE 14 — POO DANS FITAI [1 min 30]

**Encapsulation**
- `TryOnService` cache toute la complexité HuggingFace
- Vue Django appelle `generate_tryon()` → ignore Gradio, format, timeout
- Changer d'IA = **modifier 1 seule classe**

**Héritage**
- `TryOnViewSet` ← `ModelViewSet` → **CRUD + pagination gratuits**
- `TryOnSerializer` ← `ModelSerializer` → **validation + JSON automatiques**
- `TryOnNotifier` ← `AsyncNotifier<TryOnState>` → redéfinit `build()` uniquement

**Polymorphisme**
- `TryOnAPIException` vs `Exception` → traitement différencié : **HTTP 502** (IA) vs **500** (code)
- Serializers DRF : redéfinition de `validate()` et `create()`

**Abstraction**
- Couches : Vue → Serializer → Service → ORM → DB
- **Flutter ignore Django · Django ignore HTTP · IDM-VTON ignore la logique StyleShop**
- Chaque couche = contrat d'interface, implémentation cachée

---

## SLIDE 15 — PERSPECTIVES [1 min 30]

**Court terme — Production-ready**
- **Celery** (priorité 1) : appel IA async → Django rend la main immédiatement + Flutter poll statut
- **Redis** : rate limiting partagé multi-workers (nécessaire dès 2 processus)
- **S3 AWS** : remplace stockage local (scalabilité + durabilité)
- **HTTPS + HSTS** : obligatoire avant production

**Moyen terme — UX & qualité**
- **WebSocket** : remplace polling → Django notifie Flutter en temps réel
- **Tests iOS** : permissions galerie différentes d'Android
- **Redirect auto** vers login si refresh expiré
- **Historique filtrable**, partage social

**Long terme — Valeur métier**
- **IA self-hosted** (SageMaker / RunPod) → 0 cold start · 0 dépendance HuggingFace
- **Moteur de recommandation** : morphotype → suggestion catalogue StyleShop
- **Try-on multi-vêtements** : haut + bas + accessoires en 1 génération
- Lien résultat → **achat direct** produit StyleShop

---

## SLIDE 16 — MERCI [30 s]

- FitAI : **fonctionnel**, répond au besoin StyleShop (retours -35%)
- **POO** : 4 piliers appliqués concrètement (encapsulation, héritage, polymorphisme, abstraction)
- **Sécurité** : 9/10 OWASP · 8/8 tests conformes
- Apprentissage principal : POO full-stack + veille CVE + API IA non documentée
- → **"Je suis disponible pour vos questions."**
