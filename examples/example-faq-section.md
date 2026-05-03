# Exemple — FAQ section

## Contexte

Construction d'une FAQ standalone pour un produit / service / sujet donné.
Sujet générique réutilisable : *"FAQ d'une API publique"* (ex : API de gestion d'images, API de paiement, API de notifications).
Public : développeurs intégrant l'API.

## Prompt utilisateur

> *"Build a standalone FAQ page for a fictional API product. Audience : developers integrating the API. Tone : documentation (very clear, neutral, structured). Structure : short intro (3 sentences max), 4 categories (Concepts / Authentication / Endpoints / Troubleshooting), 3-5 questions per category, real questions (not invented), each answer 2-4 sentences and autonomous, Schema.org FAQPage block prepared, link to support / docs at the end, quality score."*

## Angle éditorial attendu

- **Documentation** : ton neutre, factuel, structuré ;
- **Questions réelles** : issues de Stack Overflow, GitHub Discussions, support ticket, People Also Ask ;
- **Réponses autonomes** : un développeur doit pouvoir répondre sans avoir lu d'autre page.

## Structure attendue

| Section | Contenu |
|---|---|
| Métadonnées | title, meta description, slug, schema FAQPage |
| Introduction (3 phrases) | qui c'est, comment l'utiliser, support |
| H2 — Concepts | 3–5 questions de définition |
| H2 — Authentification | 3–5 questions sur les clés API, tokens, OAuth |
| H2 — Endpoints | 3–5 questions sur les endpoints principaux |
| H2 — Dépannage | 3–5 questions sur les erreurs courantes |
| Vous n'avez pas trouvé ? | liens doc / forum / support |

**Total** : 12 à 20 questions, structurées par catégorie.

## SEO attendu

- **title** : *"FAQ — Questions fréquentes sur l'API X"* (45 car., **à allonger** pour atteindre 50–60) ;
- **meta description** : *"Réponses aux questions fréquentes sur l'API X : authentification, endpoints, dépannage. Liens vers la documentation et le support."* (148 car.) ;
- **slug** : `api-faq` ou `faq-api-x` ;
- **schema_type** : `FAQPage` ;
- **search_intent** : informationnelle / dépannage.

## Exemples de questions réelles à inclure

### Catégorie : Concepts

- *"Quelle est la différence entre les endpoints de l'API et le SDK officiel ?"*
- *"L'API supporte-t-elle GraphQL ou seulement REST ?"*
- *"Les requêtes sont-elles facturées au volume ou au temps de traitement ?"*

### Catégorie : Authentification

- *"Comment obtenir une clé API ?"*
- *"Quelle est la durée de vie d'un token OAuth ?"*
- *"Comment révoquer une clé API compromise ?"*
- *"L'API supporte-t-elle l'authentification par JWT ?"*

### Catégorie : Endpoints

- *"Quel est le rate limit par endpoint ?"*
- *"Les endpoints de pagination utilisent-ils des cursors ou des offsets ?"*
- *"Comment recevoir des webhooks pour les événements asynchrones ?"*
- *"Les réponses sont-elles cachées côté API ?"*

### Catégorie : Dépannage

- *"Pourquoi je reçois un 401 alors que ma clé semble valide ?"*
- *"L'erreur 429 'Too Many Requests' — comment l'éviter ?"*
- *"Les webhooks ne sont pas reçus, comment debugger ?"*
- *"Comment tester l'API sans consommer de quota ?"*

## Réponses — gabarit attendu

```markdown
### Comment obtenir une clé API ?

Connectez-vous au dashboard, ouvrez la section "API Keys" et cliquez sur
"Create new key". Donnez un nom à la clé (utile pour rotation), choisissez
les scopes nécessaires, puis copiez la clé immédiatement — elle ne sera
plus affichée ensuite. La clé est active dès création.
```

- **2–4 phrases** ;
- **autonome** (compréhensible sans contexte) ;
- **précise** (étapes concrètes, mots-clés UI exacts) ;
- **pas de "ça dépend"** sans précision.

## Schema.org FAQPage

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "Comment obtenir une clé API ?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Connectez-vous au dashboard, ouvrez la section 'API Keys'..."
      }
    }
  ]
}
```

À activer dans le CMS (Yoast, Rank Math, ou bloc FAQ Gutenberg).

## Liens internes possibles

| # | Slug cible | Ancre | Raison |
|---|---|---|---|
| 1 | `/docs/quickstart` | "guide de démarrage rapide" | onboarding |
| 2 | `/docs/api-reference` | "référence complète de l'API" | détail technique |
| 3 | `/docs/webhooks` | "guide des webhooks" | réponse à plusieurs questions |
| 4 | `/contact` | "contacter le support" | en bas de FAQ |

## Erreurs à éviter

- **questions inventées** sans correspondance avec un vrai besoin ;
- **8 variantes** de la même question reformulées ;
- **réponses qui bottent en touche** (*"Consultez la documentation"*) sans pointer vers un endroit précis ;
- **questions auxquelles la doc répond déjà** mot pour mot ;
- **tone marketing** : *"Notre API est conçue pour offrir une expérience inégalée !"* ;
- **réponses trop longues** (8 paragraphes) qui devraient être un article séparé ;
- **schéma FAQPage manquant** alors que c'est un usage idéal pour les rich results.

## Score qualité attendu

**80–90 / 100** — Bon contenu SEO. Premium si :
- les questions viennent **réellement** du support / forum (traçabilité) ;
- les réponses sont **autonomes** et précises ;
- le schéma FAQPage est correctement implémenté ;
- les liens internes pointent vers la doc effective.

---

Created by João de Almeida
