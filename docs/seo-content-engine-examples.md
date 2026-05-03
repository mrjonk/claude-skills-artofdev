# Exemples — `seo-content-engine`

Created by João de Almeida

10 prompts prêts à copier. Public-ready : aucune référence privée, réutilisables tels quels.

---

## 1. Article technique

```txt
/seo-content-engine Write a complete SEO article about how to optimize a Next.js
application with Server Components.

Public : intermediate React developers.
Tone : technical blog (clear, precise, pedagogical, no fluff).
Length : 1800 words.
Include :
- SEO metadata (title 50-60 chars, meta description 130-160 chars, slug)
- H1, H2/H3 logical structure
- code snippets with comments
- 3-6 internal link suggestions (specify target slugs and anchors)
- FAQ (4-6 real questions, no artificial ones)
- image plan (hero + section diagrams)
- official sources cited (React docs, Next.js docs)
- quality score out of 100

Mark any unverifiable claim as "TO VERIFY" in the draft.
```

---

## 2. Tutoriel débutant

```txt
/seo-content-engine Rédige un tutoriel simple pour installer Node.js sur Windows,
macOS et Linux.

Public : développeurs débutants, pas de jargon assumé.
Ton : tutoriel débutant (simple, direct, étape par étape, accessible, rassurant).
Longueur : 1200 mots.
Inclure :
- prérequis explicites
- étapes numérotées avec snippets de commandes pour chaque OS
- vérification après chaque étape
- erreurs courantes (au moins 3)
- FAQ (3-5 questions de débutant)
- liens internes vers tutoriels suivants
- captures d'écran à prévoir (description + alt text)
- sources : doc officielle Node.js
- score qualité éditoriale
```

---

## 3. Article SaaS

```txt
/seo-content-engine Write a SaaS-style blog article about why small teams
struggle with project tracking tools.

Audience : product managers and small SaaS founders.
Tone : SaaS (problem/solution, reassuring, non-aggressive conversion).
Length : 1500 words.

Structure :
- Pose the problem with concrete data (cite or mark TO VERIFY)
- Detail why standard tools fail at small scale
- Present an approach (not a product pitch)
- 2-3 anonymized mini case studies (or labeled as "typical situation")
- Common mistakes
- FAQ (objections handled)
- CTA : link to a guide or demo (placeholder OK)
- Internal links (3-6)
- Image plan
- Sources
- Quality score
```

---

## 4. Page produit

```txt
/seo-content-engine Create a product page for a fictional time-tracking SaaS for
freelancers.

Tone : product page (real benefits, concrete, credible, no vague promises).
Avoid : "the best", "the ultimate", "revolutionize", "next-level".

Include :
- H1 with product name + main benefit
- Problem solved (2-3 sentences, specific)
- Concrete benefits (3-4 measurable ones)
- "How it works" in 3 steps
- Use cases (2-3 personas)
- Social proof placeholders (real testimonials only or none)
- Features table
- Pricing (3 plans, prices clear)
- FAQ (7+ real objections handled)
- Internal links
- Image plan (mockups, real screenshots)
- 1 main CTA + 1 secondary
- Quality score
```

---

## 5. FAQ standalone

```txt
/seo-content-engine Build a standalone FAQ page for a fictional API product.

Audience : developers integrating the API.
Tone : documentation (very clear, neutral, structured).

Structure :
- Short intro (3 sentences max)
- 4 categories : Concepts / Authentication / Endpoints / Troubleshooting
- 3-5 questions per category (real questions, not invented)
- Each answer 2-4 sentences, autonomous (readable without prior context)
- Schema.org FAQPage block prepared
- Link to support / docs at the end
- Quality score
```

---

## 6. Audit d'article existant

```txt
/seo-content-engine Audit this existing article (paste full text below).

Focus on :
- generic paragraphs that could fit any topic
- empty marketing phrases (cf. anti-bullshit-rules.md)
- repetitions (heading or sentence-level)
- unsourced statistics or citations
- artificial FAQ
- aggressive or generic CTA
- weak SEO structure

Output :
- score (0-100) with detail per criterion
- list of CRITICAL / IMPORTANT / MINOR issues
- top 3 immediate actions
- DO NOT rewrite the article. Just produce the audit report.

[Article content here]
```

---

## 7. Article avec sources (avec accès web)

```txt
/seo-content-engine Write a comparative article : "PostgreSQL vs MySQL for small
SaaS in 2026 — what to pick".

Audience : technical co-founders and CTOs.
Tone : expert (in-depth, sourced, structured).
Length : 2500 words.

REQUIREMENTS :
- All claims about features must cite official docs (PostgreSQL or MySQL).
- All performance claims must cite a benchmark (with name, year, URL).
- All version-specific claims must specify the version (e.g., "PostgreSQL 16+").
- Comparison table required.
- Use case "pick PostgreSQL when..." vs "pick MySQL when..." sections.
- FAQ with 6 honest questions.
- Sources section at the end, categorized (docs / benchmarks / articles).
- Internal links suggested.
- Image plan.
- Quality score.

If you cannot verify a claim, mark it "TO VERIFY" — do not invent sources.
```

---

## 8. Article sans accès web (sources à vérifier)

```txt
/seo-content-engine I need an article on "best practices for designing accessible
web forms". I won't have web access during writing — that's expected.

Audience : front-end developers.
Tone : technical blog, with WCAG guidelines references.

Requirements :
- Be EXPLICIT that web access wasn't available
- Use prudent formulations ("according to WCAG guidelines (to verify)...")
- Add a "Sources to verify before publication" section
- Don't invent statistics
- Don't invent quotes
- Provide a structure I can fact-check easily before publication

Length : 1800 words.
Include FAQ, internal link suggestions, image plan, quality score.
```

---

## 9. Page service

```txt
/seo-content-engine Write a service page for a fictional consulting business :
"SEO content audit service for small businesses".

Tone : product/service page (concrete benefits, credible).
Avoid : superlatives, vague promises.

Structure :
- Hero : service name + main benefit
- The problem solved (specific to small businesses)
- What's included in the service (deliverables, clear list)
- Process (3-5 steps with timing)
- Who it's for (audience clarified)
- What clients get at the end (specific outputs)
- Pricing (or pricing tier hint if not flat)
- FAQ (7-10 real objections : duration, approach, deliverables, follow-up, refund)
- Testimonials placeholder (real ones only)
- CTA : "request a quote" or "book a discovery call"
- Internal links
- Image plan
- Quality score
```

---

## 10. Long-form pillar

```txt
/seo-content-engine Build a long-form pillar article : "The complete guide to
technical SEO for static sites".

Audience : technical content creators, indie developers, small teams.
Tone : expert / pillar (in-depth, structured, authoritative, sourced).
Length : 4000 words minimum.

Structure :
- Long introduction (5-7 sentences setting up the field)
- 8-10 H2 sections covering :
  - core concepts
  - meta tags and structured data
  - sitemap and robots.txt
  - internal linking strategy
  - image optimization
  - Core Web Vitals
  - canonicals and pagination
  - schema.org for static sites
  - common pitfalls
  - tooling recommendations
- Sub-pillars (H3) under each H2
- Comparison tables where useful
- 8-12 question FAQ
- Sources : Google Search Central, MDN, Web.dev, RFC if applicable
- 5-8 internal link suggestions toward sub-articles to write
- Image plan with diagrams
- Conclusion : not a summary, but a forward-looking note
- Quality score targeting ≥ 88
```

---

## Notes d'utilisation

- **Tous ces prompts sont génériques** — réutilisables tels quels par n'importe qui.
- **Aucune référence privée** : pas de marque, pas de site personnel, pas de projet spécifique.
- **À adapter** selon la stack et le contexte du projet où on les utilise.

---

Created by João de Almeida
