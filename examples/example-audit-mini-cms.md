# Exemple — Audit d'un mini CMS sectoriel

## Contexte

Mini CMS PHP 8 + SQLite généré pour un restaurant client.
Stack alignée sur `CLAUDE_PROJECT_FACTORY.md` du VPS Art of Dev (§20).
Cible : livraison ZIP au client + tournage vidéo YouTube de la création.

## Prompt utilisateur

> *"Audit avant livraison client de ce mini CMS sectoriel restaurant. Mode `VIDEO_PRESENTATION_MODE` activé (je vais filmer la livraison). Vérifie le flow d'install, le dashboard admin, l'export ZIP, la cohérence front/admin, les images, l'absence de mots de passe en dur. Donne le rapport et applique les corrections sûres."*

## Ce que le skill doit analyser

### Phase 1–2

- `manifest.json` (cf. factory file §24) ;
- arborescence (cf. factory file §20) ;
- `INSTALL.md`, `EXPORT.md`, `README.md` ;
- `tools/export-zip.sh` ;
- routes `public/`, `admin/`, `install/`.

### Phase 3 (UX/UI)

- homepage : effet wow ? hero ? CTA visibles ? menu ? footer ?
- responsive 320/768/1024 ;
- design **non template-look** (cf. factory file §15) ;
- cohérence du design avec le secteur restaurant (chaleureux, gastronomique) ;
- galerie + page services + page contact ;
- formulaire de réservation (UX claire, validation, message de succès).

### Phase 4 (technique)

- aucun `var_dump`, `print_r`, `dd()` dans le code ;
- aucune erreur PHP brute affichable ;
- pages 404/500 customisées ;
- aucun chemin serveur (`/var/www/...`) dans le code livré ;
- aucune donnée hardcodée du faux client (nom, slogan, photos client réelles → tout doit être seed remplaçable).

### Phase 5 (sécurité)

- `/admin/` redirige vers `/admin/login` si non auth ;
- mot de passe admin hashé (bcrypt via `password_hash`) ;
- CSRF sur formulaires admin (token sur `<form>` + vérification serveur) ;
- requêtes SQL préparées (PDO + paramètres liés) ;
- uploads : validation MIME via `finfo`, taille max 8 Mo, nom nettoyé, pas d'exécution PHP dans `/uploads/` ;
- `.env.example` présent, `.env` jamais dans le repo ;
- aucun mot de passe en dur — `admin@artofdev.local` / `ChangeMe123!` documentés dans `INSTALL.md` uniquement.

### Phase 6 (SEO / contenu)

- titles unique par page (homepage, menu, contact, mentions) ;
- meta description par page (zéro générique) ;
- un seul H1 par page ;
- alt sur toutes les images ;
- contenu adapté au métier (restaurant) — zéro lorem, zéro phrase IA ;
- `sitemap.xml` et `robots.txt` (avec `/install/` et `/admin/` en disallow).

### Phase 7 (admin / installer)

- `/install/` propre : 12 étapes (cf. factory file §18) ;
- `installed.lock` créé après installation, empêche relance ;
- mot de passe admin par défaut affiché avec mention "À changer" ;
- dashboard admin avec : statistiques (pages, médias, demandes, dernière activité), to-do list, checklist de lancement, raccourcis (cf. factory file §6) ;
- gestion : pages, médias, services, horaires, demandes, paramètres SEO ;
- export ZIP fonctionnel via `tools/export-zip.sh`.

### Phase 8–9 (scoring + rapport)

> Pas de billing → 10 pts redistribués (Tech +5, Sec +5).

### Phase 10 (corrections sûres en mode `VIDEO_PRESENTATION_MODE`)

- **Masquer** dans le rapport : IPs, chemins serveur complets, noms users Linux, `.env` ;
- corriger les `<title>` manquants ;
- compléter les `alt` vides ;
- supprimer les `var_dump` / `print_r` oubliés.

## Résultat attendu

### Score type pour un mini CMS bien généré

| Axe | Score attendu |
|---|---|
| Technique | 75–85 |
| UX/UI | 70–85 (selon richesse design) |
| Sécurité | 70–80 |
| SEO/Contenu | 65–80 |
| Admin/Backoffice | 80–90 (le core est solide) |
| Billing | N/A (redistribué) |
| Déploiement | 55–70 (généralement non encore configuré) |
| **Global** | **70–82** — *Publiable avec corrections* à *Solide* |

### Verdict typique

> *"Solide. Lancement possible après vérification du contenu réel (remplacer les seeds par les vraies données client) et configuration HTTPS sur le serveur cible. Aucun bloquant en dev."*

## Corrections possibles

| Phase | Actions typiques |
|---|---|
| 1 — Bloquants | rares pour un mini CMS bien généré |
| 2 — UX | états vides admin, feedback formulaire réservation |
| 3 — Sécurité | re-vérifier CSRF + uploads + lockfile install |
| 4 — SEO | meta descriptions par page, alt images, sitemap |
| 5 — Finition | hero polish, footer 3 colonnes, hover states |
| 6 — Tests | export ZIP testé en clean room (machine vierge) |

## Points de vigilance (mode `VIDEO_PRESENTATION_MODE`)

- **Aucun chemin `/var/www/...`** ne doit apparaître dans le code, le rapport, ou à l'écran.
- **Aucune IP** locale ou publique du VPS dans les fichiers.
- **Aucun nom Linux** (`adminvps`, `root`) hardcodé ni visible.
- **`cat .env`** : interdit à l'écran. Si nécessaire pour vérifier, faire `ls .env` + lecture mentale par Claude sans afficher le contenu.
- **Mot de passe par défaut** : OK affiché à l'écran s'il est marqué "valeur de dev, à changer".
- **L'export ZIP** doit être testable en direct dans la vidéo : décompresser → lancer `/install/` → admin OK.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
