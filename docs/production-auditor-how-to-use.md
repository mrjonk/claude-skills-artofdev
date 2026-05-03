# Comment utiliser le skill `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Installation

Une seule fois, depuis la racine du repo `claude-skills-artofdev` :

```bash
bash install.sh
```

Le script `install.sh` détecte tous les skills présents dans `skills/` et les installe (ou met à jour) dans `~/.claude/skills/`.

Pour vérifier :

```bash
ls ~/.claude/skills/production-auditor/SKILL.md
```

> ⚠️ Si une version précédente était installée, elle est sauvegardée automatiquement dans `~/.claude/skills/.backup/production-auditor-YYYYMMDD-HHMMSS/`.

---

## 2. Activation automatique

Le skill s'active **automatiquement** quand ta demande matche sa `description:`.

Tu n'as **rien** à taper de spécial. Pas de slash-commande obligatoire. Pas de mention à faire.

Si Claude détecte que ta demande correspond, il charge `SKILL.md` et applique la méthode d'audit en 10 phases.

---

## 3. Comment l'appeler

### Audit complet

> *"Audite ce projet."*
> *"Vérifie si c'est prêt pour la prod."*
> *"Fais un audit complet."*

### Audit avec corrections sûres

> *"Audite et corrige les problèmes évidents et sûrs."*
> *"Audit production-grade et applique uniquement les corrections sûres."*

### Audit lecture seule

> *"Fais un audit, mais ne corrige rien. Je veux juste le rapport."*

### Audit focus sur une catégorie

> *"Audit sécurité seul."*
> *"Audit SEO et contenu uniquement."*
> *"Vérifie le billing : pricing, checkout, webhooks Stripe."*
> *"Audit déploiement : permissions, HTTPS, backups, monitoring."*

### Audit avant vidéo YouTube

> *"Audit avant vidéo YouTube — masque les chemins serveur, vérifie qu'aucun secret n'est visible à l'écran."*

(Active automatiquement le mode `VIDEO_PRESENTATION_MODE` du skill — cf. `SKILL.md §10`.)

---

## 4. Comment interpréter le rapport

Le rapport est généré dans `reports/audit-YYYY-MM-DD.md`. Structure complète dans [`../skills/production-auditor/references/report-format.md`](../skills/production-auditor/references/report-format.md).

### Score global (0–100)

| Score | Statut | Que faire |
|---|---|---|
| 0–20 | Non publiable | Refonte. Ne pas déployer. |
| 21–40 | Très fragile | Bloquants multiples. Liste à corriger avant tout. |
| 41–60 | Prototype | OK pour un test interne, **pas** pour une prod. |
| 61–75 | Publiable avec corrections | Corriger les `CRIT` puis lancer en soft launch. |
| 76–90 | Solide | Lancement possible. Quelques `IMP` à boucler. |
| 91–100 | Premium | Prêt prod. Polir les `MIN` à l'occasion. |

### Score par axe

7 axes (Technique, UX/UI, Sécurité, SEO/Contenu, Admin, Billing, Déploiement). Identifier l'axe le plus faible : c'est lui qui dicte la priorité.

### Liste des problèmes

Chaque problème a un ID :

- `CRIT-NNN` → bloquant ;
- `IMP-NNN` → important ;
- `MIN-NNN` → mineur.

Pour chaque ID : fichier, impact, correction recommandée. Faciles à traiter un par un.

### Plan d'action

6 phases ordonnées. **Ne pas sauter de phase.** Phase 1 (bloquants) doit être terminée avant la 2.

---

## 5. Comment l'utiliser sur un projet réel

### Étape 1 : positionner le contexte

```bash
cd /chemin/vers/mon/projet
```

### Étape 2 : lancer la conversation Claude Code

Exemple :

> *"Audite ce projet [type : SaaS / mini CMS / WordPress]. Stack : [détailler]. Mon but : [mise en prod / vidéo YouTube / livrer un client]. Donne-moi le rapport, propose les corrections sûres, ne push rien."*

Claude charge le skill, exécute les phases 1 à 9, propose les corrections sûres, te rend `reports/audit-YYYY-MM-DD.md`.

### Étape 3 : valider les corrections sûres

Claude liste les corrections appliquées. **Tu valides** par un simple "OK applique" ou tu rejettes.

### Étape 4 : itérer

Tu corriges les `CRIT`, tu re-lances un audit, tu vises un score ≥ 76. Le rapport peut être régénéré autant de fois que nécessaire.

---

## 6. Demander un audit sans correction

Pour un rapport **lecture seule**, sans aucune modification :

> *"Audit complet, lecture seule, ne corrige rien, donne-moi juste le rapport."*

C'est utile :

- avant un audit externe (consultant sécurité, agence) ;
- quand tu veux comparer 2 versions ;
- quand tu prépares un bilan trimestriel.

---

## 7. Demander audit + corrections sûres

Par défaut, le skill applique uniquement des corrections **évidentes et sûres** (cf. `SKILL.md §11`) :

- typos ;
- balises `<title>` / `<meta description>` manquantes ;
- `alt` vides ;
- `console.log` / `var_dump` oubliés ;
- `.gitignore` minimum manquant ;
- `.env.example` manquant si secrets nécessaires.

Pour tout le reste, le skill **propose** la correction et **demande confirmation**.

---

## 8. Limites et bonnes pratiques

- L'audit est **statique** : il lit le code, pas le runtime. Il ne sait pas si ton serveur pince à 200 req/s ou pas.
- Le scan des liens internes est **approximatif** sur les routes dynamiques.
- Le scoring est **calibré pour des projets web standards**. Pour un projet très atypique (compilateur, jeu vidéo, scientific computing), pondérer à la main.
- Re-lancer l'audit régulièrement pendant le dev — ça évite que les bloquants s'accumulent.
- **Ne pas confondre** audit et tests : un audit haut score peut quand même avoir des bugs runtime. Garder une suite de tests à part.

---

## 9. Désinstallation

```bash
bash uninstall.sh production-auditor
```

Sauvegarde le skill dans `~/.claude/skills/.backup/`, puis le retire. **Ne touche pas** aux autres skills.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
