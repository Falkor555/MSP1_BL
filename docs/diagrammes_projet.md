# Diagrammes — Dossier Projet Final FitAI

> Générés depuis le code source réel du projet `MSP1_BL`.  
> **Export PNG/SVG** : coller chaque bloc Mermaid sur [mermaid.live](https://mermaid.live) puis télécharger.

---

## 1. Schéma d'Architecture Globale

Flutter → Django REST API → HuggingFace IDM-VTON → PostgreSQL

```mermaid
graph TB
    subgraph Flutter ["📱 Flutter App  (Dart · Riverpod · GoRouter)"]
        UI["Écrans\nLoginScreen · TryOnScreen\nResultScreen · HistoryScreen"]
        Riverpod["Riverpod Providers\nTryOnNotifier · AuthNotifier"]
        Repos["Repositories\nTryOnRepository · AuthRepository"]
        Dio["Dio HTTP Client\nAuthInterceptor · ErrorInterceptor"]
        Storage["FlutterSecureStorage\naccess_token · refresh_token"]
        UI --> Riverpod --> Repos --> Dio
        Dio <--> Storage
    end

    subgraph Django ["⚙️  Django 5  —  REST API  (localhost:8000)"]
        subgraph AuthMod ["Auth  /api/auth/"]
            RegView["POST /register/\n(AllowAny)"]
            TokenView["POST /token/\n(AllowAny)"]
            RefreshView["POST /token/refresh/"]
            ProfileView["GET /profile/\n(IsAuthenticated)"]
            JWT["JWT SimpleJWT\naccess 15 min · refresh 7 j"]
        end
        subgraph TryOnMod ["TryOn  /api/tryon/"]
            TryOnView["POST + GET /tryon/\nTryOnListCreateView"]
            DetailView["GET /tryon/:id/\nTryOnDetailView"]
            MediaView["GET /media/:path\nProtectedMediaView"]
            Validator["validate_image_file()\nJPEG / PNG / WebP · ≤ 10 MB"]
            Throttle["TryOnRateThrottle\n10 req / heure / user"]
            Service["TryOnService\ngradio_client · timeout 300 s"]
        end
    end

    subgraph HF ["🤗  HuggingFace Spaces"]
        VTON["yisol / IDM-VTON\n(Gradio API)\n≈ 30 – 90 secondes"]
    end

    subgraph DB ["🗄️  PostgreSQL 15  (port 5433)"]
        Users[("users_user")]
        Requests[("tryon_tryonrequest")]
        MediaFS[("media/\ntryon_images/\nuser_{id}/{uuid}.jpg")]
    end

    Dio -- "HTTP · Bearer JWT" --> AuthMod
    Dio -- "multipart/form-data" --> TryOnMod

    RegView --> Users
    TokenView --> JWT --> Users

    TryOnView --> Validator
    TryOnView --> Throttle
    TryOnView --> Service
    TryOnView --> Requests
    TryOnView --> MediaFS

    Service -- "client.predict()" --> VTON
    VTON -- "image générée (chemin tmp)" --> Service
    Service --> MediaFS

    DetailView --> Requests
    MediaView --> MediaFS
```

---

## 2. Diagramme de Séquence — Appel Try-On Complet

upload → validation → appel HuggingFace → sauvegarde → réponse

```mermaid
sequenceDiagram
    actor User as Utilisateur
    participant UI    as TryOnScreen
    participant Prov  as TryOnNotifier
    participant Repo  as TryOnRepository
    participant Dio   as Dio + AuthInterceptor
    participant API   as Django API
    participant DB    as PostgreSQL
    participant FS    as Fichiers media/
    participant HF    as HuggingFace IDM-VTON

    User  ->> UI   : Sélectionne person_image
    User  ->> UI   : Sélectionne garment_image
    User  ->> UI   : Saisit description (optionnel)
    User  ->> UI   : Clique « Générer »

    UI    ->> Prov : submitTryOn()
    Prov  ->> Prov : Validation : images présentes ?
    Prov  ->> Prov : setState(AsyncLoading)
    Prov  ->> Repo : createTryOn(personImg, garmentImg, desc)
    Repo  ->> Repo : Construit FormData (multipart)
    Repo  ->> Dio  : POST /api/tryon/

    Note over Dio : Injecte « Authorization: Bearer {access_token} »

    Dio   ->> API  : POST /api/tryon/ (multipart/form-data)

    Note over API : ① IsAuthenticated — vérifie JWT<br/>② TryOnRateThrottle — max 10/heure

    API   ->> API  : MultiPartParser → extrait person_image, garment_image, description
    API   ->> API  : validate_image_file() — MIME via magic bytes, taille ≤ 10 MB

    alt Validation échoue (format ou taille)
        API  -->> Dio  : HTTP 400 · {errors}
        Dio  -->> Prov : DioException
        Prov ->> Prov  : setState(errorMessage)
        Prov -->> UI   : Affiche SnackBar erreur
    else Validation OK
        API  ->> DB   : INSERT TryOnRequest(status=PROCESSING)
        API  ->> FS   : Sauvegarde person_image + garment_image\n→ tryon_images/user_{id}/{uuid}.jpg

        API  ->> HF   : gradio_client.predict(<br/>person_image_dict, garment_image,<br/>description, True, False, 30, 42)

        Note over HF : Modèle IDM-VTON<br/>traitement diffusion ≈ 30–90 s

        alt HuggingFace répond avec succès
            HF   -->> API  : result[0] = chemin image temporaire
            API  ->> FS    : Copie résultat → tryon_images/user_{id}/{uuid}_result.jpg
            API  ->> DB    : UPDATE TryOnRequest(status=COMPLETED, result_image=path)
            API  -->> Dio  : HTTP 201 · JSON TryOnRequest
            Dio  -->> Repo : Response 201
            Repo ->> Repo  : TryOnModel.fromJson(response.data)
            Repo -->> Prov : TryOnModel (resultImageUrl)
            Prov ->> Prov  : setState(AsyncData + resultImageUrl)
            Prov -->> UI   : state mis à jour

            UI   ->> UI   : context.push('/result')
            UI   ->> Dio  : GET /media/tryon_images/user_{id}/{uuid}_result.jpg

            Note over Dio : Injecte Bearer token

            Dio  ->> API  : GET /media/:path

            Note over API : ProtectedMediaView :<br/>vérifie que path contient « user_{request.user.id}/ »

            alt Chemin appartient à l'utilisateur
                API  ->> FS  : Lecture binaire du fichier
                API  -->> Dio: FileResponse (stream binaire)
                Dio  -->> UI : Image affichée (CachedNetworkImage)
                UI   -->> User : Résultat visuel du try-on
            else Chemin appartient à un autre user
                API  -->> Dio: HTTP 403 Forbidden
                Dio  -->> UI : Erreur accès refusé
            end

        else HuggingFace échoue (TryOnAPIException)
            HF   -->> API  : Exception (timeout / connexion / réponse invalide)
            API  ->> DB    : UPDATE TryOnRequest(status=FAILED)
            API  -->> Dio  : HTTP 502 · {error, request_id}
            Dio  -->> Prov : DioException (502)
            Prov ->> Prov  : setState(errorMessage)
            Prov -->> UI   : Affiche SnackBar erreur HuggingFace
        end
    end
```

---

## 3. Diagramme de Classes Django

```mermaid
classDiagram
    class AbstractUser {
        <<Django built-in>>
        +CharField username
        +CharField password
        +CharField first_name
        +CharField last_name
        +BooleanField is_active
        +BooleanField is_staff
        +BooleanField is_superuser
        +DateTimeField date_joined
        +DateTimeField last_login
    }

    class User {
        +BigAutoField id  «PK»
        +EmailField email  «UNIQUE»
        +ManyToManyField groups
        +ManyToManyField user_permissions
    }

    class TryOnRequest {
        +UUIDField id  «PK»
        +ForeignKey user  «FK → User»
        +ImageField person_image
        +ImageField garment_image
        +TextField garment_description  «nullable»
        +ImageField result_image  «nullable»
        +CharField status
        +DateTimeField created_at  «auto»
        +get_status_display() str
    }

    class StatusChoices {
        <<enumeration>>
        PENDING = 'En attente'
        PROCESSING = 'En cours de traitement'
        COMPLETED = 'Terminé'
        FAILED = 'Échoué'
    }

    class TryOnService {
        <<Service Layer>>
        +generate_tryon(person_image_path, garment_image_path, description) str
        -_build_person_dict(path) dict
        -_copy_result_to_media(tmp_path) str
    }

    class TryOnAPIException {
        <<Custom Exception>>
        +message str
    }

    class TryOnListCreateView {
        <<ListCreateAPIView>>
        +permission_classes IsAuthenticated
        +parser_classes MultiPartParser, FormParser
        +serializer_class TryOnRequestSerializer
        +create(request) Response
        +get_queryset() QuerySet~TryOnRequest~
        +get_throttles() list
    }

    class TryOnDetailView {
        <<RetrieveAPIView>>
        +permission_classes IsAuthenticated
        +lookup_field id  «UUID»
        +get_queryset() QuerySet~TryOnRequest~
    }

    class ProtectedMediaView {
        <<APIView>>
        +permission_classes IsAuthenticated
        +get(request, path) FileResponse
    }

    class TryOnRateThrottle {
        <<UserRateThrottle>>
        +scope 'tryon_creation'
        +rate '10/hour'
    }

    class TryOnRequestSerializer {
        <<ModelSerializer>>
        +Meta model TryOnRequest
        +fields [id, user, person_image, garment_image,\ngarment_description, result_image, status, created_at]
        +read_only_fields [id, user, result_image, status, created_at]
    }

    class RegisterView {
        <<CreateAPIView>>
        +permission_classes AllowAny
        +serializer_class UserSerializer
    }

    class UserSerializer {
        <<ModelSerializer>>
        +fields [id, username, email, password]
        +create(validated_data) User
    }

    AbstractUser          <|-- User               : extends
    User                  "1" --> "0..*" TryOnRequest : tryon_requests (CASCADE)
    TryOnRequest          --> StatusChoices        : status choice
    TryOnListCreateView   --> TryOnService         : calls generate_tryon()
    TryOnListCreateView   --> TryOnRateThrottle    : throttle on POST
    TryOnListCreateView   --> TryOnRequestSerializer : serialize
    TryOnDetailView       --> TryOnRequestSerializer : serialize
    TryOnService          ..> TryOnAPIException    : raises on error
    RegisterView          --> UserSerializer       : serialize
    ProtectedMediaView    --> User                 : vérifie ownership via path
```

---

## 4. Schéma Entité-Relation (ERD)

```mermaid
erDiagram
    USER {
        bigint      id              PK  "AUTO_INCREMENT"
        varchar150  username            "UNIQUE, NOT NULL"
        varchar254  email               "UNIQUE, NOT NULL"
        varchar128  password            "hashed (pbkdf2_sha256)"
        varchar150  first_name
        varchar150  last_name
        boolean     is_active           "DEFAULT TRUE"
        boolean     is_staff            "DEFAULT FALSE"
        boolean     is_superuser        "DEFAULT FALSE"
        timestamp   date_joined         "AUTO NOW ADD"
        timestamp   last_login
    }

    TRYON_REQUEST {
        uuid        id              PK  "DEFAULT uuid4"
        bigint      user_id         FK  "→ USER.id  ON DELETE CASCADE"
        varchar100  person_image        "media/tryon_images/user_{id}/{uuid}.jpg"
        varchar100  garment_image       "media/tryon_images/user_{id}/{uuid}.jpg"
        text        garment_description "NULLABLE"
        varchar100  result_image        "NULLABLE"
        varchar20   status              "PENDING|PROCESSING|COMPLETED|FAILED"
        timestamp   created_at          "AUTO NOW ADD"
    }

    AUTH_GROUP {
        int         id  PK
        varchar150  name    "UNIQUE"
    }

    AUTH_PERMISSION {
        int         id              PK
        int         content_type_id FK
        varchar100  codename
        varchar255  name
    }

    USER_GROUPS {
        int  user_id   FK "→ USER.id"
        int  group_id  FK "→ AUTH_GROUP.id"
    }

    USER_USER_PERMISSIONS {
        int  user_id       FK "→ USER.id"
        int  permission_id FK "→ AUTH_PERMISSION.id"
    }

    USER            ||--o{ TRYON_REQUEST        : "possède (1 → N)"
    USER            ||--o{ USER_GROUPS          : "appartient à"
    USER            ||--o{ USER_USER_PERMISSIONS: "dispose de"
    AUTH_GROUP      ||--o{ USER_GROUPS          : "regroupe"
    AUTH_PERMISSION ||--o{ USER_USER_PERMISSIONS: "accordée à"
```

---

## Résumé des relations clés

| Relation | Type | Contrainte |
|---|---|---|
| `User` → `TryOnRequest` | OneToMany (ForeignKey) | `CASCADE` — suppression user = suppression requests |
| `TryOnRequest.person_image` | ImageField | `JPEG/PNG/WebP`, max 10 MB, chemin unique par UUID |
| `TryOnRequest.result_image` | ImageField | `nullable` — null si status ≠ COMPLETED |
| `TryOnRequest.status` | CharField choices | `PENDING → PROCESSING → COMPLETED \| FAILED` |
| `User.email` | EmailField | `UNIQUE` (contrainte custom par rapport à `AbstractUser`) |
