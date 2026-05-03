# Exemple — Interface pour démo vidéo YouTube

## Contexte

Création d'un mini CMS pour un cas vidéo YouTube de la chaîne **Art of Dev** :
*"Je crée un site complet pour un tatoueur en 30 min avec Claude"*.

Stack : PHP 8 + SQLite (factory mini-CMS Art of Dev).
Mode `VIDEO_PRESENTATION_MODE` activé (cf. `CLAUDE_PROJECT_FACTORY.md` §27–§30).
Cible : viewers de la chaîne YouTube (30k abonnés visés) + portfolio démontrable + livraison ZIP.

## Prompt utilisateur

> *"Crée le design d'un mini CMS pour cas vidéo YouTube : 'Je crée un site pour un tatoueur en 30 min avec Claude'. Mode VIDEO_PRESENTATION_MODE. Aucun secret / chemin / IP visibles si ls/cat. Effet wow homepage tattoo (ambiance brutaliste-noir-rouge). Admin clair avec termes humains. Export ZIP fonctionnel pour la fin de vidéo. Brief avant implémentation. Documente chaque choix pour le voice-over."*

## Recherche d'inspiration attendue

### 21st.dev

| Catégorie | Pourquoi |
|---|---|
| Heros (newest, dark) | hero immersif sombre, contrasté |
| Cards / Image grid | portfolio styles tattoo |
| FAQ | soins post-tatouage |
| CTA | "Demander un devis", "Prendre RDV" |
| Footer | contact + sociaux (Instagram primordial) |

### Sites de référence

- **Sang Bleu** (référence tattoo premium) — éditorial, monochrome contrasté ;
- **Tin-Tin Tatouages** — portfolio + équipe ;
- **studios premium nord-européens** (à explorer manuellement).

## Composants à chercher

| Composant | Source | Adaptation |
|---|---|---|
| Hero immersif sombre | 21st.dev (Modern UI, dark) | photo studio + claim |
| Portfolio par style | 21st.dev / shadcn | tabs : Old school / Realistic / Black work / Minimaliste |
| Section "L'artiste" | 21st.dev | bio courte + Instagram |
| FAQ post-tatouage | shadcn Accordion | 8–12 questions cicatrisation |
| Formulaire devis | shadcn Form | upload référence image possible |
| Footer | shadcn | contact + horaires + Instagram |

## Images (Pixabay — clé dispo)

| Emplacement | Mots-clés |
|---|---|
| Hero | `tattoo studio dark`, `ink texture macro`, `urban wall` |
| Section portfolio (placeholder) | `black and white portrait`, `minimalist tattoo`, `body art abstract` |
| Section artiste | photo client à recevoir, sinon Pixabay `tattoo artist working hands` |

> Pas de stock photo "personne en costume". Ambiance crédible, urbaine, artistique.

## Direction artistique

- **Ambiance** : brutaliste, sombre, contrastée, urbaine ;
- **Palette** : noir profond `#0a0a0a` + blanc cassé `#fafaf9` + rouge mat `#7f1d1d` (accent) ;
- **Typographie** : Cabinet Grotesk (display, marqué) + Inter (body) ;
- **Spacing** : aéré sur la home (effet wow), dense sur les pages internes ;
- **Radius** : 0 ou 4 px (brutaliste, pas trop rond) ;
- **Shadows** : aucune ou très tranchées ;
- **Animations** : minimales, scroll-reveal sur portfolio uniquement ;
- **Densité** : basse sur la home, haute sur le portfolio.

## Mode `VIDEO_PRESENTATION_MODE` — règles spéciales

(Cf. `SKILL.md §10` + `CLAUDE_PROJECT_FACTORY.md` §29–§30.)

À l'écran pendant le tournage :

- **interdit** : `cat .env`, `printenv`, `ls -la` qui montre `.env`, contenu de logs ;
- **interdit** : chemins absolus `/var/www/...`, IP `192.168.x.x`, nom Linux `adminvps`, `root` ;
- **interdit** : tokens, mots de passe (sauf `ChangeMe123!` documenté comme valeur de dev) ;
- **OK** : `ls projet-tattoo/`, `php -v`, `bash tools/export-zip.sh`, navigation VS Code dans le code ;
- **vérifier** : aucune notification Slack / email pop-up pendant tournage (couper toutes les notifs) ;
- **vérifier** : pas d'historique terminal sensible avec auto-complétion révélatrice.

## Stack — alignement factory mini-CMS

(Cf. `CLAUDE_PROJECT_FACTORY.md` §20.)

```
mini-cms-tattoo/
├── public/         (front public)
├── admin/          (login, dashboard, etc.)
├── install/        (12 étapes, lock après install)
├── app/            (core + models)
├── storage/        (SQLite + logs + backups)
├── templates/
├── data/           (seeds réalistes)
├── tools/
│   └── export-zip.sh
├── exports/        (ZIP finaux)
├── manifest.json
├── README.md
├── INSTALL.md
└── EXPORT.md
```

## Résultat attendu

- 5 fichiers dans `docs/` ;
- structure mini-CMS complète + design appliqué :
  - `public/index.php` (homepage)
  - `public/portfolio.php`
  - `public/contact.php`
  - `public/devis.php`
  - `public/faq.php`
  - `public/assets/css/style.css` avec variables et tokens
  - `public/assets/images/hero/`, `sections/`
- admin avec dashboard intelligent (to-do, checklist lancement) ;
- export ZIP fonctionnel ;
- `docs/image-credits.md` ;
- `redesign-report.md` avec **section "Voice-over"** : phrases-clés que je peux dire à la caméra.

### Score attendu

| Axe | Cible |
|---|---|
| Visuel | 85+ (effet wow obligatoire) |
| UX | 80+ |
| Responsive | 90+ (cible mobile dominante pour tattoo) |
| Accessibilité | 80+ |
| Cohérence | 90+ |
| Premium feel | 85+ |
| **Global** | **85+** |

## Erreurs à éviter

- **fuite** d'IP / chemin / nom user / token à l'écran (= disqualifie la vidéo) ;
- **lorem ipsum** résiduel dans les seeds (ridicule à l'écran) ;
- **photos stock corporate** (= contre-emploi total pour un tatoueur) ;
- **typographie trop joyeuse / corporate** (= contre-emploi) ;
- **animations parallax** lourdes (= saccades visibles à 1080p YouTube) ;
- **mot de passe admin par défaut** non marqué "À changer" (= signal de paresse) ;
- **export ZIP cassé** au moment de la démo finale (= clip à refaire).

## Checklist finale

- [ ] design-brief rempli avec mode VIDEO mentionné
- [ ] palette brutaliste validée (noir + blanc + rouge mat)
- [ ] typographie marquée (display) + lisible (body)
- [ ] hero immersif avec photo studio
- [ ] portfolio fonctionnel (tabs ou filtres par style)
- [ ] FAQ remplie avec 8 questions réelles
- [ ] formulaire devis fonctionnel (upload référence OK ou désactivé proprement)
- [ ] admin avec dashboard intelligent (to-do, checklist)
- [ ] termes humains uniquement
- [ ] export ZIP testé en clean room (machine vierge)
- [ ] **aucun secret / chemin / IP / nom Linux à l'écran**
- [ ] mot de passe admin par défaut documenté + bandeau "À changer"
- [ ] pages 404 / 500 customisées (cas où URL invalide montrée à l'écran)
- [ ] Lighthouse ≥ 90 (rendre la perf visible à l'écran si chrono affiché)
- [ ] redesign-report.md avec section voice-over
- [ ] notifications système coupées avant tournage

---

Created by João de Almeida — Art of Dev — https://artofdev.space
