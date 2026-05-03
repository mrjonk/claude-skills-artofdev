# Exemple — Audit avant vidéo YouTube

## Contexte

Mini CMS sectoriel (coiffeur, PHP/SQLite) qu'on s'apprête à filmer pour la chaîne **Art of Dev**.
Format vidéo : screen recording du VPS privé, montage YouTube.
Objectif : montrer la création / l'admin / l'export ZIP sans rien laisser fuiter à l'écran.

Mode `VIDEO_PRESENTATION_MODE` activé.

## Prompt utilisateur

> *"Audit screen-safe avant tournage YouTube. Mode VIDEO_PRESENTATION_MODE. Vérifie en priorité : aucun secret visible si je fais ls/cat à l'écran, aucun chemin /var/www/, aucune IP, aucun nom user Linux, aucune erreur PHP brute, pages 404/500 propres, effet wow homepage, mot de passe par défaut clairement marqué « à changer », aucune route admin URL devinable. Liste-moi les zones à éviter de montrer en vidéo."*

## Ce que le skill doit analyser

### Phase 1–2

Inventaire des fichiers susceptibles d'apparaître à l'écran :

- code source (`.php`, `.html`, `.js`, `.css`) ;
- fichiers de config (`.env.example`, `manifest.json`) ;
- fichiers d'install (`install/index.php`, etc.) ;
- documentation (`README.md`, `INSTALL.md`, `EXPORT.md`).

**Hors-écran** mais à scanner : `.env`, `storage/`, `logs/`, `backups/`, `exports/`.

### Phase 3 (UX en mode vidéo)

L'audit UX devient un audit **caméra-ready** :

- la homepage doit avoir un **effet wow immédiat** (cf. factory file §16) ;
- le hero doit charger en < 1 s sur l'enregistrement ;
- les transitions de page doivent être fluides (pas de saut visuel) ;
- les libellés doivent être en français parfait (zéro mot anglais résiduel) ;
- les boutons admin doivent avoir des **termes humains** (cf. factory file §11) — pas `Update`, mais *"Sauvegarder"* ;
- les images doivent être chargées (pas de placeholder cassé qui laisserait voir l'icône broken-image).

### Phase 4 (technique)

- aucun `var_dump`, `print_r`, `dd()` qui pourrait apparaître si un test est lancé en direct ;
- aucune erreur PHP brute possible — tester manuellement quelques URL invalides (`/page-inexistante/`, `/admin?id=999999`) pour vérifier qu'on tombe sur des pages 404/500 customisées ;
- aucun `phpinfo()` accessible publiquement ;
- aucun `/debug`, `/info.php`, `/server-status` accessible.

### Phase 5 (sécurité — mode vidéo)

**Très strict.** Vérifier qu'**aucune** des choses suivantes n'apparaît dans le code, les commentaires, les logs ou les fichiers visibles :

- chemins serveur complets (`/var/www/...`, `/home/<user>/...`) ;
- IP locales (`192.168.x.x`, `10.x.x.x`) ou publiques du VPS ;
- noms d'utilisateurs Linux (`adminvps`, `root`) ;
- contenu de `.env` (même partiel) ;
- tokens, clés API, mots de passe (autres que `ChangeMe123!` documenté) ;
- adresses email réelles d'admin / propriétaire ;
- noms de domaines internes / staging ;
- noms d'hôtes serveur ;
- numéros de version de software qui pourraient indiquer une version vulnérable spécifique.

### Phase 6 (SEO / contenu)

Niveau secondaire en vidéo, mais à mentionner :

- titles + meta visibles dans la balise `<head>` ;
- contenu réel (zéro lorem) — important si on zoome sur la home ;
- alt sur les images visibles à l'écran (le narrateur peut commenter).

### Phase 7 (admin)

- l'URL admin doit être **non devinable** : `/admin/` est OK pour démontrer, mais signaler à l'utilisateur qu'en prod réelle, il faudrait `/admin-<random>/` ou un firewall app ;
- mot de passe admin par défaut (`ChangeMe123!`) doit être **clairement** marqué *"À changer après installation"* dans le dashboard admin (avec un toast ou bandeau) ;
- aucun nom réel d'utilisateur dans l'admin ;
- aucune donnée client réelle visible (utiliser uniquement des seeds).

### Phase 8 (scoring)

Score adapté au contexte vidéo :

- l'axe **Sécurité** est encore plus pondéré (un secret visible = mode CRIT immédiat).
- l'axe **UX** prime sur Admin (la homepage est ce que les viewers voient le plus).

### Phase 9 (rapport)

Le rapport doit inclure une **section spéciale** :

```markdown
## Zones à éviter de montrer à l'écran

- ✗ `.env` (jamais `cat .env`, jamais `ls -la` sur le dossier qui le contient)
- ✗ `storage/database.sqlite` (peut contenir des seeds OK, mais pas de clic dessus en SQLite Browser à l'écran sans vérifier)
- ✗ `printenv`, `env | grep`, `ps aux | grep` (peuvent fuiter)
- ✗ `htpasswd`, `~/.bash_history`, `~/.ssh/`
- ✗ Onglet Network du DevTools si requêtes API contiennent des tokens
- ✗ Fichiers de log bruts (`tail -f` à l'écran : OK pour démo, mais filtré)

## Commandes screen-safe à privilégier

- ✓ `ls projet-coiffeur/` (sans `-la`)
- ✓ `php -v`
- ✓ `bash tools/export-zip.sh`
- ✓ `cat README.md`, `cat INSTALL.md`
- ✓ Navigation dans le code via VS Code (les fichiers sensibles sont gitignored donc absents)
```

### Phase 10 (corrections sûres)

- masquer / renommer les références aux chemins serveur dans les commentaires de code ;
- compléter les pages 404/500 si manquantes ;
- retirer les `var_dump` oubliés ;
- ajouter un bandeau *"À changer après installation"* sur le mot de passe par défaut s'il est absent.

## Résultat attendu

### Score type pour un projet vidéo-ready

| Axe | Score attendu |
|---|---|
| Technique | 75–85 |
| UX/UI | 80–90 (la home doit donner envie) |
| Sécurité | 75–85 (secrets, surtout) |
| SEO/Contenu | 65–80 |
| Admin/Backoffice | 75–85 |
| Billing | N/A |
| Déploiement | 50–65 (souvent local pour la vidéo) |
| **Global** | **75–85** — *Solide* à *Premium* |

### Verdict typique

> *"Vidéo-ready après 2 ajustements : (1) bandeau « À changer » sur le mot de passe admin par défaut, (2) page 500 custom à compléter (un test URL avec id invalide affiche encore l'écran PHP brut). Reste : screen-safe, hero présentable, contenu adapté au métier coiffeur. Bon pour tournage."*

## Corrections possibles

- ajouter un middleware `error-handler` qui rend une page 500 custom ;
- compléter les seeds pour avoir une homepage visuellement riche pendant la démo ;
- ajouter le bandeau *"Mot de passe par défaut — à changer après installation"* ;
- vérifier que `WP_DEBUG`, `APP_DEBUG`, `display_errors` sont à `false` pour le tournage (mais pas en prod).

## Points de vigilance spéciaux

- **`cat .env`** ou équivalent : à **bannir** de tout enregistrement. Si vraiment nécessaire pour montrer la structure, faire `cat .env.example` à la place.
- **Onglet Network DevTools** : si on l'ouvre en vidéo, masquer les `Authorization` headers, les cookies, les query strings avec tokens.
- **Terminal multiplexé / tmux** : vérifier qu'aucune autre fenêtre tmux n'a une commande sensible à l'écran lors du switch.
- **Auto-complete shell** : peut suggérer des commandes ou paths sensibles. Tester avant tournage.
- **Notifications système** : couper toutes les notifications avant tournage (Slack, email, etc.) — un message Slack avec un secret peut s'afficher en pop-up.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
