# Fixture 2 — `nextjs-multilingual`

> Created by João de Almeida
> Fixture de validation pour le skill `multilingual-site-engine`.

## Stack simulée

Next.js 14+ App Router avec `next-intl`. Architecture :

```
nextjs-multilingual/
├── app/
│   ├── layout.tsx               # Layout global + header + footer
│   ├── page.tsx                 # Homepage (hero + 3 cards + plural)
│   ├── contact/page.tsx         # Formulaire React avec erreurs
│   └── api/contact/route.ts     # API route — NE PAS traduire
├── messages/
│   ├── en.json                  # Traductions anglaises (référence)
│   └── fr.json                  # Traductions françaises
└── next-intl.config.ts          # Config next-intl (locales, defaultLocale)
```

## Demande utilisateur simulée

> *"Ajoute l'allemand (de) à ce site Next.js. Conserve les mêmes clés et le même format ICU pour les pluriels."*

## Ce que le skill devrait faire

1. **Détecter la stack** Next.js App Router + `next-intl` (présence de `next-intl.config.ts` et `messages/{locale}.json`).
2. **Lire les clés existantes** dans `messages/en.json` et `messages/fr.json` pour confirmer le miroir.
3. **Demander confirmation** sur la régionalité allemande (`de` standard ? `de-DE` ? `de-CH` ?). La spec impose de demander si non précisé.
4. **Créer `messages/de.json`** avec exactement les mêmes clés.
5. **Préserver l'ICU plural** : `{count, plural, =0 {...} one {# ...} other {# ...}}`.
6. **Préserver les variables JSX** : `{count}`, `{year}` dans les chaînes restent intactes.
7. **Mettre à jour `next-intl.config.ts`** : `locales = ['en', 'fr', 'de']`.
8. **Documenter dans le rapport** : routes à créer (`/de/`, `/de/contact`), middleware à ajuster, hreflang à étendre.
9. **Suggérer** la mise à jour des metadata (`<title>`, `<meta description>`) en allemand pour chaque page.

## Ce qu'il NE DOIT PAS faire

- modifier `app/api/contact/route.ts` (code technique, JSON d'erreur sont des codes machine — `INVALID_PAYLOAD` reste anglais) ;
- traduire les noms de clés JSON (`hero`, `cards`, `errors`) ;
- traduire les noms de variables (`count`, `year`) ;
- traduire `className`, `aria-label` (la valeur `aria_label` est dans les messages, donc passe par `t()`, mais la prop JSX `aria-label` elle-même ne change pas) ;
- toucher aux `<a href="/">` (le routing locale-aware est géré par `next-intl`, le href reste neutre).

## Points de friction attendus

- **ICU plural** est un format complexe. Le skill doit produire un pluriel allemand correct (`{count, plural, =0 {Noch kein Projekt} one {# Projekt geliefert} other {# Projekte geliefert}}`).
- **Variables JSX `{count}`, `{year}`** : ce sont des interpolations next-intl, pas du JSX — distinction subtile.
- **Routing** : ajouter `de` ne suffit pas, il faut documenter le middleware et la stratégie de redirection (la spec interdit l'auto-detect par `Accept-Language`).
- **Hreflang à étendre** : si le site était déjà servi en `/fr/` et `/en/`, ajouter `/de/` impose de recalculer toutes les balises `<link rel="alternate">` réciproquement.

## Score readiness attendu (estimation manuelle)

- Translation Quality Score : ~80-90 si l'allemand est traité avec attention au registre (le pluriel ICU doit être exact, pas du calque depuis l'anglais).
- Multilingual Site Readiness Score : ~70-85 (l'archi est saine, il manque juste à étendre la config et à recalculer hreflang/sitemap).

## Comment tester ce fixture en runtime (humain)

1. Ouvrir une session Claude Code dans ce dossier.
2. Lancer : *"Ajoute l'allemand (de) à ce site Next.js."*
3. Vérifier que le skill :
   - a demandé la régionalité (ou a documenté son choix par défaut) ;
   - a créé `messages/de.json` avec les mêmes clés ;
   - a préservé `{count}`, `{year}`, `{name}` dans les chaînes ;
   - a préservé l'ICU plural avec une syntaxe valide ;
   - a mis à jour `next-intl.config.ts` ;
   - n'a pas touché à `app/api/contact/route.ts` ;
   - a documenté la stratégie hreflang étendue à 3 langues.
