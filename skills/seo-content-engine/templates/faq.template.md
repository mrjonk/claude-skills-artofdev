# FAQ — {{TITRE_OU_SUJET}}

> FAQ standalone OU section FAQ d'un article.
> Created by João de Almeida

---

## Métadonnées (pour FAQ standalone)

```yaml
title: "{{Foire aux questions sur X}}"
meta_description: "{{Réponses aux questions fréquentes sur X. Catégories : ...}}"
slug: faq-{{kebab-case}}
schema_type: FAQPage
```

---

## Vue d'ensemble (FAQ standalone)

{{Introduction courte 2–3 phrases : à qui s'adresse la FAQ, comment l'utiliser, pointer vers le support si la question n'est pas couverte.}}

---

## {{Catégorie 1 — Concepts / définitions}}

### {{Question 1}}

{{Réponse claire et autonome (lisible sans avoir lu d'autre contenu). 2–4 phrases. Pas de "ça dépend" sans précision.}}

### {{Question 2}}

{{Réponse.}}

### {{Question 3}}

{{Réponse.}}

---

## {{Catégorie 2 — Mise en place / installation}}

### {{Question 4}}

{{Réponse.}}

### {{Question 5}}

{{Réponse.}}

### {{Question 6}}

{{Réponse.}}

---

## {{Catégorie 3 — Utilisation}}

### {{Question 7}}

{{Réponse.}}

### {{Question 8}}

{{Réponse.}}

---

## {{Catégorie 4 — Dépannage}}

### {{Question 9 — message d'erreur exact ou symptôme}}

{{Réponse précise : cause + solution.}}

### {{Question 10}}

{{Réponse.}}

---

## {{Catégorie 5 — Prix / abonnement / commercial}} (si applicable)

### {{Question 11}}

{{Réponse honnête, sans tone marketing.}}

### {{Question 12 — comment annuler ?}}

{{Réponse claire et sans friction.}}

---

## {{Catégorie 6 — Sécurité / confidentialité}} (si applicable)

### {{Question 13 — RGPD / données utilisateur}}

{{Réponse factuelle.}}

### {{Question 14}}

{{Réponse.}}

---

## Vous n'avez pas trouvé votre réponse ?

- [{{Documentation complète}}]({{/docs}})
- [{{Forum communautaire}}]({{URL}})
- [{{Contacter le support}}]({{/contact}})

---

## Schema.org (à activer côté CMS)

Si le CMS le permet, activer le balisage `FAQPage` pour rich results dans les SERPs.

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "{{Question 1}}",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "{{Réponse 1 en texte plat}}"
      }
    },
    {
      "@type": "Question",
      "name": "{{Question 2}}",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "{{Réponse 2}}"
      }
    }
  ]
}
```

La plupart des plugins SEO (Yoast, Rank Math, SEO Framework) le génèrent automatiquement à partir des blocs FAQ.

---

## Règles appliquées (cf. `references/faq-writing-guide.md`)

- [ ] questions **réellement** posées (sources : forum, support, PAA, AnswerThePublic)
- [ ] **3–8** questions par section (12 max pour une FAQ standalone, sinon créer plusieurs pages)
- [ ] aucune **variation** cosmétique de la même question
- [ ] aucune question **redondante** avec le corps d'un article qui pointerait vers cette FAQ
- [ ] réponses **claires** et **autonomes**
- [ ] pas de **"ça dépend"** sans précision
- [ ] pas de **tone marketing**
- [ ] **catégories** logiques (concepts, mise en place, utilisation, dépannage, prix, sécurité)
- [ ] **lien support** en bas de FAQ
- [ ] **`Schema.org FAQPage`** prévu côté CMS

---

Created by João de Almeida
