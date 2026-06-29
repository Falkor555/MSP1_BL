# Fiche de notes orateur — Phrases complètes
> Les passages **en gras** sont les points essentiels à ne pas manquer.

---

## SLIDE 1 — TITRE [~30 secondes]

Bonjour à tous. Je m'appelle **Loïc Botsy** et je suis candidat au **Titre Professionnel Concepteur Développeur d'Applications de niveau 6**.

Durant ma période en entreprise chez **StyleShop SAS**, j'ai conçu et développé **FitAI**, une application mobile d'essayage virtuel de vêtements propulsée par l'intelligence artificielle.

Ma présentation sera organisée en **trois parties** : d'abord la **conception** du projet — architecture, modèle de données, flux métier — ensuite la **réalisation technique** avec les composants clés du code, et enfin une **conclusion sur les principes orientés objet** appliqués et les perspectives d'évolution.

---

## SLIDE 2 — ENTREPRISE [~1 minute]

**StyleShop SAS** est une startup parisienne fondée en 2022, spécialisée dans la **vente de vêtements de mode en ligne** via une application mobile. Elle compte **14 collaborateurs** dont une **équipe technique de 6 personnes**, pour un chiffre d'affaires de **1,2 million d'euros** en 2025 et **32 000 utilisateurs actifs**.

La stack technologique existante est **Django côté backend, Flutter côté mobile et AWS pour l'infrastructure** — des choix qui ont directement influencé les technologies que j'ai utilisées pour FitAI.

J'ai intégré l'équipe en tant que **développeur full-stack stagiaire**, sous la supervision directe de **Thomas Dupont, le CTO**. Ma mission principale était de **concevoir et développer la fonctionnalité d'essayage virtuel de A à Z** — du modèle de données Django jusqu'aux écrans Flutter.

---

## SLIDE 3 — EXPRESSION DES BESOINS [~1 min 30]

Le problème que StyleShop m'a demandé de résoudre est **très concret et chiffré** : **35 % des commandes de vêtements en ligne sont retournées**, et la raison principale que les clients donnent est *"ce n'est pas ce que j'imaginais sur moi"*. Côté business, chaque retour coûte **environ 15 euros de logistique**, génère de l'insatisfaction client et augmente l'empreinte carbone.

La solution est l'**essayage virtuel** : on demande à l'utilisateur de fournir deux photos — **une photo de lui-même et une photo du vêtement** — et on génère via intelligence artificielle une image réaliste du résultat en quelques dizaines de secondes.

Les **fonctionnalités prioritaires** ont été définies avec Sophie Mercier, la Product Owner, lors des sessions de backlog. Les quatre fonctionnalités de priorité haute sont : **l'authentification sécurisée par JWT**, **l'upload des deux photos avec une description**, la **génération IA** et l'**affichage sécurisé du résultat**. L'historique et le partage constituent une priorité moyenne pour une phase deux.

---

## SLIDE 4 — ARCHITECTURE TECHNIQUE [~2 minutes]

L'architecture est **N-tiers** avec quatre couches bien séparées.

**Première couche : le frontend mobile** en Flutter 3, avec Riverpod pour la gestion d'état réactive et GoRouter pour la navigation déclarative. Flutter a été choisi car c'est **déjà le framework mobile de StyleShop** — pas de changement de technologie pour l'équipe, pas de courbe d'apprentissage.

**Deuxième couche : l'API REST** en Django 5 avec Django REST Framework. Django a été préféré à FastAPI pour **deux raisons techniques** : son ORM puissant qui évite tout SQL brut, et l'intégration native de SimpleJWT qui nous a économisé un temps considérable sur la partie authentification.

**Troisième couche : la persistance** avec PostgreSQL 15. C'est le standard de StyleShop en production. Deux avantages déterminants : **le support natif des UUID** en tant que type de colonne, et les garanties **ACID** pour la cohérence des données.

**Quatrième couche : l'intelligence artificielle** avec le modèle open-source **IDM-VTON hébergé sur HuggingFace Spaces**. C'est un modèle de diffusion, état de l'art pour le virtual try-on. Il est **gratuit** — ce qui était une contrainte budgétaire importante pour un prototype chez une startup. La communication entre Django et HuggingFace se fait via un **client Gradio** avec un timeout de 5 minutes.

---

## SLIDE 5 — MODÈLE DE DONNÉES [~1 min 30]

Le modèle de données ne comporte que **deux tables principales** : `User`, fournie nativement par Django, et `TryOnRequest`, que j'ai créée. Elles sont liées par une **relation Un-à-Plusieurs** : un utilisateur peut effectuer plusieurs essayages.

Quatre décisions de conception méritent d'être expliquées.

**Premièrement, l'UUID comme clé primaire.** Contrairement à un entier auto-incrémenté, un **UUID version 4 est impossible à deviner**. Même si quelqu'un connaissait l'URL d'un essayage, il ne pourrait pas énumérer les essayages des autres utilisateurs en incrémentant un identifiant. C'est une protection directe contre les **attaques BOLA** — Broken Object Level Authorization.

**Deuxièmement, l'enum Status.** Le cycle de vie d'un essayage passe par quatre états : `PENDING` à la création de la requête, `PROCESSING` pendant l'appel IA, `COMPLETED` en cas de succès, `FAILED` en cas d'erreur. C'est une **machine à états explicite** qui facilite le débogage et la traçabilité en base.

**Troisièmement, le `on_delete=CASCADE`** sur la clé étrangère utilisateur. Si un compte est supprimé — conformément au **droit à l'effacement RGPD** — toutes ses images et ses essayages sont automatiquement supprimés en cascade.

**Quatrièmement, la séparation des champs image** : `person_image` et `garment_image` viennent de l'utilisateur et sont soumis à une **validation MIME stricte**. `result_image` est générée par le backend et ne nécessite pas ce contrôle — car elle n'est jamais fournie par l'extérieur.

---

## SLIDE 6 — DIAGRAMME DE CLASSES [~1 min 30]

Je vais vous présenter les **principales classes de l'application** et leurs relations d'héritage.

**Côté Django**, l'architecture suit le pattern **MVT** complété par une **couche Service**.

`TryOnViewSet` hérite de `ModelViewSet` de Django REST Framework. Grâce à l'héritage, on reçoit **automatiquement les opérations CRUD, la pagination et les codes HTTP corrects** — on n'écrit que les personnalisations nécessaires, notamment `get_queryset` pour filtrer par utilisateur.

`TryOnSerializer` hérite de `ModelSerializer`. Il gère **automatiquement la validation des champs et la sérialisation JSON**. On y ajoute uniquement la logique métier spécifique à FitAI — la validation MIME via `validate_image_file`.

`TryOnService` est **la classe la plus importante du backend** : c'est elle qui encapsule toute l'interaction avec HuggingFace. Si demain on change de fournisseur IA, **une seule classe est à modifier**.

`TryOnAPIException` hérite d'`Exception` et permet de **distinguer une erreur IA d'une erreur interne** lors du traitement dans la vue.

**Côté Flutter**, j'ai utilisé le **pattern Riverpod** avec des `AsyncNotifier`. `AuthNotifier` gère le cycle de vie du token JWT, `TryOnNotifier` gère l'état de la génération. Les deux passent par un `ApiService` centralisé qui injecte automatiquement le Bearer token via l'`AuthInterceptor`.

---

## SLIDE 7 — FLUX MÉTIER [~1 min 30]

Je vais décrire le **flux de génération étape par étape**.

Flutter envoie les deux images en multipart à l'API Django via une requête **POST /api/tryon/** avec le token JWT dans le header. Django valide les données via le serializer — vérification MIME, taille des fichiers — puis **enregistre en base avec le statut `PENDING`**.

Django délègue ensuite à `TryOnService`, qui appelle **synchroniquement HuggingFace via le client Gradio**. C'est ici qu'on attend — entre **30 et 90 secondes** selon l'état du modèle. Une fois le résultat reçu, Django sauvegarde l'image dans le dossier media, met à jour le statut en `COMPLETED`, et retourne l'**URL de l'image générée** à Flutter. Flutter navigue automatiquement vers `ResultScreen`.

**Trois points de défaillance ont été anticipés.**

**Premier** : le timeout de HuggingFace. IDM-VTON peut prendre jusqu'à 90 secondes en cold start. On configure donc un timeout à 300 secondes pour laisser une large marge. En cas de dépassement, on retourne un **HTTP 502** avec le `request_id` pour la traçabilité.

**Deuxième** : les erreurs IA — quota dépassé, réseau instable. Toute exception de `TryOnService` est capturée, le statut passe à `FAILED`, et un message d'erreur clair est retourné à Flutter.

**Troisième** : la double soumission. Pendant les 30 à 90 secondes de génération, **l'`AbsorbPointer` Flutter bloque physiquement toutes les interactions** — l'utilisateur ne peut pas cliquer deux fois sur Générer ni naviguer accidentellement.

---

## SLIDE 8 — GESTION DE PROJET [~1 min 30]

J'ai conduit ce projet en **méthode Agile Scrum** avec **6 sprints de 2 semaines chacun**.

Les **trois premiers sprints** ont posé les fondations : cadrage et maquettes Figma, authentification JWT backend, puis l'API TryOn avec l'intégration HuggingFace. Le sprint 3 a développé les **5 écrans Flutter**. Le sprint 4 a renforcé la sécurité et ajouté l'historique. Le sprint 5 a finalisé les tests et la documentation.

La **difficulté technique principale** a été découverte au Sprint 2. Le format d'appel d'IDM-VTON n'était **pas documenté** : le paramètre `person` attend un **dictionnaire au format `ImageEditor`** — avec les clés `background`, `layers` et `composite` — et non une simple image. J'ai passé **2 jours à analyser le code source du Space HuggingFace** pour comprendre ce format. C'est une leçon sur l'importance de **tester les API tierces très tôt** dans un projet.

Les **risques ont été identifiés et mitigés** : la latence HuggingFace a été gérée par un indicateur de chargement explicite, le cold start par un timeout de 300 secondes, et la dépendance abandonnée `python-magic-bin` par son remplacement par `filetype`.

Les outils utilisés sont ceux de StyleShop : **GitHub** pour le versioning, **Jira** pour le backlog, **Figma** pour les maquettes, **Insomnia** pour tester l'API manuellement.

---

## SLIDE 9 — SÉCURITÉ OWASP [~1 min 30]

La sécurité a été **prise en compte dès la conception**, pas ajoutée à la fin. Je vais présenter les **trois couches de protection** mises en place.

**Première couche — Flutter** : les tokens JWT ne sont jamais stockés dans `SharedPreferences`, qui est **en clair sur le système de fichiers**. J'utilise `FlutterSecureStorage`, qui s'appuie sur le **keystore Android** et le **keychain iOS** — des espaces de stockage chiffrés par le système d'exploitation. L'`AuthInterceptor` injecte automatiquement le Bearer token et gère le **refresh silencieux** sans que l'utilisateur ne voie quoi que ce soit.

**Deuxième couche — API Django** : toutes les routes protégées filtrent les données **par utilisateur authentifié** via `filter(user=request.user)`. Le rate limiting limite chaque utilisateur à **10 générations par heure** pour prévenir les abus. La **validation MIME** inspecte les magic bytes des fichiers pour détecter les uploads malveillants.

**Troisième couche — Modèle de données** : les **UUID** rendent l'énumération des ressources impossible. Le `on_delete=CASCADE` garantit la suppression des données pour le **droit à l'effacement RGPD**. La `ProtectedMediaView` vérifie que le chemin du fichier demandé appartient bien au dossier de l'utilisateur connecté.

Sur les **10 risques OWASP 2021, 9 sont directement adressés** dans le code.

---

## SLIDE 10 — VEILLE TECHNOLOGIQUE [~1 minute]

La veille sécurité repose sur **7 sources** consultées entre hebdomadairement et mensuellement : CVE Mitre, OWASP News, PyPI Advisories, le blog sécurité officiel Django, le CERT-FR, GitHub Dependabot et PortSwigger Research.

**Deux CVE ont eu un impact direct** sur le projet.

La première, **CVE-2024-56374**, affecte Django avant la version 5.0.11 et permet une attaque par **déni de service**. Notre projet utilise la version 5.0.14 — le correctif est déjà inclus. Cela nous a néanmoins rappelé l'importance d'**épingler les versions** dans `requirements.txt`.

La deuxième, **CVE-2024-3116**, est une vulnérabilité critique dans **pgAdmin 4 permettant l'exécution de code arbitraire**. pgAdmin étant utilisé en développement pour administrer PostgreSQL, j'ai procédé à une mise à jour immédiate vers la version 8.6.

L'**action la plus significative** reste le remplacement de `python-magic-bin`. En auditant mes dépendances, j'ai découvert que cette bibliothèque était **abandonnée depuis 2023** et encapsulait une **DLL binaire de 2009 sans patches de sécurité**. Un fork avec un nom similaire circulait sur PyPI — c'est un **risque de supply chain réel**. Je l'ai remplacée par `filetype` : une bibliothèque **Python pure, sans dépendance binaire**, activement maintenue, avec une résistance équivalente — lecture des magic bytes pour détecter le spoofing d'extension.

---

## [INTERLUDE] SECTION — RÉALISATION TECHNIQUE [~10 secondes]

*"Passons maintenant à la réalisation technique avec les composants clés du code."*

---

## SLIDE 11 — INTERFACE FLUTTER — AUTHENTIFICATION [~1 min 30]

L'écran de connexion illustre le **pattern Provider de Riverpod**.

La logique est clairement séparée : `_submit()` **valide le formulaire côté client** — champs obligatoires, longueur minimale — puis **délègue entièrement au `AuthNotifier`**. C'est le notifier qui appelle l'API et met à jour l'état global de l'application. L'écran ne fait qu'observer et réagir — il n'a aucune logique métier propre.

**Point de sécurité fondamental** : le token JWT n'est jamais stocké dans `SharedPreferences`, qui est **accessible en clair** sur le système de fichiers Android. J'utilise `FlutterSecureStorage`, qui utilise le **keystore Android** sur Android et le **keychain iOS** sur iOS. Ces espaces sont **chiffrés par le système d'exploitation** et inaccessibles aux autres applications.

L'**`AuthInterceptor`** injecte automatiquement le Bearer token dans chaque requête HTTP. Si le serveur retourne un 401 — token expiré — l'intercepteur **appelle silencieusement le endpoint de refresh**, met à jour le token en stockage, et **rejoue la requête originale**. L'utilisateur ne voit rien.

---

## SLIDE 12 — INTERFACE FLUTTER — TRYON & RIVERPOD [~1 min 30]

L'écran TryOn présente deux cartes de sélection d'image et un bouton Générer. Il illustre **deux patterns techniques importants**.

**Premier pattern : le `ref.listen`**. En Riverpod, la règle est de ne **jamais mettre de logique impérative dans la méthode `build`** — navigation, affichage de SnackBars. On utilise `ref.listen` pour **réagir aux changements d'état** et déclencher ces effets de bord en dehors du cycle de rendu. Ici, on **navigue vers `ResultScreen`** quand `resultImageUrl` passe de `null` à une URL valide, et on affiche une **SnackBar rouge** si `errorMessage` est renseigné.

**Deuxième pattern : l'`AbsorbPointer`**. Pendant les 30 à 90 secondes de génération IA, l'utilisateur ne doit pas pouvoir interagir avec l'interface. L'`AbsorbPointer` avec `absorbing: state.isLoading` **bloque physiquement tous les événements tactiles** sur l'arbre de widgets enfant pendant le chargement. C'est plus robuste qu'un simple bouton désactivé car il protège aussi contre la navigation accidentelle via le bouton retour ou d'autres zones de l'écran.

---

## SLIDE 13 — BACKEND DJANGO — CODE CLÉ & JEU D'ESSAI [~2 minutes]

Je vais présenter les deux composants backend les plus importants, puis commenter le jeu d'essai.

**`TryOnService.generate_tryon()`** est le cœur de l'intégration IA. Le point technique clé qui m'a pris deux jours : le paramètre `person` d'IDM-VTON **n'est pas une image directe** mais un **dictionnaire au format `ImageEditor`** avec les clés `background`, `layers` et `composite`. Ce format n'est pas documenté dans l'API Gradio — je l'ai découvert en lisant le code source du Space HuggingFace. Toute exception — timeout, quota, réseau — est capturée et **re-levée sous forme de `TryOnAPIException`**, ce qui permet à la vue de retourner le bon code HTTP.

**`validate_image_file()`** lit les **magic bytes** des fichiers — les premiers octets qui constituent une **signature binaire propre à chaque format**. Un PDF renommé en `.jpg` commence toujours par les bytes `25 50 44 46`, peu importe l'extension donnée ou le `Content-Type` HTTP déclaré. La bibliothèque `filetype` détecte ce spoofing et lève une `ValidationError` avec le type réel.

**Sur le jeu d'essai**, je vais commenter trois tests. **T03** : j'ai pris un vrai PDF, je l'ai renommé `photo.jpg`, envoyé avec le header `Content-Type: image/jpeg`. Résultat : HTTP 400 avec le message *"Type invalide : application/pdf"*. **T04** : après 10 générations consécutives, la 11ème reçoit un **HTTP 429 avec le header `Retry-After: 3600`**. **T08**, le plus technique : j'ai réduit `ACCESS_TOKEN_LIFETIME` à 1 seconde pour simuler une expiration. L'`AuthInterceptor` a détecté le 401, **refreshé automatiquement**, et rejoué la requête originale. **L'utilisateur n'a vu aucune erreur.**

---

## [INTERLUDE] SECTION — CONCLUSION & PERSPECTIVES [~10 secondes]

*"Pour conclure, je vais revenir sur les principes de programmation orientée objet appliqués dans ce projet, puis sur les axes d'évolution."*

---

## SLIDE 14 — PROGRAMMATION ORIENTÉE OBJET DANS FITAI [~1 min 30]

Je vais illustrer comment les **quatre piliers de la POO** se retrouvent concrètement dans FitAI.

**Encapsulation** : `TryOnService` cache toute la complexité de l'appel HuggingFace. La vue Django appelle `generate_tryon()` avec trois paramètres et reçoit un chemin de fichier. **Elle ignore totalement** quel client Gradio est utilisé, quel format `ImageEditor` est requis, quel timeout est configuré. Si demain StyleShop change de fournisseur IA — passage à un modèle self-hosted par exemple — **une seule classe est à modifier**, sans toucher à la vue ni au serializer.

**Héritage** : `TryOnViewSet` hérite de `ModelViewSet` de DRF et reçoit **gratuitement le CRUD complet, la pagination, les codes HTTP corrects**. `TryOnSerializer` hérite de `ModelSerializer` et obtient **automatiquement la validation et la sérialisation JSON**. Côté Flutter, `TryOnNotifier` hérite d'`AsyncNotifier<TryOnState>` et redéfinit uniquement la méthode `build()`.

**Polymorphisme** : les **exceptions typées** permettent un traitement différencié. En attrapant `TryOnAPIException` séparément d'`Exception`, on peut retourner un **HTTP 502** — *Bad Gateway* — quand c'est l'IA qui est en faute, et un **HTTP 500** — *Internal Server Error* — quand c'est notre code. Les serializers DRF redéfinissent les méthodes `validate()` et `create()` pour la logique métier spécifique.

**Abstraction** : l'architecture en couches **Vue → Serializer → Service → ORM → DB** est le principe architectural fondateur. Chaque couche expose une interface claire sans révéler son implémentation. **Flutter ignore la structure interne de Django. Django ignore que Flutter appelle via HTTP. IDM-VTON ignore la logique métier de StyleShop.**

---

## SLIDE 15 — PERSPECTIVES & ÉVOLUTIONS [~1 min 30]

Je distingue **trois horizons d'évolution** pour FitAI.

**À court terme, les améliorations pour la mise en production**. La plus urgente est **Celery**. Aujourd'hui, Django est **bloqué pendant 30 à 90 secondes** par requête IA — ce n'est pas scalable dès qu'il y a plusieurs utilisateurs simultanés. Avec Celery, Django **lance la tâche en arrière-plan et retourne immédiatement un identifiant de tâche** à Flutter. Flutter interroge périodiquement le statut. Cela libère le processus Django pour d'autres requêtes. On ajoutera également **Redis** pour le rate limiting multi-workers, **AWS S3** pour remplacer le stockage fichier local, et **HTTPS avec HSTS** avant toute mise en production réelle.

**À moyen terme, la qualité et l'expérience utilisateur**. Les **WebSockets** élimineraient le polling de Flutter — Django notifierait Flutter en temps réel dès que la génération IA est terminée. Les **tests iOS** sont prioritaires car les permissions de galerie se comportent différemment d'Android. On gérera aussi la **redirection automatique vers le login** en cas de token de refresh expiré.

**À long terme, les évolutions à haute valeur métier**. **Héberger IDM-VTON en propre** sur AWS SageMaker ou RunPod supprimerait les latences de cold start et la dépendance à HuggingFace. Un **moteur de recommandation** analyserait le morphotype détecté pour suggérer des vêtements du catalogue StyleShop. L'**essayage multi-vêtements** permettrait d'assembler haut, bas et accessoires en une seule génération — une évolution majeure de l'expérience utilisateur.

---

## SLIDE 16 — MERCI & QUESTIONS [~30 secondes]

Pour résumer : **FitAI est une application mobile fonctionnelle** qui répond au besoin de StyleShop de réduire les retours en permettant l'essayage virtuel. Elle applique les **quatre piliers de la programmation orientée objet** à travers une architecture N-tiers propre et sécurisée — 9 risques OWASP adressés, 8 cas de test conformes sur 8.

Les **principaux apprentissages** sont l'application concrète de la POO dans un contexte full-stack, la gestion de dépendances et de la veille CVE, et la complexité réelle de l'intégration d'une API IA non documentée.

**Je suis maintenant disponible pour répondre à vos questions.**
