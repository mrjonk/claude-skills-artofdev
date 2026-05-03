# Guide formats locaux — `multilingual-site-engine`

Comment afficher dates, heures, nombres, monnaies et adresses selon la locale.

Created by João de Almeida

---

## 1. Pourquoi c'est important

Une traduction sans formats locaux donne :

- une date `5/3/2026` ambiguë (mai ? mars ?) ;
- un nombre `1,000.50` qui en français signifie *"mille virgule zéro cinq"* ;
- une monnaie `$120` affichée à un client français qui paie en EUR ;
- un téléphone `(415) 555-1234` incompréhensible au format français ;
- une adresse au mauvais ordre.

Les utilisateurs perdent confiance quand les formats locaux sont faux.

---

## 2. Dates

### 2.1 Formats courants

| Locale | Format | Exemple (3 mai 2026) |
|---|---|---|
| `fr-FR` | DD/MM/YYYY | 03/05/2026 |
| `fr-CH` | DD.MM.YYYY | 03.05.2026 |
| `en-US` | MM/DD/YYYY | 5/3/2026 |
| `en-GB` | DD/MM/YYYY | 3/5/2026 |
| `de-DE` | DD.MM.YYYY | 03.05.2026 |
| `es-ES` | DD/MM/YYYY | 3/5/2026 |
| `pt-BR` | DD/MM/YYYY | 03/05/2026 |
| `ja-JP` | YYYY/MM/DD | 2026/05/03 |
| `zh-CN` | YYYY/MM/DD | 2026/5/3 |
| ISO (technique) | YYYY-MM-DD | 2026-05-03 |

### 2.2 Mois en toutes lettres

| Locale | Format long |
|---|---|
| `fr-FR` | 3 mai 2026 |
| `en-US` | May 3, 2026 |
| `en-GB` | 3 May 2026 |
| `de-DE` | 3. Mai 2026 |
| `es-ES` | 3 de mayo de 2026 |

### 2.3 API JS

Utiliser `Intl.DateTimeFormat` :

```js
new Intl.DateTimeFormat('fr-FR', {
  year: 'numeric', month: 'long', day: 'numeric'
}).format(new Date('2026-05-03'));
// "3 mai 2026"

new Intl.DateTimeFormat('en-US', {
  year: 'numeric', month: 'long', day: 'numeric'
}).format(new Date('2026-05-03'));
// "May 3, 2026"
```

### 2.4 Bibliothèques

- **`date-fns`** + locale modules ;
- **`luxon`** ;
- **`dayjs`** + locale plugins ;
- **`Temporal`** (proposal natif).

---

## 3. Heures

| Locale | Format | Exemple |
|---|---|---|
| `fr-FR` | 24h, `HH'h'mm` ou `HH:MM` | 14h30 / 14:30 |
| `en-US` | 12h, AM/PM | 2:30 PM |
| `en-GB` | mixte, souvent 24h | 14:30 |
| `de-DE` | 24h | 14:30 |

---

## 4. Nombres

### 4.1 Séparateurs

| Locale | Milliers | Décimales | Exemple |
|---|---|---|---|
| `fr-FR` | espace insécable | virgule | 1 000,50 |
| `fr-CH` | apostrophe | point | 1'000.50 |
| `en-US` | virgule | point | 1,000.50 |
| `en-GB` | virgule | point | 1,000.50 |
| `de-DE` | point | virgule | 1.000,50 |
| `es-ES` | point | virgule | 1.000,50 |

### 4.2 API JS

```js
new Intl.NumberFormat('fr-FR').format(1000.5);  // "1 000,5"
new Intl.NumberFormat('en-US').format(1000.5);  // "1,000.5"
new Intl.NumberFormat('de-DE').format(1000.5);  // "1.000,5"
```

---

## 5. Monnaies

### 5.1 Format

| Locale | Symbole | Position | Exemple |
|---|---|---|---|
| `fr-FR` | € | après, espace insécable | 1 200,00 € |
| `fr-CH` | CHF / Fr. | avant | CHF 1'200.00 |
| `en-US` | $ | avant, sans espace | $1,200.00 |
| `en-GB` | £ | avant, sans espace | £1,200.00 |
| `de-DE` | € | après, espace | 1.200,00 € |
| `ja-JP` | ¥ | avant, sans espace | ¥1,200 |

### 5.2 API JS

```js
new Intl.NumberFormat('fr-FR', { style: 'currency', currency: 'EUR' })
  .format(1200);
// "1 200,00 €"

new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' })
  .format(1200);
// "$1,200.00"
```

### 5.3 Conversion

Si le site affiche des prix dans plusieurs monnaies :

- l'API du backend doit renvoyer la **monnaie locale** ;
- ne jamais convertir côté front sans taux à jour ;
- documenter la **monnaie de référence** (souvent EUR ou USD pour la facturation).

---

## 6. Pluriels

Cf. `translation-quality-guide.md` pour les pluriels par langue.

ICU MessageFormat :

```
{count, plural,
  =0 {no items}
  one {one item}
  other {# items}
}
```

Bibliothèques :
- **`messageformat`** (npm) ;
- **`@formatjs/intl-messageformat`** ;
- **`i18next`** support natif.

---

## 7. Adresses

### Ordre des champs

| Locale | Ordre |
|---|---|
| `fr-FR` | Nom, Adresse, Code postal Ville, Pays |
| `en-US` | Name, Street, City State ZIP, Country |
| `en-GB` | Name, Street, City Postcode, Country |
| `de-DE` | Name, Strasse Nummer, PLZ Stadt, Land |
| `ja-JP` | Pays, Code postal, Préfecture, Ville, Quartier, Numéro, Nom |

→ Un formulaire d'adresse multilingue doit **adapter les champs** selon la locale, pas juste les libellés.

---

## 8. Téléphones

- **préfixe international** (`+33`, `+1`, `+41`) ;
- **format** local pour l'affichage (`+33 1 23 45 67 89` vs `(415) 555-1234`) ;
- bibliothèque : **`libphonenumber`** (Google) — référence.

---

## 9. Noms

### Ordre prénom / nom

| Locale | Ordre |
|---|---|
| FR / EN / DE / ES / IT / PT | Prénom, Nom |
| ZH / JA / KO / HU / VI | Nom, Prénom |

→ Adapter le formulaire d'inscription si la cible est asiatique.

### Civilités

- FR : M., Mme, Mlle (en disparition) ;
- EN : Mr., Mrs., Ms., Mx. ;
- DE : Herr, Frau, Divers.

---

## 10. Format des fichiers

- **CSV** : séparateur virgule (EN) vs point-virgule (FR Excel) ;
- **CSV** : encoding UTF-8 avec BOM pour Excel FR ;
- **PDF** : pages localisées par langue.

---

## 11. Premier jour de la semaine

| Locale | Premier jour |
|---|---|
| `fr-FR`, `de-DE`, `en-GB` | lundi |
| `en-US`, `ja-JP` | dimanche |
| pays musulmans | samedi (parfois) |

→ Pour un calendrier UI, utiliser `Intl.Locale.weekInfo` (récent) ou bibliothèque date.

---

## 12. Fuseau horaire

- **stocker** en UTC ;
- **afficher** dans le fuseau de l'utilisateur ;
- préciser le fuseau à côté de l'heure si ambigu (*"14h30 (heure de Paris)"*).

---

## 13. Anti-patterns

- date `5/3/2026` ambiguë sans contexte ;
- `1,000.50 EUR` à un user français (séparateurs anglais) ;
- prix en `$` avec un user FR sans option de conversion ;
- formulaire d'adresse au format US imposé pour la France ;
- téléphone sans préfixe international ;
- `am/pm` imposé à un user en `fr-FR` ;
- premier jour de semaine `dimanche` pour un calendrier FR.

---

## 14. Checklist formats locaux

- [ ] `Intl.DateTimeFormat` ou bibliothèque utilisée pour les dates ;
- [ ] `Intl.NumberFormat` pour les nombres ;
- [ ] `Intl.NumberFormat` (style currency) pour les monnaies ;
- [ ] pluriels gérés par MessageFormat ;
- [ ] adresses avec ordre adapté à la locale ;
- [ ] téléphones avec préfixe international ;
- [ ] noms avec ordre adapté ;
- [ ] fuseau horaire géré ;
- [ ] premier jour de semaine localisé ;
- [ ] CSV avec séparateur adapté ;
- [ ] tests de formats sur les locales clés.

---

Created by João de Almeida
