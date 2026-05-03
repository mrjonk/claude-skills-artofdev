# Design Brief — {{PROJECT_NAME}}

> Document de cadrage produit en amont du redesign.
> Created by João de Almeida — Art of Dev — https://artofdev.space

---

## Projet

- **Nom** : {{PROJECT_NAME}}
- **URL / chemin local** : {{PROJECT_URL}}
- **Type** : {{site-vitrine | saas | mini-cms | dashboard | wordpress | autre}}
- **Stack technique** : {{ex: Next.js 14 + Tailwind + shadcn/ui}}
- **Date du brief** : {{YYYY-MM-DD}}

---

## Cible

- **Persona principale** : {{ex: freelance tech, 25-40 ans, sensible au design Apple/Linear}}
- **Niveau d'expertise** : {{grand public | pro | expert}}
- **Contexte d'usage** : {{ex: desktop entre sessions de code, mobile en transport, tablet en réunion}}
- **Attentes implicites** : {{ex: design clean, performance, sérieux, peu d'animations}}

---

## Objectif utilisateur

- **Action principale attendue** : {{ex: créer un compte gratuit}}
- **Action secondaire** : {{ex: voir une démo}}
- **Émotion à transmettre** : {{ex: confiance + simplicité}}

---

## Objectif business

- **KPI principal** : {{ex: taux de conversion home → signup ≥ 3%}}
- **KPI secondaire** : {{ex: temps moyen sur la home ≥ 30 s}}
- **Échéance / contexte** : {{ex: lancement public dans 4 semaines}}

---

## Style recherché

- **Ambiance** : {{ex: corporate clean / startup tech / artistique / luxe / éditorial / brutaliste}}
- **Références** : {{ex: Linear, Vercel, Cron — pas pour copier mais comme repère}}
- **À éviter absolument** : {{ex: gradients criards, stock photos corporate, animations de scroll agressives}}

---

## Contraintes

- **Charte graphique existante** : {{oui / non — si oui, joindre le lien}}
- **Couleurs imposées** : {{ex: #1e40af pour la marque, sinon libre}}
- **Polices imposées** : {{ex: Inter exigée, sinon libre}}
- **Stack** : {{ex: pas de React, projet PHP — pas d'imposition Tailwind}}
- **Délai** : {{ex: 5 jours-homme}}
- **Budget images** : {{ex: Unsplash gratuit OK, pas d'achat}}

---

## Pages concernées

| Page | Priorité | Notes |
|---|---|---|
| Homepage | 1 | hero + features + pricing + footer |
| Pricing | 2 | 3 plans + FAQ |
| Sign up | 3 | clean, court |
| Dashboard | 4 | (post-login, hors scope ici) |

---

## Inspirations à consulter

- **21st.dev** : catégories Heros / Pricing / CTA / Features
- **shadcn/ui** : briques atomiques
- **Lucide** : icônes
- **Sites de référence sectoriels** : {{liste}}

---

## Images nécessaires

| Emplacement | Type | Mots-clés | Source prévue |
|---|---|---|---|
| Hero homepage | photo immersive | {{ex: workstation clean, soft gradient}} | Pixabay / Unsplash |
| Section features 1 | mockup app | {{ex: dashboard interface}} | screenshot interne ou placeholder |
| Section testimonials | avatars | photos clients réels | fournis par client |

Cf. `templates/image-selection.template.md` pour le détail.

---

## Critères de succès

À la fin du redesign, le résultat doit valider :

- [ ] le **test du logo enlevé** (cf. `references/anti-basic-design-rules.md` §3) : on peut deviner secteur, cible et ton
- [ ] **score UI quality** ≥ 80 (cf. `templates/ui-quality-checklist.template.md`)
- [ ] aucun **flow critique cassé**
- [ ] **responsive** OK 4 breakpoints
- [ ] **accessibilité AA**
- [ ] design **adapté à la stack** existante
- [ ] **rapport de redesign** rendu (cf. `templates/redesign-report.template.md`)

---

## Risques identifiés

- {{ex: contenu hero pas encore validé par le client}}
- {{ex: photos de l'équipe absentes — utiliser placeholder sympa en attendant}}
- {{ex: budget Stripe non finalisé — pricing à mettre comme placeholder}}

---

## Décisions à valider avec l'utilisateur avant de coder

- [ ] **palette** finalisée
- [ ] **typographie** validée
- [ ] **shortlist composants 21st.dev** approuvée
- [ ] **shortlist images** approuvée
- [ ] **brief** lu et signé

---

Created by João de Almeida — Art of Dev — https://artofdev.space
