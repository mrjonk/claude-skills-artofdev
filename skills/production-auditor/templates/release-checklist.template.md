# Release Checklist — {{PROJECT_NAME}}

> À cocher juste avant un déploiement / une release.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Avant commit

- [ ] tests locaux passent (`npm test` / `pytest` / `phpunit`)
- [ ] linting OK (`npm run lint` / `phpcs`)
- [ ] aucun fichier `.bak`, `.tmp`, `.log` à commit er
- [ ] aucun `console.log` / `var_dump` / `dd()` oublié
- [ ] aucune valeur de secret dans le diff (`git diff` rapide en lecture)
- [ ] message de commit en Conventional Commits

---

## Avant build

- [ ] dépendances à jour ou lock cohérent
- [ ] `npm ci` / `composer install --no-dev` propre (selon contexte)
- [ ] `.env.production` configuré (jamais commit é)
- [ ] base de données migrée si migration en attente (mode dry-run testé)
- [ ] backup base de données prod
- [ ] backup fichiers critiques (uploads, config)

---

## Avant déploiement

- [ ] tag SemVer créé (`vX.Y.Z`) et poussé
- [ ] `CHANGELOG.md` mis à jour (déplacer `Unreleased` → version)
- [ ] release GitHub créée (`gh release create vX.Y.Z`)
- [ ] notes de release rédigées (5–10 lignes max)
- [ ] runbook de rollback relu et accessible
- [ ] fenêtre de maintenance communiquée si downtime attendu
- [ ] healthcheck endpoint testé (`/healthz`)

---

## Pendant le déploiement

- [ ] suivi en direct des logs serveur
- [ ] vérification du build / de la commande de déploiement
- [ ] vérification que le site répond (HTTP 200 sur la home)
- [ ] vérification HTTPS / certificat
- [ ] vérification healthcheck

---

## Après déploiement

- [ ] smoke tests manuels :
  - [ ] homepage se charge
  - [ ] login admin fonctionne
  - [ ] CRUD principal fonctionne
  - [ ] formulaires public fonctionnent
  - [ ] paiement (mode test) fonctionne si applicable
- [ ] vérifier les emails transactionnels (envoyer un test)
- [ ] vérifier les webhooks (envoyer un event test si applicable)
- [ ] vérifier monitoring (uptime, sentry, logs)
- [ ] surveiller pendant 30 min après déploiement
- [ ] communiquer aux utilisateurs / au client

---

## Rollback (si problème détecté)

- [ ] décider : rollback full ou hotfix rapide ?
- [ ] si rollback : `git checkout {{PREVIOUS_TAG}}` + redéployer
- [ ] si DB migrée : exécuter la down-migration
- [ ] vérifier le retour à l'état précédent
- [ ] communiquer le rollback
- [ ] post-mortem rédigé dans les 24 h

---

## Monitoring post-release (24–48 h)

- [ ] taux d'erreur 5xx stable (pas d'augmentation > 5%)
- [ ] latence p95 stable
- [ ] aucune alerte uptime
- [ ] aucune alerte sécurité
- [ ] logs erreur revus

---

## Documentation post-release

- [ ] notes de release publiées (GitHub Releases, blog si applicable)
- [ ] documentation utilisateur mise à jour si features visibles
- [ ] documentation technique mise à jour (`docs/architecture.md`, `docs/deployment.md`)
- [ ] changelog public synchro avec changelog interne

---

Created by João de Almeida — Art of Dev — https://artofdev.space
