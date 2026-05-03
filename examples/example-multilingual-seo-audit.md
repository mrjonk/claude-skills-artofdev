# Exemple — Audit SEO multilingue d'un site existant

> Cas concret : un site multilingue déjà en ligne, mais le SEO multilingue est mal configuré.

Created by João de Almeida

---

## Demande utilisateur

> *"Mon site existe en FR, EN, DE depuis 6 mois mais le ranking ne décolle pas
> sur les marchés EN et DE. Je soupçonne un problème de SEO multilingue.
> Audite hreflang, lang, canonical, sitemap, slugs, metadata. Mode 1 audit
> seul."*

---

## Question à poser

> *"Avant de commencer :*
> *1. Confirmes-tu les 3 langues actuelles : fr-FR, en-US ou en-GB, de-DE ?*
> *2. Stratégie d'URL utilisée (sous-dossier, sous-domaine, autre) ?*
> *3. As-tu Google Search Console en accès, ou je travaille uniquement sur le*
> *code et le rendu HTML ?*
> *4. Y a-t-il un sitemap.xml accessible ? URL ?"*

---

## Fichiers à inspecter

```
app/
├── [locale]/
│   ├── layout.tsx
│   └── ...
├── sitemap.ts
└── robots.ts
public/
└── (rien lié à i18n)
```

Et :

- `https://site.com/sitemap.xml` (à fetch) ;
- `https://site.com/robots.txt` ;
- échantillon de pages rendues (FR, EN, DE) pour vérifier le HTML produit.

---

## Étape 1 — Hreflang

### Méthode

1. Inspecter les balises `<link rel="alternate" hreflang="...">` sur 10 pages au hasard de chaque langue.
2. Vérifier la **réciprocité** (chaque page liste toutes les versions).
3. Vérifier `x-default`.
4. Vérifier que les URL sont **absolues**.

### Résultats observés

| Constat | Pages |
|---|---|
| Hreflang absent | 47 |
| Hreflang non réciproque | 23 |
| URL relative au lieu d'absolue | 12 |
| `x-default` manquant | 100 % |
| Code de langue invalide (`hreflang="english"`) | 4 |

→ **Score hreflang : 3 / 10**.

---

## Étape 2 — Balise `<html lang>`

### Résultats observés

- pages `/fr/` → `<html lang="fr">` : OK ;
- pages `/en/` → `<html lang="fr">` figé : KO sur 92 pages ;
- pages `/de/` → `<html lang="fr">` figé : KO sur 78 pages.

→ **Score lang : 1 / 5**.

---

## Étape 3 — Canonical

### Résultats observés

| Constat | Nombre |
|---|---|
| Canonical correct (self) | 89 |
| Canonical pointant vers `/en/` (source par défaut) | 124 |
| Canonical absent | 12 |

Sur les pages /fr/ et /de/, le canonical pointe vers `/en/` → **catastrophe SEO**.

→ **Score canonical : 1 / 3**.

---

## Étape 4 — Metadata

### Résultats observés

| Locale | `<title>` traduit | `<meta description>` traduite | OG traduit |
|---|---|---|---|
| FR | 100 % | 95 % | 70 % |
| EN | 100 % | 100 % | 80 % |
| DE | 60 % (40 % en EN) | 50 % | 30 % |

→ La version DE est **largement non traduite** côté metadata.

---

## Étape 5 — Sitemap

### Résultats observés

```xml
<urlset>
  <url>
    <loc>https://site.com/en/</loc>
  </url>
  <url>
    <loc>https://site.com/en/about</loc>
  </url>
  <!-- les pages /fr/ et /de/ sont absentes -->
</urlset>
```

→ **Sitemap monolingue, ne déclare pas /fr/ ni /de/**.
→ **Score sitemap : 0 / 6**.

---

## Étape 6 — Robots.txt

```
User-agent: *
Allow: /
Sitemap: https://site.com/sitemap.xml
```

→ OK pour la base, mais le sitemap pointé est mauvais.

---

## Étape 7 — Switch langue

- présent dans le header ;
- redirige toujours vers `/{locale}/` (perte du chemin courant) ;
- pas de mémorisation du choix.

→ UX médiocre.

---

## Étape 8 — Redirection automatique

### Résultats observés

```js
// middleware.ts
if (request.headers.get('Accept-Language')?.startsWith('en')) {
  return NextResponse.redirect('/en/');
}
```

→ **Redirection auto par navigateur** : mauvaise pratique SEO + UX.

---

## Score SEO multilingue

| Critère | Poids | Score |
|---|---|---|
| Metadata SEO traduites | 10 | 6 |
| `hreflang` correct et réciproque | 10 | 3 |
| `<html lang>` correct | 5 | 1 |
| Slugs / routes cohérents | 8 | 6 |
| Sitemap multilingue | 6 | 0 |
| `og:locale` / alternate | 3 | 1 |
| Canonical correct | 3 | 1 |
| **Total partiel SEO** | **45** | **18** |

---

## Top 10 corrections à effectuer

1. **Corriger `<html lang>`** dynamique sur toutes les pages traduites.
2. **Corriger les canonical** pour qu'ils pointent sur la version courante.
3. **Générer hreflang réciproques** sur toutes les pages traduites.
4. **Ajouter `x-default`** pointant vers la langue par défaut.
5. **Reconstruire le sitemap** avec `xhtml:link` pour toutes les versions.
6. **Traduire les metadata DE** manquantes (40 % des titles, 50 % des descriptions).
7. **Désactiver la redirection auto** sur `Accept-Language`.
8. **Ajouter une bannière** *"This page is available in EN/DE/FR — switch?"*.
9. **Faire que le switch langue** redirige vers la même page traduite (pas vers `/{locale}/`).
10. **Resoumettre le sitemap** dans Search Console.

---

## Rapport (extrait)

```markdown
## Score
- Multilingual Site Readiness : 47 / 100 (sous-score SEO : 18 / 45)

## Verdict
Le site est multilingue dans le code, mais le SEO multilingue est cassé.
Les versions FR et DE sont quasi invisibles pour Google car le canonical
pointe vers EN, le sitemap ne les déclare pas, et hreflang est absent ou
non réciproque sur 70 pages.

## Top 3 actions immédiates
1. Corriger les canonical (impact SEO critique).
2. Générer hreflang réciproques + x-default.
3. Reconstruire le sitemap multilingue.

## Délégations
- aucune nécessaire à ce stade.

## Prochaine étape
Passer en mode 4 (SEO multilingue final) pour exécuter les corrections.
```

---

## Score attendu après correction

| Critère | Avant | Après |
|---|---|---|
| Multilingual Site Readiness | 47 | 85+ |
| Sous-score SEO | 18 / 45 | 40 / 45 |

Et un ranking qui devrait remonter sur 4-8 semaines après resoumission Search Console.

---

Created by João de Almeida
