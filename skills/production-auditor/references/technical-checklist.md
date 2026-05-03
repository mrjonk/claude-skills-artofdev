# Checklist technique — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

Liste opérationnelle, à dérouler en phase 4 (audit technique).

---

## 1. Build

- [ ] le build passe (`npm run build`, `composer dump-autoload`, `pip install`, etc.) ;
- [ ] aucun warning critique au build ;
- [ ] taille du bundle raisonnable (< 1 Mo gzip pour un site vitrine, < 2 Mo pour un SaaS) ;
- [ ] sourcemaps désactivées en production (ou hors du repo public) ;
- [ ] artefacts de build (`dist/`, `build/`, `.next/`) **non commit és** mais générables.

---

## 2. Dépendances

- [ ] `package-lock.json` / `composer.lock` / `requirements.txt` figés ;
- [ ] `engines` / `php` / `python_requires` documentés ;
- [ ] aucune dépendance dépréciée critique ;
- [ ] aucune dépendance avec une CVE haute connue ;
- [ ] pas de dépendance "abandonware" (dernier release > 3 ans pour un package critique) ;
- [ ] `npm audit` / `pip-audit` / `composer audit` clean (ou warnings documentés).

---

## 3. Scripts

- [ ] `start`, `dev`, `build`, `test`, `lint` documentés ;
- [ ] scripts shell en `set -euo pipefail` ;
- [ ] aucun script ne contient de chemin absolu spécifique au VPS ;
- [ ] aucun script ne contient de credentials.

---

## 4. Logs

- [ ] pas de `console.log` / `var_dump` / `print_r` / `dd()` / `dump()` oublié ;
- [ ] niveau de log configurable (`info` / `debug` / `error`) ;
- [ ] les logs ne contiennent pas de données sensibles (mots de passe, tokens, données personnelles brutes) ;
- [ ] rotation des logs en place ou taille bornée.

---

## 5. Configuration

- [ ] `.env.example` présent, à jour, avec toutes les variables ;
- [ ] `.env` jamais dans le repo ;
- [ ] pas de constante hardcodée qui devrait être une variable d'environnement (URL prod, email admin, IP, secret) ;
- [ ] config différenciée dev/staging/prod si applicable ;
- [ ] mode `debug` désactivable proprement.

---

## 6. Routes / API

- [ ] toutes les routes documentées dans `README` ou `docs/architecture.md` ;
- [ ] aucune route orpheline (page accessible mais pas dans le menu) ;
- [ ] aucune route 404 dans les liens internes ;
- [ ] codes HTTP corrects (`200`, `201`, `400`, `401`, `403`, `404`, `500`) ;
- [ ] pas de stack-trace HTTP `500` exposé ;
- [ ] page `404` custom ;
- [ ] page `500` custom (pas l'écran serveur brut).

---

## 7. Base de données

- [ ] schéma documenté (migrations, ERD ou `docs/architecture.md`) ;
- [ ] requêtes préparées (paramètres liés, pas de concaténation) ;
- [ ] index sur les colonnes filtrées/triées fréquemment ;
- [ ] migrations versionnées et idempotentes ;
- [ ] seed de démo séparable des données de prod ;
- [ ] aucun dump SQL avec données réelles dans le repo.

---

## 8. Données hardcodées

- [ ] pas d'email admin codé en dur dans plusieurs fichiers ;
- [ ] pas de slogan / nom client codé en dur (devrait être configurable) ;
- [ ] pas d'URL de prod codée en dur (devrait venir de `.env`) ;
- [ ] pas de chemin absolu serveur (`/var/www/...`, `/home/...`) ;
- [ ] pas d'IP locale ou publique du VPS.

---

## 9. Uploads

- [ ] dossier d'upload séparé et configurable ;
- [ ] validation MIME côté serveur (pas seulement côté client) ;
- [ ] validation taille (< 8 Mo par défaut, configurable) ;
- [ ] noms de fichiers nettoyés (pas de `../`, pas de caractères dangereux) ;
- [ ] pas d'exécution de fichiers uploadés (pas de `.php` exécutable dans `/uploads/`) ;
- [ ] images optimisées si possible (compression, WebP).

---

## 10. Gestion d'erreurs

- [ ] try/catch / error handling dans les points critiques (DB, API externes, file I/O) ;
- [ ] messages d'erreur **utiles côté admin**, **génériques côté public** ;
- [ ] aucune erreur PHP brute affichée publiquement ;
- [ ] aucune `TypeError` / `ReferenceError` non gérée en runtime ;
- [ ] page 404 et 500 personnalisées et silencieuses sur les détails techniques.

---

## 11. Tests

- [ ] présence d'au moins quelques tests (smoke tests minimum) ;
- [ ] commande `npm test` / `pytest` / `phpunit` qui passe ;
- [ ] couverture des points critiques (auth, paiement, upload) si SaaS ;
- [ ] tests **non flaky** (pas de tests qui échouent un run sur deux).

---

## 12. Performance

- [ ] page d'accueil < 2 s sur connexion rapide ;
- [ ] images compressées (pas de PNG 8 Mo pour un hero) ;
- [ ] lazy-loading sur images en dessous de la ligne de flottaison ;
- [ ] cache HTTP configuré (assets statiques avec `Cache-Control`) ;
- [ ] pas de N+1 visible sur la page principale (DB queries) ;
- [ ] Lighthouse > 80 en performance pour un site public.

---

## 13. Cache

- [ ] cache applicatif si DB lourde (Redis / fichier / OPCache) ;
- [ ] invalidation correcte du cache (mise à jour admin → invalidation front) ;
- [ ] pas de cache trop agressif sur des pages dynamiques (login, panier).

---

## 14. CI / CD (si applicable)

- [ ] workflow GitHub Actions / GitLab CI fonctionnel ;
- [ ] tests lancés automatiquement sur PR ;
- [ ] déploiement reproductible et automatisé ;
- [ ] secrets du CI dans Settings, jamais dans `.yml`.

---

## 15. Versioning

- [ ] tag SemVer pour les releases ;
- [ ] `CHANGELOG.md` à jour ;
- [ ] commits avec convention claire (Conventional Commits ou équivalent) ;
- [ ] branche `main` jamais cassée.

---

## Sortie attendue (en phase 4)

Pour chaque item failed, noter :

- **fichier(s) concerné(s)** ;
- **ligne approximative** ;
- **gravité** : `critique` / `important` / `mineur` ;
- **impact** : 1 phrase ;
- **correction recommandée** : 1 phrase.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
