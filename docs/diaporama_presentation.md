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

Je vais vous présenter ce projet en une quinzaine de minutes, puis je serai disponible pour répondre à vos questions."
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
     SLIDE 4 — ARCHITECTURE
     ═══════════════════════════════════════════════════════════ -->

## Architecture technique — Choix et justifications

<div class="cols-2">

<div>

```
📱 Flutter 3 · Riverpod · GoRouter
     │
     │ HTTP Bearer JWT
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

</div>

<div>

### Pourquoi ces technologies ?

| Choix | Alternative écartée | Raison |
|-------|-------------------|--------|
| **Flutter** | React Native | Déjà utilisé chez StyleShop |
| **Django 5** | FastAPI | ORM + SimpleJWT intégrés |
| **PostgreSQL** | MySQL | UUID natif + ACID |
| **JWT** | Sessions | Mobile stateless |
| **IDM-VTON** | API payante | Budget startup (gratuit) |

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 4 [~2 minutes]

"L'architecture est en 4 couches.

D'abord, le frontend mobile en Flutter 3 avec Riverpod pour la gestion d'état. Flutter a été choisi car c'est déjà le framework mobile de StyleShop — pas de changement de technologie pour l'équipe.

Au centre, l'API Django 5 avec Django REST Framework. Django a été privilégié à FastAPI pour son ORM puissant et pour l'intégration native de SimpleJWT — ce qui nous a économisé beaucoup de temps sur la partie authentification.

Pour la persistance, PostgreSQL 15 — le standard de StyleShop en production, avec un support natif des UUIDs utilisés comme clés primaires.

Et enfin, la brique d'intelligence artificielle : le modèle open-source IDM-VTON hébergé sur HuggingFace Spaces. C'est un modèle de diffusion, état de l'art pour le virtual try-on. Il est gratuit — ce qui était une contrainte budgétaire importante pour un prototype.

La communication entre Django et HuggingFace se fait via un client Gradio, avec un timeout de 5 minutes pour gérer les temps de génération longs."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 5 — GESTION DE PROJET
     ═══════════════════════════════════════════════════════════ -->

## Gestion de projet — Méthode Agile Scrum

<div class="cols-2">

<div>

### 6 sprints × 2 semaines

| Sprint | Focus | Dates |
|--------|-------|-------|
| S0 | Cadrage, maquettes, setup | 7–18 avr. |
| S1 | Auth backend (JWT) | 21 avr.–2 mai |
| S2 | API TryOn + HuggingFace | 5–16 mai |
| S3 | Frontend Flutter | 19–30 mai |
| S4 | Sécurité + Historique | 2–13 juin |
| S5 | Tests + Documentation | 16–27 juin |

### Outils

<span class="chip">GitHub</span>
<span class="chip">Jira</span>
<span class="chip">Figma</span>
<span class="chip">Postman</span>
<span class="chip">Slack</span>

</div>

<div>

### Kanban Sprint 3 (extrait)

| À faire | En cours | Terminé |
|---------|---------|--------|
| HistoryScreen | ResultScreen | LoginScreen |
| | AuthInterceptor | RegisterScreen |
| | | TryOnScreen |
| | | ImagePickerCard |

### Gestion des risques clés

⚠️ **Latence HuggingFace** (30-90s)
→ Indicateur de chargement explicite

⚠️ **Cold start IDM-VTON** (jusqu'à 90s)
→ Timeout 300s + HTTP 502 propre

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 5 [~1 min 30]

"J'ai conduit ce projet en méthode Agile Scrum avec 6 sprints de 2 semaines chacun.

Les 3 premiers sprints ont posé les fondations : cadrage et architecture, authentification JWT backend, puis l'API d'essayage avec l'intégration HuggingFace. C'est d'ailleurs pendant le sprint 2 que j'ai découvert la contrainte principale : le modèle IDM-VTON peut prendre entre 30 et 90 secondes à répondre. J'ai dû concevoir le code en conséquence.

Le sprint 3 a été consacré au frontend Flutter. Le sprint 4 a renforcé la sécurité — rate limiting, validation MIME, headers HTTP. Et le sprint 5 à la documentation et aux tests.

Les outils utilisés sont ceux de StyleShop : GitHub pour le versioning, Jira pour le backlog, Figma pour les maquettes, Postman pour tester l'API manuellement."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 6 — INTERFACE LOGIN
     ═══════════════════════════════════════════════════════════ -->

## Interface Flutter — Authentification

<div class="cols-2">

<div>

<!-- INSÉRER ICI : screenshot de LoginScreen sur émulateur Android -->
<div class="screenshot" style="height: 340px; font-size: 1.1em;">
  📱 <strong>[CAPTURE D'ÉCRAN]</strong><br>
  Écran de Connexion<br>
  <small>Champs username + password<br>Bouton "Se connecter"<br>Lien "S'inscrire"</small>
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
      // Erreur serveur → SnackBar rouge
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()),
          backgroundColor: Theme.of(context)
                             .colorScheme.error),
      );
    }
  }
}
```

**Token stocké dans `FlutterSecureStorage`**
*(keychain iOS / keystore Android)*

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 6 [~1 minute]

"L'écran de connexion est construit avec Flutter et piloté par un provider Riverpod.

Le formulaire valide les champs côté client — champs obligatoires, longueur minimale — avant d'envoyer la requête.

Ce qui est important côté sécurité : le token JWT renvoyé par Django est stocké dans FlutterSecureStorage — soit le keychain iOS, soit le keystore Android selon la plateforme. Ces espaces de stockage sont chiffrés par le système d'exploitation, contrairement à SharedPreferences qui est en clair.

En cas d'erreur serveur — mauvais mot de passe, compte inexistant — l'API retourne un 401 et l'intercepteur affiche une SnackBar rouge avec le message de l'erreur."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 7 — INTERFACE TRYON
     ═══════════════════════════════════════════════════════════ -->

## Interface Flutter — Écran Try-On

<div class="cols-2">

<div>

<!-- INSÉRER : 2 ou 3 screenshots côte à côte : vide / images sélectionnées / chargement -->
<div class="screenshot" style="height: 180px;">
  📱 <strong>[CAPTURE]</strong> TryOnScreen vide<br>
  <small>Deux cartes "Appuyez pour sélectionner"</small>
</div>
<div class="screenshot" style="height: 140px; margin-top: 12px;">
  📱 <strong>[CAPTURE]</strong> Chargement IA<br>
  <small>CircularProgressIndicator + "Génération en cours (30-60s)..."</small>
</div>

</div>

<div>

### Pattern Riverpod — `TryOnNotifier`

```dart
// L'UI écoute deux signaux :
// 1. errorMessage → SnackBar rouge
// 2. resultImageUrl → navigation '/result'
ref.listen<AsyncValue<TryOnState>>(
  tryOnProvider, (prev, next) {
    if (next.value?.errorMessage != null)
      ScaffoldMessenger.of(context)
        .showSnackBar(...);

    if (next.value?.resultImageUrl != null
        && prev?.value?.resultImageUrl == null)
      context.push('/result'); // GoRouter
  }
);

// AbsorbPointer : bloque TOUTES
// les interactions pendant la génération IA
return AbsorbPointer(
  absorbing: isLoading,
  child: /* Formulaire */ ...
);
```

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 7 [~2 minutes]

"L'écran TryOn est le cœur de l'application. Il présente deux cartes de sélection d'image — une pour la photo de l'utilisateur, une pour le vêtement — et un champ de description optionnel qui aide le modèle IA.

J'ai utilisé le pattern Riverpod avec un AsyncNotifier. L'état de l'écran peut être dans trois modes : normal, chargement, ou erreur.

Deux points techniques importants.

Premier : le `ref.listen` permet de réagir aux changements d'état pour déclencher des effets de bord — afficher une SnackBar en cas d'erreur, ou naviguer vers l'écran résultat quand l'URL de l'image générée est disponible. On évite ainsi de mettre de la logique de navigation dans le build.

Deuxième : l'`AbsorbPointer`. Pendant les 30 à 90 secondes de génération IA, l'utilisateur ne doit pas pouvoir interagir avec l'interface — pas de double-clic sur Générer, pas de navigation accidentelle. L'AbsorbPointer bloque toutes les interactions au niveau de l'arbre de widgets pendant le chargement."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 8 — TRYONSERVICE
     ═══════════════════════════════════════════════════════════ -->

## Composant métier — `TryOnService`

<div class="cols-2">

<div>

### Diagramme de séquence simplifié

```
Flutter          Django API       HuggingFace
  │                  │                │
  │ POST /api/tryon/ │                │
  │─────────────────►│                │
  │                  │ validate()     │
  │                  │ INSERT PENDING │
  │                  │                │
  │                  │ predict(imgs)  │
  │                  │───────────────►│
  │                  │   ~30-90 s     │
  │                  │◄───────────────│
  │                  │ result[0]      │
  │                  │ save to media/ │
  │                  │ UPDATE COMPLETED
  │◄─────────────────│                │
  │ HTTP 201 + URL   │                │
```

**En cas d'erreur HuggingFace** → `TryOnAPIException`
→ HTTP 502 + `request_id` pour traçabilité

</div>

<div>

### `services.py` — Appel Gradio

```python
class TryOnService:
    SPACE_ID = "yisol/IDM-VTON"

    @classmethod
    def generate_tryon(cls, person_path,
                       garment_path, description):
        start = time.time()
        try:
            client = Client(cls.SPACE_ID,
              httpx_kwargs={"timeout": 300})

            result = client.predict(
              {"background": handle_file(person_path),
               "layers": [], "composite": None},
              handle_file(garment_path),
              description,
              True, False, 30, 42,
              api_name="/tryon"
            )
            logger.info(f"✅ {time.time()-start:.1f}s")
            return result[0]  # chemin temporaire

        except Exception as exc:
            raise TryOnAPIException(str(exc))
```

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 8 [~2 minutes]

"Le composant le plus complexe du backend est le TryOnService. Son rôle est d'isoler l'appel à l'API HuggingFace du reste de l'application — c'est le pattern Service Layer.

Le diagramme de séquence montre le flux complet : Flutter envoie ses images en multipart à Django, Django valide, enregistre en base avec le statut PROCESSING, puis appelle synchroniquement HuggingFace via le client Gradio.

Deux détails techniques importants dans le code.

D'abord, le timeout est réglé à 300 secondes — 5 minutes. IDM-VTON peut prendre jusqu'à 90 secondes en cold start, c'est-à-dire quand le Space HuggingFace n'a pas été utilisé depuis un moment. On laisse donc une large marge.

Ensuite, toute exception — timeout réseau, réponse invalide, quota dépassé — est capturée et re-levée sous forme de TryOnAPIException. Cela permet à la vue Django de distinguer une erreur IA d'une erreur interne et de retourner le bon code HTTP : 502 Bad Gateway si c'est l'IA qui est en faute, 500 Internal Server Error si c'est notre code.

Le `request_id` retourné dans la réponse 502 permet de retrouver la ligne en base et de corréler avec les logs."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 9 — DJANGO MODÈLE & API REST
     ═══════════════════════════════════════════════════════════ -->

## Modèle Django & API REST

<div class="cols-2">

<div>

### Endpoints exposés

| Méthode | URL | Auth | Code |
|---------|-----|------|------|
| POST | `/api/auth/register/` | ❌ | 201 |
| POST | `/api/auth/token/` | ❌ | 200 |
| POST | `/api/auth/token/refresh/` | ❌ | 200 |
| GET | `/api/auth/profile/` | ✅ JWT | 200 |
| **POST** | **`/api/tryon/`** | ✅ JWT | **201** |
| GET | `/api/tryon/` | ✅ JWT | 200 |
| GET | `/api/tryon/{uuid}/` | ✅ JWT | 200 |
| GET | `/media/{path}` | ✅ JWT | 200 |

### Isolation multi-tenant

```python
def get_queryset(self):
    # Filtrage strict : chaque user
    # ne voit QUE ses propres requêtes
    return TryOnRequest.objects.filter(
        user=self.request.user
    ).order_by('-created_at')
```

</div>

<div>

### `models.py` — Clés de conception

```python
class TryOnRequest(models.Model):
    class Status(models.TextChoices):
        PENDING    = 'PENDING'
        PROCESSING = 'PROCESSING'
        COMPLETED  = 'COMPLETED'
        FAILED     = 'FAILED'

    # UUID : non-prédictible → résistance BOLA
    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE  # RGPD : cascade
    )
    # Validator MIME sur les images d'entrée
    person_image  = models.ImageField(
        validators=[validate_image_file]
    )
    garment_image = models.ImageField(
        validators=[validate_image_file]
    )
    # result_image : pas de validator
    # → généré par le backend, pas l'user
    result_image = models.ImageField(
        blank=True, null=True
    )
    status     = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
```

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 9 [~1 min 30]

"Je vais vous montrer deux aspects du modèle qui ont été pensés dès la conception pour la sécurité.

Côté API : toutes les routes protégées filtrent les données par utilisateur authentifié. C'est le get_queryset qui retourne uniquement les requêtes appartenant à l'utilisateur connecté. Même si quelqu'un connaît l'UUID d'un essayage d'un autre utilisateur, le filtre ORM retourne une liste vide, ce qui se traduit par un 404 — pas un 403 — pour ne pas révéler l'existence de la ressource.

Côté modèle : deux choix importants.

D'abord, l'UUID comme clé primaire. Contrairement à un auto-incrément entier, un UUID v4 est impossible à deviner. Même si on exposait l'ID dans une URL, un attaquant ne pourrait pas énumérer les requêtes des autres utilisateurs.

Ensuite, le `on_delete=CASCADE` sur la clé étrangère utilisateur. Si un compte est supprimé — droit à l'effacement RGPD — toutes ses images et ses essayages sont automatiquement supprimés en base."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 10 — SÉCURITÉ OWASP
     ═══════════════════════════════════════════════════════════ -->

## Sécurité — Conformité OWASP Top 10

<div class="cols-2">

<div>

| OWASP 2021 | Statut | Mesure principale |
|-----------|--------|-----------------|
| A01 — Access Control | <span class="ok">✅</span> | `filter(user=request.user)` · UUID |
| A02 — Crypto Failures | <span class="ok">✅</span> | JWT HS256 · `FlutterSecureStorage` |
| A03 — Injection | <span class="ok">✅</span> | ORM Django (0 SQL brut) |
| A04 — Insecure Design | <span class="ok">✅</span> | Rate limiting 10/h · UUID |
| A05 — Misconfiguration | <span class="ok">✅</span> | `DEBUG=False` · `ALLOWED_HOSTS` |
| A07 — Auth Failures | <span class="ok">✅</span> | Access 15 min · Refresh 7 j |
| A08 — Integrity | <span class="ok">✅</span> | **Validation MIME** magic bytes |
| A09 — Logging | <span class="ok">✅</span> | Logger `tryon.services` INFO/ERROR |
| A10 — SSRF | <span class="ok">✅</span> | URL HuggingFace codée en dur |

</div>

<div>

### Focus — Validation MIME (A08)

```python
# validators.py
# Résiste à l'extension spoofing :
# un PDF renommé en .jpg est détecté

def validate_image_file(file):
    if file.size > 10 * 1024 * 1024:
        raise ValidationError("Fichier > 10 Mo")

    # Lecture des magic bytes réels
    file.seek(0)
    header = file.read(2048)
    file.seek(0)

    kind = filetype.guess(header)
    mime = kind.mime if kind else 'unknown'

    if mime not in ['image/jpeg',
                    'image/png',
                    'image/webp']:
        raise ValidationError(
          f"Type invalide : {mime}"
        )
```

**Pourquoi `filetype` ?**
Pure Python · pas de dépendance binaire
Résiste au `Content-Type` HTTP falsifié

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 10 [~2 minutes]

"La sécurité a été prise en compte dès la conception, pas ajoutée à la fin. Voici comment le projet adresse les 10 risques du top OWASP.

Je vais zoomer sur deux points.

Le contrôle d'accès A01 : j'ai déjà mentionné le filtre ORM. On ajoute à ça la ProtectedMediaView qui vérifie que le chemin du fichier demandé contient bien le dossier de l'utilisateur connecté — donc slash user_{son ID} slash. Impossible d'accéder au dossier d'un autre utilisateur en manipulant l'URL.

La validation des uploads A08 : c'est le point qui m'a le plus occupé. Le problème avec la validation des fichiers c'est que le client contrôle l'extension du fichier et le Content-Type HTTP. Un attaquant peut envoyer un PDF en lui donnant l'extension .jpg et en déclarant image/jpeg dans la requête — le serveur ne verrait que du JPEG.

La solution est de lire les magic bytes — les premiers octets du fichier — qui sont une signature binaire propre à chaque format. Un PDF commence toujours par les bytes 25 50 44 46, peu importe comment vous l'avez renommé. La bibliothèque filetype fait cette analyse en Python pur, sans dépendance binaire système.

J'ai aussi remplacé python-magic-bin, qui était abandonné depuis 2023, par filetype — un point que je détaillerai dans la slide de veille."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 11 — JEU D'ESSAI
     ═══════════════════════════════════════════════════════════ -->

## Jeu d'essai — 8 cas testés

<div class="cols-2" style="gap: 24px;">

<div>

| N° | Scénario | Résultat | Statut |
|----|---------|---------|--------|
| T01 | Inscription valide | HTTP 201 | <span class="ok">✅</span> |
| T02 | Connexion JWT | HTTP 200 + tokens | <span class="ok">✅</span> |
| T03 | Upload PDF renommé .jpg | HTTP 400 + message MIME | <span class="ok">✅</span> |
| T04 | 11ème requête en 1h | HTTP 429 + Retry-After | <span class="ok">✅</span> |
| T05 | Isolation user1/user2 | Liste vide pour user2 | <span class="ok">✅</span> |
| T06 | Accès fichier autre user | HTTP 403 Forbidden | <span class="ok">✅</span> |
| T07 | Route sans token | HTTP 401 | <span class="ok">✅</span> |
| T08 | Token expiré (Flutter) | Refresh auto · 0 erreur visible | <span class="ok">✅</span> |

<span class="chip chip-ok">8/8 — Taux de conformité 100 %</span>

</div>

<div>

<!-- INSÉRER : screenshot du résultat IA généré par IDM-VTON -->
<div class="screenshot" style="height: 280px; font-size: 1.1em;">
  📸 <strong>[CAPTURE]</strong><br>
  Résultat de génération IA<br>
  <small>Écran ResultScreen<br>Image IDM-VTON affichée<br>Boutons Télécharger + Partager</small>
</div>

<div class="muted" style="margin-top: 10px;">
⚠️ En production : Redis requis pour le rate limiting<br>
⚠️ Redirection auto vers login si refresh expiré (phase 2)
</div>

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 11 [~1 min 30]

"Le jeu d'essai couvre 8 cas de test — nominaux et cas limites.

Je vais en commenter trois.

Le test T03 valide la validation MIME : j'ai pris un vrai fichier PDF, je l'ai renommé en photo.jpg et je l'ai envoyé avec le Content-Type image/jpeg. L'API a bien retourné un HTTP 400 avec le message 'Type de fichier invalide détecté : application/pdf'. Le validateur a vu les magic bytes PDF malgré le camouflage.

Le test T04 valide le rate limiting : j'ai envoyé 10 requêtes valides successives — toutes en 201 — puis une 11ème. L'API a retourné un 429 avec le header Retry-After à 3600 secondes.

Le test T08 est le plus intéressant : j'ai simulé un token expiré en réduisant ACCESS_TOKEN_LIFETIME à 1 seconde. Depuis Flutter, j'ai attendu 2 secondes puis effectué une action. L'AuthInterceptor a détecté le 401, a automatiquement appelé le endpoint de refresh, a mis à jour le token en stockage, et a rejoué la requête originale. L'utilisateur n'a rien vu.

Deux points d'attention identifiés : en production multi-workers, le rate limiting nécessite Redis pour partager le compteur entre processus. Et la redirection automatique vers le login en cas de refresh expiré est à implémenter en phase 2."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 12 — VEILLE SÉCURITÉ
     ═══════════════════════════════════════════════════════════ -->

## Veille sécurité — Sources & vulnérabilités identifiées

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

### CVE identifiées

| CVE | Composant | Impact | Action |
|-----|----------|--------|--------|
| CVE-2024-56374 | Django < 5.0.11 | DoS | Version 5.0.14 ✅ |
| CVE-2024-3116 | pgAdmin < 8.6 | RCE | Mise à jour ✅ |

</div>

<div>

### Action corrective majeure — Supply chain

**Problème identifié** :
`python-magic-bin` (validation MIME initiale)
→ abandonnée depuis 2023
→ DLL `libmagic` v1.0.17 de **2009** (non patchée)
→ Fork suspect sur PyPI avec même nom

```python
# AVANT (risqué)
import magic
mime = magic.from_buffer(header, mime=True)

# APRÈS (corrigé)
import filetype  # Pure Python, maintenu
kind = filetype.guess(header)
mime = kind.mime if kind else 'unknown'
```

<span class="chip chip-ok">0 dépendance binaire système</span>
<span class="chip chip-ok">Maintenu activement</span>

</div>

</div>

<!-- 
NOTES ORATEUR — Slide 12 [~1 minute]

"La veille sécurité que j'ai mise en place se base sur 7 sources, consultées entre hebdomadairement et mensuellement.

Deux CVE ont eu un impact direct sur le projet.

La première, CVE-2024-56374, affecte Django avant la version 5.0.11. Notre projet utilise Django 5.0.14 — version postérieure au correctif. Pas d'action nécessaire, mais cela nous a rappelé d'épingler les versions dans requirements.txt.

La deuxième, CVE-2024-3116, est une vulnérabilité critique dans pgAdmin 4 permettant l'exécution de code arbitraire. pgAdmin étant utilisé en développement pour administrer PostgreSQL, j'ai immédiatement mis à jour vers la version 8.6.

L'action la plus significative reste le remplacement de python-magic-bin. En auditant mes dépendances, j'ai découvert que cette bibliothèque était abandonnée depuis 2023 et encapsulait une DLL binaire de 2009 sans patchs de sécurité. Un fork avec un nom similaire circulait sur PyPI — risque de supply chain réel. J'ai remplacé par filetype, une bibliothèque Python pure, activement maintenue, sans aucune dépendance binaire système."
-->

---

<!-- ═══════════════════════════════════════════════════════════
     SLIDE 13 — SYNTHÈSE
     ═══════════════════════════════════════════════════════════ -->

## Synthèse

<div class="cols-3">

<div class="card">

### ✅ Satisfactions

- Architecture propre et évolutive
- Sécurité pensée dès la conception (OWASP 9/10)
- `AuthInterceptor` : refresh JWT transparent
- Validation MIME robuste (magic bytes)
- Suite de tests significative (20 tests)
- 8/8 cas de test conformes

</div>

<div class="card">

### ⚠️ Difficultés

- **Latence HuggingFace** (30-90s) : UX à retravailler
- **Format Gradio** d'IDM-VTON : dict ImageEditor non documenté → 2 jours de débogage
- **Permissions galerie** iOS/Android : comportement différent par plateforme
- **python-magic-bin** : dépendance abandonnée découverte tardivement

</div>

<div class="card">

### 🚀 Axes d'amélioration

- **Redis** pour le rate limiting multi-workers
- **File d'attente** (Celery) pour passer l'IA en asynchrone
- **Stockage S3** (AWS) à la place du système local
- **HTTPS + HSTS** pour le déploiement production
- **Redirection auto** vers login si refresh expiré
- **Tests iOS** (permissions spécifiques)

</div>

</div>

---

<br>

<div style="text-align: center; margin-top: 32px;">

### Merci pour votre attention

**Questions ?**

<br>

<span class="muted">Loïc Botsy · loic.botsy@hotmail.com</span><br>
<span class="muted">Code source : dépôt GitHub privé StyleShop · MSP1_BL</span><br>
<span class="muted">Stack : Flutter 3 · Django 5 · PostgreSQL 15 · HuggingFace IDM-VTON</span>

</div>

<!-- 
NOTES ORATEUR — Slide 13 [~1 min 30]

"Pour conclure, voici ma synthèse du projet.

Côté satisfactions : l'architecture N-tiers est propre et les responsabilités bien séparées. La sécurité a été adressée sur 9 des 10 risques OWASP, avec des mesures concrètes dans le code. Le refresh JWT automatique fonctionne parfaitement côté Flutter, ce dont je suis particulièrement satisfait car c'était un défi technique.

Côté difficultés : la plus marquante a été le format d'appel IDM-VTON. La documentation de l'API Gradio était incomplète — le paramètre personne est un dictionnaire au format ImageEditor et non une simple image. J'ai passé deux jours à décortiquer le code source du Space HuggingFace pour comprendre le format attendu. C'est une leçon sur l'importance de tester les API tierces très tôt dans un projet.

Côté améliorations : la priorité en production serait de passer l'appel HuggingFace en asynchrone avec Celery. Aujourd'hui Django est bloqué pendant 30 à 90 secondes par requête, ce qui n'est pas scalable. Avec Celery, on rendrait la main immédiatement à Flutter avec un identifiant de tâche, et Flutter interrogerait periodiquement le statut.

Je suis maintenant disponible pour vos questions."

─────────────────────────────────────────────────
TIMING GLOBAL (objectif 18-19 min)
─────────────────────────────────────────────────
Slide 1  — Titre          :  0:30
Slide 2  — Entreprise     :  1:00
Slide 3  — Besoins        :  1:30
Slide 4  — Architecture   :  2:00
Slide 5  — Gestion projet :  1:30
Slide 6  — Login Flutter  :  1:00
Slide 7  — TryOn Flutter  :  2:00
Slide 8  — TryOnService   :  2:00
Slide 9  — Django API     :  1:30
Slide 10 — Sécurité OWASP :  2:00
Slide 11 — Jeu d'essai   :  1:30
Slide 12 — Veille         :  1:00
Slide 13 — Synthèse + Q   :  1:30
─────────────────────────────────────
TOTAL                     : 19:00 min
─────────────────────────────────────
-->
