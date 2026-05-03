# Site map audit — {{PROJECT_NAME}}

> Cartographie des pages du site avec routes, accès, et problèmes détectés.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{ex: Next.js 14 + Prisma}}
- **Mode** : {{audit-only}}

---

## Pages détectées

| Page | Type | Route | Fichier source | Accessible depuis | Liens entrants | Liens sortants | Problème |
|---|---|---|---|---|---|---|---|
| Home | publique | `/` | `app/page.tsx` | menu, footer, logo | très nombreux | 8 | aucun |
| About | publique | `/about` | `app/about/page.tsx` | menu, footer | 3 | 5 | aucun |
| Contact | publique | `/contact` | `app/contact/page.tsx` | menu, footer | 2 | 1 | aucun |
| Pricing | publique | `/pricing` | `app/pricing/page.tsx` | menu | 2 | 4 | absent du footer |
| Login | auth | `/login` | `app/login/page.tsx` | bouton header | 1 | 1 | OK |
| Register | auth | `/register` | `app/register/page.tsx` | bouton header | 1 | 1 | OK |
| Dashboard | admin | `/dashboard` | `app/dashboard/page.tsx` | post-login | 0 | 6 | OK (privé attendu) |
| Admin users | admin | `/admin/users` | `app/admin/users/page.tsx` | sidebar admin | 1 | 4 | OK |
| Legacy page | publique | `/legacy` | `app/legacy/page.tsx` | nulle part | 0 | 2 | **orpheline** |
| Mentions | légales | `/mentions` | `app/mentions/page.tsx` | footer | 1 | 0 | OK |
| RGPD | légales | `/rgpd` | `app/rgpd/page.tsx` | footer | 1 | 0 | OK |

---

## Statistiques

- **Total pages détectées** : {{N}}
- **Pages publiques** : {{N}}
- **Pages admin** : {{N}}
- **Pages auth** : {{N}}
- **Pages légales** : {{N}}
- **Pages orphelines** : {{N}}
- **Pages multilingues** : {{N par langue}}

---

## Pages orphelines détectées

| Page | Route | Fichier | Pourquoi orpheline | Recommandation |
|---|---|---|---|---|
| Legacy | `/legacy` | `app/legacy/page.tsx` | aucun lien dans le code ne pointe vers elle | demander à l'utilisateur : à supprimer ou rediriger ? |
| Old-services | `/old-services` | `app/old-services/page.tsx` | route déclarée mais aucun lien | redirection 301 vers `/services` |

---

## Pages liées mais inexistantes (liens morts)

| Lien | Trouvé dans | Route attendue | Recommandation |
|---|---|---|---|
| `/blog/post-123` | `app/components/Footer.tsx:32` | `/blog/[slug]` | vérifier que la route dynamique fonctionne pour `post-123` |
| `/contat` | `app/page.tsx:48` | `/contact` (typo) | corriger la typo |

---

## Routes concurrentes

| Route 1 | Route 2 | Recommandation |
|---|---|---|
| `/about` | `/about-us` | choisir la canonique, redirection 301 sur l'autre |
| `/contact` | `/nous-contacter` | si multilingue → utiliser `/fr/contact` + `/en/contact` |

---

## Carte de navigation visuelle (textuelle)

```
                        Home (/)
                          ├── About (/about)
                          ├── Pricing (/pricing)
                          ├── Contact (/contact)
                          │     └── (pas de pages enfant)
                          ├── Blog (/blog)
                          │     └── Post (/blog/[slug])
                          └── Login (/login)
                                ├── Dashboard (/dashboard)  [auth]
                                │     ├── Profile (/dashboard/profile)
                                │     └── Settings (/dashboard/settings)
                                └── Admin (/admin)         [admin only]
                                      ├── Users (/admin/users)
                                      └── Orders (/admin/orders)

Footer-only :
                          ├── Mentions (/mentions)
                          ├── RGPD (/rgpd)
                          └── CGV (/cgv)

Orphelines :
                          ├── Legacy (/legacy)
                          └── Old-services (/old-services)
```

---

## Recommandations

### Pages orphelines
- {{décision sur chacune}}

### Liens morts
- {{correction par lien}}

### Routes concurrentes
- {{plan de consolidation}}

### Pages manquantes (à créer si applicable)
- {{ex: page /pricing manque dans la version EN d'un site multilingue}}

---

## Prochaine étape

> {{Une phrase actionnable.}}

---

Created by João de Almeida
