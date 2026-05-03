# Rapport de validation multilingue — `{nom-du-projet}`

> Date : `{YYYY-MM-DD}`
> Auteur : `{nom}`
> Skill exécuté : `multilingual-site-engine` ({mode-1-audit | mode-2-plan | mode-3-traduction | mode-4-seo})
> Stack détectée : `{php-static | nextjs | wordpress-theme | laravel | autre}`
> Langues : source `{xx}` → cibles `{xx, yy, zz}`

Created by João de Almeida

---

## 1. Cadrage langues

| Item | Valeur |
|---|---|
| Langue source | `{fr}` |
| Langues cibles | `{en, de}` |
| Langue par défaut | `{fr}` |
| Locales régionales spécifiques | `{aucune | fr-CH, en-US, ...}` |
| Fallback configuré | `{oui/non}` |

---

## 2. Stack et architecture i18n détectées

- **Framework / CMS** : `{...}`
- **Bibliothèque i18n** : `{next-intl | i18next | gettext | Polylang | WPML | aucune}`
- **Format de fichiers** : `{JSON | PO/MO | PHP arrays | YAML}`
- **Routing locale** : `{sous-dossier | sous-domaine | domaine séparé | paramètre}`
- **Détection de langue** : `{URL | cookie | header | sélecteur}`

---

## 3. Inventaire textuel

| Type | Fichiers concernés | État |
|---|---|---|
| Pages publiques | `{liste}` | `{traduit / partiel / hardcodé}` |
| Menus | `{...}` | `{...}` |
| Footers | `{...}` | `{...}` |
| Formulaires | `{...}` | `{...}` |
| Erreurs | `{...}` | `{...}` |
| Emails transactionnels | `{...}` | `{...}` |
| Metadata SEO | `{...}` | `{...}` |
| Microcopies | `{...}` | `{...}` |

---

## 4. Variables et placeholders détectés

| Pattern | Occurrences | Préservé ? |
|---|---|---|
| `{name}` | `{n}` | `{oui/non}` |
| `{{count}}` | `{n}` | `{oui/non}` |
| `%s`, `%d` | `{n}` | `{oui/non}` |
| `%1$s`, `%2$s` | `{n}` | `{oui/non}` |
| `:user`, `:count` | `{n}` | `{oui/non}` |
| `${var}` | `{n}` | `{oui/non}` |
| `<0>...</0>` | `{n}` | `{oui/non}` |
| `__()`, `_e()` | `{n}` | `{oui/non}` |

Cf. `references/placeholders-and-dynamic-content-rules.md`.

---

## 5. Détection style IA

| Signal | Occurrences | Action |
|---|---|---|
| Tirets longs `—` (> 2 / paragraphe) | `{n}` | `{corrigé / signalé / ignoré}` |
| *"Dans le monde d'aujourd'hui"* | `{n}` | `{...}` |
| *"Solution innovante / révolutionnaire"* | `{n}` | `{...}` |
| *"Expérience fluide / interface intuitive"* | `{n}` | `{...}` |
| *"De plus en plus / il est important de"* | `{n}` | `{...}` |
| Conclusions vides | `{n}` | `{...}` |

---

## 6. SEO multilingue

- [ ] balises `hreflang` réciproques sur chaque page
- [ ] `x-default` présent
- [ ] `<html lang>` correct par locale
- [ ] `canonical` correct par version
- [ ] `<title>` traduit
- [ ] `<meta description>` traduite
- [ ] OpenGraph + `og:locale:alternate`
- [ ] sitemap multilingue
- [ ] pas de redirection auto par `Accept-Language`

---

## 7. Routes et slugs

- **Stratégie choisie** : `{sous-dossier | sous-domaine | ...}`
- **Slugs traduits** : `{oui/non}`
- **Mapping** : `{voir tableau / liste de redirections}`

---

## 8. Formulaires / erreurs / emails

- [ ] labels traduits
- [ ] placeholders traduits
- [ ] erreurs validation client traduites
- [ ] erreurs validation serveur traduites
- [ ] messages succès traduits
- [ ] sujet email traduit
- [ ] corps email traduit
- [ ] CTA email traduit
- [ ] footer email traduit (désinscription, mentions)

---

## 9. Formats locaux et RTL

- [ ] dates au format local
- [ ] heures au format local
- [ ] nombres formatés
- [ ] monnaie formatée
- [ ] pluriels gérés
- [ ] RTL géré (si applicable)

---

## 10. Risques détectés

| Risque | Sévérité | Action recommandée |
|---|---|---|
| `{description}` | `{critique / majeur / mineur}` | `{...}` |

---

## 11. Fichiers modifiés

| Fichier | Action | Lignes affectées |
|---|---|---|
| `{path}` | `{créé / modifié / supprimé}` | `{n}` |

---

## 12. Scores

### Translation Quality Score : `{0-100}`/100

| Critère | Score | Sur |
|---|---|---|
| Fidélité au sens | `{n}` | 18 |
| Naturel | `{n}` | 16 |
| Adaptation culturelle | `{n}` | 12 |
| Préservation variables | `{n}` | 12 |
| Cohérence terminologique | `{n}` | 10 |
| Adaptation registre UI | `{n}` | 8 |
| Absence style IA | `{n}` | 10 |
| Ponctuation locale | `{n}` | 6 |
| Grammaire / orthographe | `{n}` | 8 |
| **Total** | **`{n}`** | **100** |

### Multilingual Site Readiness Score : `{0-100}`/100

| Critère | Score | Sur |
|---|---|---|
| Pages clés traduites | `{n}` | 12 |
| Menus + footers traduits | `{n}` | 10 |
| Formulaires + erreurs + emails | `{n}` | 10 |
| Metadata SEO | `{n}` | 10 |
| `hreflang` réciproque | `{n}` | 10 |
| Balises `lang` correctes | `{n}` | 5 |
| Slugs / routes cohérents | `{n}` | 8 |
| Switch langue | `{n}` | 6 |
| Formats locaux | `{n}` | 6 |
| RTL géré (si applicable) | `{n}` | 5 |
| Fallbacks gérés | `{n}` | 6 |
| Sitemap multilingue | `{n}` | 6 |
| Pas de hardcoding bloquant | `{n}` | 6 |
| **Total** | **`{n}`** | **100** |

---

## 13. Prochaine étape (1 phrase)

`{action concrète à effectuer dans la prochaine session}`

---

Created by João de Almeida
