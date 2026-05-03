# Comment utiliser le skill `premium-webdesigner`

Created by João de Almeida — Art of Dev — https://artofdev.space

---

## 1. Installation

Une seule fois, depuis la racine du repo `claude-skills-artofdev` :

```bash
bash install.sh
```

Le script `install.sh` est multi-skill : il détecte tous les sous-dossiers de `skills/` et installe (ou met à jour) chacun dans `~/.claude/skills/`.

Pour vérifier :

```bash
ls ~/.claude/skills/premium-webdesigner/SKILL.md
bash uninstall.sh --list
```

> Si une version précédente était installée, elle est sauvegardée automatiquement dans `~/.claude/skills/.backup/premium-webdesigner-YYYYMMDD-HHMMSS/`.

---

## 2. Activation automatique

Le skill s'active **automatiquement** dès que ta demande matche sa `description:`.

Tu n'as **rien** à taper de spécial. Pas de slash-commande obligatoire.

Si Claude détecte que ta demande correspond, il charge `SKILL.md` et déroule la **méthode en 6 phases** (compréhension → recherche d'inspiration → composants → direction artistique → images → exécution).

---

## 3. Comment l'appeler

### Refonte complète (brief + implémentation)

> *"Refonte moderne et premium de cette homepage SaaS. Cherche des inspirations sur 21st.dev, propose une direction artistique, puis implémente."*

> *"Ce site fait trop template WordPress. Revois l'expérience visuelle complète, trouve des composants modernes, importe des images cohérentes."*

### Brief design seul (sans implémentation)

> *"Brief design seul, sans coder. Je veux juste le moodboard, la palette et la sélection de composants pour discussion."*

Le skill s'arrête après la phase D (direction artistique) et te rend les 4 templates remplis :
- `design-brief.md`
- `moodboard-report.md`
- `component-selection.md`
- `design-system.md`

### Brief + implémentation

> *"Brief design complet + implémentation de la homepage. Garde l'admin et le pricing intacts, focus sur le hero et les features."*

### Demande ciblée par section

> *"Améliore juste le hero de cette landing. Pas le reste."*
> *"Refais le footer. Minimum 3 colonnes, copyright dynamique, social Lucide."*
> *"Améliore les états vides du dashboard admin."*

### Demande recherche 21st.dev seule

> *"Cherche-moi 5 hero sections sur 21st.dev qui pourraient correspondre à un SaaS B2B productivité, ambiance Linear/Cron. Donne-moi la liste avec URL et raison du choix."*

Le skill rend uniquement la phase B + remplit `component-selection.template.md`.

### Demande images seules

> *"Je veux juste une shortlist d'images Pixabay pour mon mini CMS de coiffeur. Mots-clés : salon moderne, lumineux, lifestyle."*

Le skill rend uniquement la phase E + remplit `image-selection.template.md`.

---

## 4. Comment l'utiliser sur un projet réel

### Étape 1 : positionner le contexte

```bash
cd /chemin/vers/mon/projet
```

### Étape 2 : lancer la conversation Claude Code

> *"Refonte premium de la homepage. Stack : Next.js 14 + Tailwind + shadcn. Cible : freelances tech. Action principale : créer un compte gratuit. Émotion : sérénité + performance. Cherche des inspirations sur 21st.dev (featured + popular pour le hero, newest pour les features), propose une direction artistique cohérente, importe les images via Unsplash si possible, puis implémente. Ne casse pas le pricing existant. Fais un rapport avant et après."*

Claude charge le skill, déroule les 6 phases, te rend brief + moodboard + sélections + design system + rapport.

### Étape 3 : valider à chaque phase

Tu valides explicitement chaque phase avant d'enchaîner :

- *"OK pour la palette et la typo, on passe aux composants."*
- *"Ce composant 21st.dev me va, mais l'autre non — propose-moi 3 alternatives."*
- *"Cette image hero ne colle pas — change pour quelque chose de plus chaud."*

### Étape 4 : itérer

Le skill produit un `redesign-report.md`. Si le score `ui-quality-checklist` < 80, il propose les actions pour passer au-dessus.

---

## 5. Comment demander une refonte sans casser l'existant

> *"Refonte visuelle UNIQUEMENT. Ne touche pas aux routes, aux formulaires, aux paiements, à l'admin. Tous les flows fonctionnels doivent rester identiques. Ne change aucune donnée dynamique en hardcodé."*

Le skill respecte ces consignes (cf. `SKILL.md §5.2` non-destruction). Si tu veux verrouiller encore plus :

> *"Mode brief design seul. Ne modifie aucun fichier. Donne-moi juste les fichiers de planification dans docs/."*

---

## 6. Comment demander recherche 21st.dev approfondie

> *"Phase B uniquement. Pour chaque catégorie ci-dessous, donne-moi 3–5 composants 21st.dev avec URL, raison du choix, dépendances, et risques :
> - Hero (featured + popular)
> - Pricing (popular)
> - Features bento (newest)
> - Testimonials (featured)
> - Footer (popular)
>
> Pas d'implémentation. Juste la shortlist documentée."*

---

## 7. Comment demander un import d'images Pixabay/Unsplash

> *"Phase E uniquement. Pour chacun des emplacements suivants, propose-moi 5 candidats Pixabay (clé API disponible dans .env) :
> - Hero homepage : workstation clean, soft gradient
> - Section features : abstract technology, dashboard interface
> - Section testimonials : photos client réelles (à recevoir)
>
> Pour chaque candidat : URL, dimensions, mots-clés utilisés, raison du choix, alt text proposé. Documente dans templates/image-selection.template.md."*

---

## 8. Comment demander seulement un brief

Le skill peut se limiter aux **3 premières phases** :

> *"Brief design seul + moodboard + composants + design system. AUCUNE modification de fichier code. Juste 4 fichiers dans docs/ : design-brief.md, moodboard-report.md, component-selection.md, design-system.md."*

Utile :
- avant un comité produit ;
- pour un appel d'offres ;
- pour valider une direction avec un client avant de coder ;
- pour un audit avant d'engager un agence externe.

---

## 9. Comment demander brief + implémentation

> *"Workflow complet :
> 1. Phase A–E : brief, moodboard, sélection composants/images, design system → me rendre les 5 fichiers dans docs/.
> 2. PAUSE : me demander de valider avant la phase F.
> 3. Phase F : implémenter section par section, commits séparés.
> 4. Rapport final : redesign-report.md avec score ui-quality-checklist."*

C'est le mode **collaboratif** standard.

---

## 10. Limites et bonnes pratiques

- **Le skill ne remplace pas un designer humain** : il accélère les phases d'exploration et de cadrage, mais le goût final est humain.
- **Si l'accès web est limité** : le skill le dit et propose une shortlist à valider manuellement.
- **Sur un gros projet** : faire une page à la fois. La méthode 6-phases prend ~1h sur un hero seul, ~3h sur une homepage complète.
- **Garder les commits séparés** par phase : ça facilite le rollback si une direction est rejetée.
- **Re-lancer le skill périodiquement** : le score `ui-quality-checklist` peut servir d'indicateur de dette de design accumulée.

---

## 11. Désinstallation

```bash
bash uninstall.sh premium-webdesigner
```

Sauvegarde le skill dans `~/.claude/skills/.backup/`, puis le retire. **Ne touche pas** aux autres skills (`repo-builder`, `production-auditor`).

---

Created by João de Almeida — Art of Dev — https://artofdev.space
