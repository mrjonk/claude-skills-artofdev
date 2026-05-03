# Rapport SEO multilingue — {{PROJECT_NAME}}

> Audit SEO multilingue : balises hreflang, lang, canonical, metadata, sitemap.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Domaine** : {{ex: site.com}}
- **Stratégie URL** : {{sous-dossier / sous-domaine / domaine séparé / autre}}
- **Langues actives** : {{liste}}
- **Pages auditées** : {{N}}

---

## Score SEO multilingue (sous-section du Multilingual Site Readiness Score)

| Critère | Poids | Score |
|---|---|---|
| Metadata SEO traduites (title, desc) | 10 | {{n / 10}} |
| `hreflang` correct et réciproque | 10 | {{n / 10}} |
| Balises `<html lang>` correctes | 5 | {{n / 5}} |
| Slugs / routes cohérents | 8 | {{n / 8}} |
| Sitemap multilingue | 6 | {{n / 6}} |
| `og:locale` / `og:locale:alternate` | 3 | {{n / 3}} |
| Canonical correct par version | 3 | {{n / 3}} |
| **Total partiel SEO** | **45** | **{{X / 45}}** |

---

## Hreflang

### Couverture

| Page | Versions déclarées | Réciproque | `x-default` | Statut |
|---|---|---|---|---|
| `/fr/` | fr, en, de | oui | oui | OK |
| `/en/` | fr, en, de | oui | oui | OK |
| `/fr/contact` | fr, en | non | non | KO |
| {{...}} | | | | |

### Problèmes détectés

| Type | Nombre |
|---|---|
| Pages sans hreflang | {{N}} |
| Hreflang non réciproque | {{N}} |
| Hreflang vers URL invalide | {{N}} |
| Code de langue invalide | {{N}} |
| `x-default` manquant | {{N}} |
| URL relative | {{N}} |

---

## `<html lang>`

| Locale | Pages avec `lang` correct | Pages incorrectes |
|---|---|---|
| `fr` | {{N}} | {{N}} |
| `en` | {{N}} | {{N}} |
| `de` | {{N}} | {{N}} |

### Problèmes

- {{ex: 12 pages /en/ avec `<html lang="fr">` figé}}

---

## Canonical

| Statut | Nombre de pages |
|---|---|
| Canonical correct (self) | {{N}} |
| Canonical pointant vers source | {{N}} (problème) |
| Canonical absent | {{N}} |
| Canonical avec paramètres | {{N}} |

---

## Metadata

| Page | `<title>` traduit | `<meta description>` traduite | OG traduit |
|---|---|---|---|
| `/fr/` | oui | oui | oui |
| `/en/` | oui | oui | partiel |
| `/de/` | non | non | non |

### Couverture globale

- titles traduits : {{X / Y pages}}
- descriptions traduites : {{X / Y}}
- balises OG traduites : {{X / Y}}

---

## Sitemap multilingue

- **Format** : {{sitemap unique avec `xhtml:link` / sitemap par langue + index / autre}}
- **URL** : `{{site.com/sitemap.xml}}`
- **Pages déclarées par langue** : `fr` {{N}}, `en` {{N}}, `de` {{N}}
- **Soumis à Google Search Console** : {{oui / non}}
- **Soumis à Bing Webmaster** : {{oui / non}}

### Problèmes

- {{ex: pages traduites manquantes du sitemap}}
- {{ex: balises `xhtml:link` non identiques entre entrées d'une même page}}

---

## Routes / slugs

- **Stratégie** : {{...}}
- **Mapping de slugs** : {{présent / absent}}
- **Collisions détectées** : {{N}}
- **Liens internes localisés** : {{X / Y}}

---

## Robots.txt

- présent : {{oui / non}}
- bloque les versions traduites : {{oui / non}}
- réfère le sitemap : {{oui / non}}

---

## Switch langue

- présent partout : {{oui / non}}
- redirige vers la même page traduite : {{oui / non}}
- pas de redirection auto par `Accept-Language` : {{oui / non}}
- mémorise le choix : {{oui / non}}

---

## Problèmes critiques

### SEO-CRIT-001 — {{Titre court}}

- **Type** : {{hreflang / canonical / lang / metadata / sitemap}}
- **Pages** : {{liste}}
- **Impact SEO** : {{description}}
- **Correction** : {{description}}

---

## Problèmes importants

### SEO-IMP-001 — {{...}}

- ...

---

## Problèmes mineurs

### SEO-MIN-001 — {{...}}

- ...

---

## Top 5 actions SEO

1. {{ex: ajouter hreflang sur les 47 pages /fr/}}
2. {{ex: corriger les canonical de la version EN}}
3. {{ex: traduire les meta descriptions des pages produit}}
4. {{ex: générer le sitemap multilingue}}
5. {{ex: désactiver la redirection auto par navigateur}}

---

## Vérifications post-correction

- [ ] crawler le site avec un outil ;
- [ ] vérifier la **réciprocité** des hreflang ;
- [ ] tester `<html lang>` sur 10 pages au hasard ;
- [ ] tester `canonical` sur 10 pages au hasard ;
- [ ] resoumettre le sitemap dans Search Console ;
- [ ] suivre l'évolution dans Search Console pendant 2-4 semaines.

---

## Prochaine étape

> {{Une seule phrase actionnable.}}

---

Created by João de Almeida
