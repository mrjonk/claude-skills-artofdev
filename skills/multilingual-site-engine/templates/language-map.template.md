# Carte des langues — {{PROJECT_NAME}}

> Cartographie complète des langues, locales, fallbacks et points d'entrée.
> Created by João de Almeida

---

## 1. Langues actives

| Locale | Nom natif | Direction | URL pattern | Statut |
|---|---|---|---|---|
| `{{fr-FR}}` | Français | LTR | `/{{fr}}/...` | actif |
| `{{en-US}}` | English | LTR | `/{{en}}/...` | actif |
| `{{de-DE}}` | Deutsch | LTR | `/{{de}}/...` | actif |
| `{{ar-SA}}` | العربية | RTL | `/{{ar}}/...` | en cours |

---

## 2. Locale par défaut et fallback

- **Locale par défaut** : `{{fr-FR}}`
- **Affichage si locale demandée non disponible** : {{redirection vers défaut / fallback transparent}}
- **Affichage si traduction d'une page manque** : {{fallback langue par défaut / 404 traduite}}

---

## 3. Détection de la langue

| Méthode | Utilisée | Priorité |
|---|---|---|
| URL (segment) | {{oui / non}} | 1 |
| Cookie | {{oui / non}} | 2 |
| Local storage | {{oui / non}} | 3 |
| `Accept-Language` (header) | {{**à éviter** sauf cas précis}} | n/a |
| Sélecteur user dans UI | oui | bouton |

---

## 4. Mapping de routes

| Page logique | `fr` | `en` | `de` |
|---|---|---|---|
| home | `/fr/` | `/en/` | `/de/` |
| about | `/fr/a-propos` | `/en/about` | `/de/uber-uns` |
| contact | `/fr/contact` | `/en/contact` | `/de/kontakt` |
| pricing | `/fr/tarifs` | `/en/pricing` | `/de/preise` |
| blog | `/fr/journal` | `/en/blog` | `/de/blog` |

---

## 5. Stratégie URL choisie

- {{sous-dossier / sous-domaine / domaine séparé / paramètre / slug traduit}}

---

## 6. Sitemaps

- **un seul sitemap** avec `xhtml:link` ;
- ou **un sitemap par langue** + sitemap index :

```
sitemap.xml (index)
├── sitemap-fr.xml
├── sitemap-en.xml
└── sitemap-de.xml
```

Choix : {{...}}

---

## 7. Points d'entrée linguistiques

- **switch langue** : présent dans {{header / footer / les deux}}
- **format du switch** : {{drapeaux / codes ISO / nom natif}}
- **redirige vers** : {{même page traduite / home}}
- **persistance du choix** : {{cookie / storage / aucune}}

---

## 8. Couverture par section

| Section | `fr` | `en` | `de` |
|---|---|---|---|
| Pages publiques | 100 % | 95 % | 60 % |
| Auth | 100 % | 100 % | 30 % |
| Légal | 100 % | 100 % | 0 % |
| Emails | 100 % | 80 % | 0 % |
| Blog | 100 % | 50 % | 0 % |

→ Identifie les zones à compléter.

---

## 9. Variantes régionales

| Locale | Servie par | Notes |
|---|---|---|
| `fr-FR` | par défaut FR | locale principale |
| `fr-CH` | fallback `fr-FR` | adresses Suisse seulement |
| `pt-BR` | servie séparément | distincte de `pt-PT` |

---

## 10. Notes d'arbitrage

- {{ex: on n'ouvre pas l'allemand tant que les emails ne sont pas traduits}}
- {{ex: l'arabe attend la refonte RTL avec `premium-webdesigner`}}
- {{ex: on garde les slugs anglais pour `/api`, `/admin`, `/dashboard`}}

---

Created by João de Almeida
