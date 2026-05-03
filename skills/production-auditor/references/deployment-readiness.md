# Checklist déploiement / production-readiness

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 7 (axe déploiement).

---

## 1. Variables d'environnement

- [ ] `.env.example` à jour avec **toutes** les variables nécessaires ;
- [ ] `.env` de prod **différent** de `.env` de dev ;
- [ ] secrets prod gérés (vault, secrets GitHub, env serveur) ;
- [ ] aucune valeur prod codée en dur dans le repo ;
- [ ] mode `production` / `prod` activé en prod (`APP_ENV=production`, `NODE_ENV=production`).

---

## 2. Build

- [ ] commande de build documentée et reproductible ;
- [ ] build exécuté en CI ou avec versions figées ;
- [ ] artefacts de build **non commités** mais générables (`dist/`, `build/`, `.next/`) ;
- [ ] taille du build raisonnable ;
- [ ] aucune erreur ni warning critique au build.

---

## 3. Logs

- [ ] niveau `info` ou `warning` en prod (pas `debug`) ;
- [ ] format structuré si possible (JSON pour ingestion) ;
- [ ] rotation configurée (logrotate ou équivalent) ;
- [ ] taille bornée (alerte si > X Go) ;
- [ ] logs **non accessibles publiquement** ;
- [ ] PII masquée si possible.

---

## 4. Backups

- [ ] **fichiers** : backup régulier (uploads, configs critiques) ;
- [ ] **DB** : dump régulier, conservé X jours (7–30 selon criticité) ;
- [ ] backups stockés **hors du serveur** (S3, Backblaze, Wasabi, autre serveur) ;
- [ ] backups **chiffrés** ;
- [ ] procédure de restauration **testée** au moins une fois ;
- [ ] document écrit "comment restaurer en 30 minutes".

---

## 5. Rollback

- [ ] tag SemVer pour chaque release ;
- [ ] commande `git checkout <tag-précédent>` ou équivalent CI documentée ;
- [ ] rollback de DB documenté si migration destructive (down migrations) ;
- [ ] délai de rollback < 15 min idéalement ;
- [ ] point de retour testé avant le déploiement.

---

## 6. Reverse-proxy

### Nginx

- [ ] block `server` propre ;
- [ ] `try_files` correct pour SPA ;
- [ ] `fastcgi_pass` correct pour PHP ;
- [ ] denial sur `/.env`, `/.git`, `/.htaccess`, `/storage/` (selon stack) ;
- [ ] `client_max_body_size` cohérent avec uploads ;
- [ ] gzip / brotli activé ;
- [ ] cache statique activé (`expires` sur `/assets/`) ;
- [ ] logs séparés par site.

### Apache

- [ ] `.htaccess` présent et correct ;
- [ ] `mod_rewrite` activé ;
- [ ] `Require all denied` sur `.env`, `.git`.

---

## 7. HTTPS

- [ ] **HTTPS obligatoire** en prod (HTTP redirige vers HTTPS) ;
- [ ] certificat TLS valide (Let's Encrypt automatisé recommandé) ;
- [ ] renouvellement automatique configuré ;
- [ ] HSTS (`Strict-Transport-Security`) ;
- [ ] TLS 1.2 minimum, idéalement TLS 1.3 ;
- [ ] cipher suites modernes (Mozilla SSL Config Generator).

---

## 8. Domaine

- [ ] DNS pointant correctement (`A` ou `AAAA`) ;
- [ ] redirection `www` ↔ apex décidée et appliquée ;
- [ ] mail DNS (`MX`, `SPF`, `DKIM`, `DMARC`) si emails envoyés depuis le domaine ;
- [ ] domaine **pas en expiration imminente** (renouvellement auto activé idéalement).

---

## 9. Cron / tâches planifiées

- [ ] cron documenté dans `docs/deployment.md` ;
- [ ] tâches idempotentes (pas de doublon si crontab tourne 2× par accident) ;
- [ ] log de chaque exécution ;
- [ ] alerte si tâche échoue (email, Slack, monitoring) ;
- [ ] timeouts définis (pas de cron qui tourne 6 h sans qu'on s'en aperçoive).

---

## 10. Workers / queues (si applicable)

- [ ] worker démarrable et redémarrable proprement (systemd, supervisor, PM2) ;
- [ ] retry configuré (max 3–5 tentatives par défaut) ;
- [ ] dead-letter queue si support ;
- [ ] monitoring du backlog (alerte si > N jobs en attente) ;
- [ ] graceful shutdown (worker termine son job avant de stopper).

---

## 11. Permissions fichiers

- [ ] propriétaire correct (souvent `www-data` ou utilisateur app) ;
- [ ] dossiers : `755` ;
- [ ] fichiers : `644` ;
- [ ] dossiers en écriture (uploads, storage) : `775` ou `755` selon group ;
- [ ] aucun fichier en `777` ;
- [ ] `.env` : `600` ou `400` (lecture par owner uniquement).

---

## 12. Monitoring minimal

- [ ] healthcheck endpoint (`/healthz` ou `/up`) ;
- [ ] uptime monitoring externe (UptimeRobot, Better Uptime, BetterStack) ;
- [ ] alerte sur down (email, SMS, Slack) ;
- [ ] dashboard d'erreurs (Sentry, GlitchTip, ou logs structurés) ;
- [ ] métriques basiques : RAM, CPU, disque, requêtes/s, latence p95.

---

## 13. Observabilité

- [ ] logs centralisés si plusieurs serveurs ;
- [ ] traces ou request-ID pour suivre une requête ;
- [ ] tableau de bord accessible aux dev et au support.

---

## 14. Sauvegarde de la procédure de déploiement

- [ ] `docs/deployment.md` à jour ;
- [ ] runbook : étapes pour déployer manuellement si CI down ;
- [ ] runbook incident : qui appeler, comment couper le trafic, comment restaurer ;
- [ ] versions des outils nécessaires documentées (PHP X, Node X, Python X).

---

## 15. Capacité / charge

- [ ] estimation basique de la charge prévue (visites/jour, RPS) ;
- [ ] tests de montée en charge basiques si SaaS sérieux ;
- [ ] limites configurées : rate-limit API, timeouts, max connections DB.

---

## Sortie attendue

Pour chaque item failed :

- **zone** : `env`, `https`, `backup`, `monitoring`, `nginx`, etc. ;
- **gravité** : un site sans HTTPS en prod = `critique`, pas de monitoring = `important`, pas de tests de charge = `mineur` ;
- **impact** : 1 phrase ;
- **correction recommandée** : 1 phrase actionnable.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
