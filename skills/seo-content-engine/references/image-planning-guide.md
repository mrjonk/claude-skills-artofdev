# Guide de planification d'images — `seo-content-engine`

Comment choisir, prompt, et documenter chaque image d'un contenu.

Created by João de Almeida

---

## 1. Pour chaque article, prévoir

### Image principale (hero)

**Obligatoire** sauf cas très court (FAQ standalone, glossaire).

À définir :

- **description** précise du visuel ;
- **style** (photographique réaliste, illustration plate, isométrique, 3D, abstrait, schéma) ;
- **mots-clés de recherche** (pour banque d'images) **OU** prompt IA détaillé ;
- **alt text** ;
- **emplacement** : juste sous le H1, ou intégré au début de l'article.

### Images secondaires

Optionnelles, à utiliser quand :

- l'article est **long** (> 1500 mots) — aération visuelle ;
- des **étapes** d'un tutoriel bénéficient d'illustrations ;
- une **donnée** est mieux comprise en graphique ;
- une **architecture** est mieux comprise en schéma.

**Ne pas saturer** : une image **par section** maximum est un bon ratio.

---

## 2. Cohérence visuelle

**Règle :** un seul **style** par article.

| Choix de style | Cohérence requise |
|---|---|
| Photographique | toutes les images en photo, mêmes ambiances de couleur |
| Illustration plate | toutes les images en illustration vectorielle, palette cohérente |
| 3D / isométrique | toutes les images en 3D, perspective et style identiques |
| Schémas / diagrammes | tous les schémas avec mêmes couleurs, mêmes formes, même police |

**Anti-pattern :** un hero photographique + un schéma stylisé + une illustration plate dans le même article = chaos visuel.

---

## 3. Mots-clés / prompts par type d'article

### Article tech / dev

- mots-clés : `code on screen`, `developer workspace`, `terminal interface`, `abstract code`, `data visualization`, `clean workstation` ;
- éviter : mains anonymes sur clavier, lunettes sur livre.

### Article SaaS / business

- mots-clés : `dashboard interface`, `team collaboration` (réel, pas posé), `workflow diagram`, `abstract gradient` ;
- éviter : équipe en costume autour table, poignée de main, ampoule.

### Tutoriel

- captures d'écran **réelles** de l'outil ;
- diagrammes simples ;
- éviter : photos abstraites sans lien.

### Article culturel / créatif

- visuel **précis** au sujet (lieu, époque, personne) ;
- photographie **descriptive** ;
- éviter : stock générique.

### Article scientifique

- **graphiques** issus des sources citées ;
- **schémas** explicatifs ;
- éviter : illustrations marketing décoratives.

---

## 4. Comment écrire un bon prompt IA

Un prompt vague produit une image vague. Décomposer :

| Élément | Exemple |
|---|---|
| **Sujet principal** | "Une développeuse codant sur un laptop" |
| **Composition / cadrage** | "vue de dessus, cadrage serré sur les mains et l'écran" |
| **Lumière** | "lumière naturelle de fenêtre à gauche, ambiance matin" |
| **Style** | "photographique réaliste, profondeur de champ légère" |
| **Couleurs** | "palette neutre, accents bleus discrets" |
| **Ambiance** | "calme, focus, professionnel" |
| **Ce qu'on évite** | "pas de personne souriant à la caméra, pas de costume corporate" |

### Exemple de prompt complet

```
Photographic, top-down close-up of female developer hands on a mechanical
keyboard, mid-typing. Backlit by soft window light from the left, warm
morning ambience. Background: blurred wooden desk, ceramic mug, plant.
Color palette: muted tones with subtle blue accents on screen. Mood:
focused, professional, calm. NOT corporate stock, NOT smiling at camera.
3:2 aspect ratio.
```

---

## 5. Alt text

### Règles

- **non vide** sur images informatives ;
- **vide explicite** (`alt=""`) sur images décoratives ;
- **descriptif** : que représente l'image ?
- **court** : ≤ 125 caractères idéalement ;
- **localisé** (français si site français) ;
- **ne répète pas** le `<title>` ou la légende ;
- **sans** "image de" ou "photo de" (le screen reader le sait déjà).

### Exemples

- ✅ `alt="Tableau de bord de gestion de tâches montrant 4 KPI : tâches du jour, en retard, terminées, et taux de complétion."`
- ✅ `alt=""` (image décoratrice du fond du hero)
- ❌ `alt="image"`
- ❌ `alt="hero"`
- ❌ `alt="dashboard.jpg"`

---

## 6. Emplacement dans l'article

| Position | Type d'image |
|---|---|
| Sous le H1 (hero) | image principale |
| Au milieu d'une section longue | image qui illustre la section (capture, schéma) |
| Avant une FAQ | optionnel (illustration sympathique) |
| En entête de section "Pour aller plus loin" | optionnel |

**Règle :** une image qui ne sert pas le texte = à supprimer.

---

## 7. Banques d'images recommandées (libres)

| Banque | URL | Licence | Notes |
|---|---|---|---|
| Unsplash | https://unsplash.com | Unsplash License (libre, commercial OK, attribution appréciée) | qualité photographique élevée |
| Pixabay | https://pixabay.com | Pixabay Content License (libre, commercial OK) | photos + illustrations + vidéos |
| Pexels | https://pexels.com | Pexels License (libre, commercial OK) | photos + vidéos |
| Freepik (free) | https://freepik.com | attribution requise pour le free tier | illustrations vectorielles |

**Toujours vérifier** la licence à la date d'utilisation — elles peuvent évoluer.

---

## 8. Format imposé pour le plan d'images

À remplir dans `templates/image-plan.template.md` :

```markdown
| Slot | Description | Style | Prompt IA / Mots-clés | Alt text | Emplacement | Source | Crédit |
|------|-------------|-------|-----------------------|----------|-------------|--------|--------|
| Hero | Développeuse codant sur laptop, vue de dessus | Photo réaliste | "top-down close-up female dev hands on mechanical keyboard, soft window light..." | "Mains d'une développeuse sur un clavier mécanique, vue de dessus, lumière naturelle." | Sous le H1 | Unsplash | Photographer Name (URL) |
| Section 2 | Diagramme du flow | Vectoriel | (créé en interne avec Excalidraw) | "Diagramme du flow utilisateur en 4 étapes : connexion, dashboard, action, validation." | Au milieu de la section "Comment ça marche" | interne | non |
```

---

## 9. Anti-patterns à proscrire

- équipe en costume autour table en verre ;
- mains anonymes sur clavier ;
- ampoule lumineuse symbolisant "idée" ;
- poignée de main symbolisant "deal" ;
- robot mignon symbolisant "IA" ;
- flèche montante symbolisant "growth" ;
- city skyline at night sans rapport ;
- gens souriant **à la caméra** dans un contexte business (forcé, stock cliché) ;
- mix de styles dans le même article (cohérence absolue requise) ;
- images décoratives **lourdes** (> 500 Ko sur un article web).

---

## 10. Optimisation technique

Avant utilisation en prod (à mentionner dans le plan) :

- **format** : WebP qualité 80–85 (fallback JPEG) ;
- **dimensions** : adapter à l'usage (hero 1920 × 960 max, illustration de section 1200 × 800 max) ;
- **lazy-load** : `loading="lazy"` sur images sous la ligne de flottaison ;
- **eager** + `fetchpriority="high"` : sur le hero LCP ;
- **`width`** + **`height`** explicites pour éviter CLS ;
- **`<picture>`** avec srcset pour responsive.

---

## 11. Checklist images (relecture finale)

- [ ] **image principale** présente avec description complète ;
- [ ] **style** unique sur tout l'article ;
- [ ] **alt text** non vide sur images informatives ;
- [ ] **alt=""** sur images décoratives ;
- [ ] **prompts IA** détaillés (pas vagues) ;
- [ ] **mots-clés** précis pour banque d'images ;
- [ ] **licences** vérifiées si source externe ;
- [ ] **crédit** photographe ajouté si requis (Unsplash : appréciée, Pixabay : non requise) ;
- [ ] **emplacement** précisé pour chaque image ;
- [ ] aucun **cliché** stock (cf. §9) ;
- [ ] **optimisation** documentée (format, dimensions, lazy-load).

---

Created by João de Almeida
