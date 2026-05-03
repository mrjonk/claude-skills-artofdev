# Récapitulatif consolidé — placeholders, variables, dynamic content

> Référence centrale : tous les patterns à préserver lors d'une traduction, regroupés par technologie.

Created by João de Almeida

---

## 1. Règle d'or

Tout pattern listé ci-dessous **ne se traduit jamais**. Il reste **identique** dans toutes les langues, à la même position dans la chaîne (sauf cas explicitement notés où l'ordre des positionnels peut changer).

Si un placeholder disparaît ou est altéré, la chaîne se casse au runtime.

---

## 2. Placeholders nommés (style moderne)

### 2.1 `{name}` — i18next, next-intl, FormatJS

```json
"hello": "Hello, {name}!"     // EN
"hello": "Bonjour, {name} !"  // FR
```

Règle : `{name}` reste tel quel. Espace insécable optionnel selon la langue (FR met une espace avant `!`, EN n'en met pas).

### 2.2 `{{count}}` — Mustache, Handlebars, vue-i18n

```json
"items": "You have {{count}} items"
```

Double accolade. Préserver les **deux** accolades.

### 2.3 ICU MessageFormat — pluriels et formats

```json
"items": "{count, plural, =0 {No items} one {# item} other {# items}}"
```

Préserver :
- la **structure** entière `{var, type, ...}` ;
- le `#` qui se substitue à la variable dans la branche ;
- les **catégories** valides selon la langue (`one`, `other`, `few`, `many`, `two`, `zero`) — adapter à la langue cible.

Exemple FR vs RU :

```json
// EN
"{count, plural, one {# item} other {# items}}"

// RU (3 catégories)
"{count, plural, one {# элемент} few {# элемента} many {# элементов} other {# элемента}}"
```

---

## 3. Placeholders positionnels (style legacy / sprintf)

### 3.1 `%s`, `%d`, `%f` — gettext, sprintf, PHP

```php
__( 'Hello, %s', 'mytheme' );
```

Préserver à l'identique. Le **type** (`%s`, `%d`) ne change pas selon la langue.

### 3.2 `%1$s`, `%2$s`, `%1$d` — positionnels numérotés

```php
__( '%1$s likes %2$s', 'mytheme' );
```

Permet d'**inverser l'ordre** dans une autre langue :

```
msgid "%1$s likes %2$s"
msgstr "%2$s est aimé par %1$s"   // exemple, l'ordre des positionnels change
```

Préserver les **numéros** (`$1`, `$2`) et le format global. C'est l'un des rares cas où l'ordre peut bouger.

---

## 4. Placeholders de framework spécifique

### 4.1 Laravel

```php
trans('greetings.hello', ['name' => 'João']);
// fichier : 'hello' => 'Bonjour, :name'
```

Pattern : `:name`, `:user`, `:count`. Préserver le `:` initial.

### 4.2 Rails / I18n

```yaml
# fr.yml
greeting: "Bonjour, %{name}"
```

Pattern : `%{name}`. Préserver `%{...}`.

### 4.3 Symfony / Twig

```yaml
greeting: "Bonjour, {{ name }}"
```

Avec espaces : `{{ name }}` (style Twig). Préserver les espaces si présents.

### 4.4 Django / Python

```python
gettext("Hello, %(name)s") % {'name': 'João'}
```

Pattern : `%(name)s`. Préserver entièrement.

### 4.5 JS template literals

```ts
const msg = `Hello, ${name}!`;
```

Pattern : `${name}`. Mais attention : si la chaîne est dans un fichier de traduction, ce **n'est pas** un template literal — c'est juste du texte. Le code qui interpole est ailleurs.

---

## 5. Balises HTML / composants dans les chaînes

### 5.1 Balises HTML inline

```json
"intro": "Welcome to <strong>ArtOfDev</strong>!"
```

Préserver les balises (`<strong>`, `<em>`, `<a>`, `<br>`). Traduire le texte **entre** les balises.

### 5.2 i18next Trans component — placeholders indexés

```tsx
<Trans i18nKey="welcome">
  Welcome <strong>{{name}}</strong>! <a href="/about">Learn more</a>
</Trans>
```

Dans le JSON :

```json
"welcome": "Welcome <1>{{name}}</1>! <3>Learn more</3>"
```

Préserver `<0>`, `<1>`, `<2>`, `<3>` (composants enfants indexés).

### 5.3 next-intl rich text

```tsx
t.rich('terms', {
  link: (chunks) => <a href="/terms">{chunks}</a>,
});
```

Dans le JSON :

```json
"terms": "Read our <link>terms</link>"
```

Préserver `<link>...</link>` — c'est le tag de remplacement.

### 5.4 BBCode-like

```
"[link]Read more[/link]"
```

Préserver les balises encadrantes. Plus rare aujourd'hui.

---

## 6. WordPress — `__()`, `_e()`, etc.

Cf. `stack-wordpress-theme-guide.md` §3.

Le **premier argument** se traduit. Le **textdomain** (2e argument) ne se traduit jamais.

```php
__( 'Welcome', 'mytheme' );
//   ^---- traduit            ^---- jamais traduit
```

Pluriels avec `_n()` :

```php
_n( '%s comment', '%s comments', $count, 'mytheme' );
```

Les deux msgid (singulier + pluriel) entrent dans le `.po` comme paire `msgid` / `msgid_plural`.

---

## 7. Shortcodes WordPress

```
[gallery ids="1,2,3" columns="3"]
[contact-form-7 id="42" title="Contact"]
```

Le **nom du shortcode** ne se traduit jamais. Les **attributs techniques** (`ids`, `columns`, `id`) non plus. Le **`title=`** lisible peut, dans certains cas, être traduit — à confirmer selon le contexte.

Règle pratique : laisser le shortcode brut, ne pas le toucher. Si le client veut traduire un titre dedans, c'est la responsabilité du plugin (Polylang Strings, WPML String Translation).

---

## 8. JSX brut en React / Next.js

```tsx
<p>{count} items</p>
```

`{count}` est une expression JS, pas un placeholder de traduction. Pour traduire :

```tsx
<p>{t('items', { count })}</p>
```

Et dans le JSON :

```json
"items": "{count, plural, one {# item} other {# items}}"
```

Le skill ne touche **jamais** au JSX. Il extrait, place dans le JSON, et appelle `t()`.

---

## 9. URLs et chemins

| Élément | À traduire ? |
|---|---|
| `https://...` | NON |
| `/contact` | dépend (slug traduit ou non — décision documentée) |
| `mailto:contact@site.com` | NON |
| `tel:+33...` | NON |
| `#anchor` | dépend (souvent en-clear, mais une ancre `#about` peut devenir `#a-propos`) |

Règle générale : un slug est traduit **seulement** si la stratégie de routes le prévoit (cf. `route-and-slug-localization.md`).

---

## 10. Codes machine — JAMAIS traduits

| Type | Exemple |
|---|---|
| Codes d'erreur API | `INVALID_PAYLOAD`, `AUTH_FAILED` |
| Identifiants techniques | `user-id`, `session-token` |
| Variables d'environnement | `DATABASE_URL` |
| Noms de hooks | `wp_head`, `useEffect` |
| Sélecteurs CSS | `.site-header`, `#main` |
| Attributs HTML structurels | `name="email"`, `type="submit"` |
| Codes de devise ISO | `EUR`, `USD`, `CHF` (en `<meta>` techniques) |
| Codes de pays ISO | `FR`, `US`, `DE` |
| Codes de langue | `fr`, `en`, `de` |

Le **symbole** d'une devise (`€`, `$`, `CHF`) peut être affiché de façon traduite/localisée. Le **code ISO** non.

---

## 11. Formats numériques et de date

Ces patterns sont **localisés**, pas traduits littéralement.

| Locale | Date | Heure | Nombre |
|---|---|---|---|
| `fr-FR` | 03/05/2026 | 14:30 | 1 234,56 |
| `fr-CH` | 03.05.2026 | 14:30 | 1'234.56 |
| `en-US` | 5/3/2026 | 2:30 PM | 1,234.56 |
| `en-GB` | 03/05/2026 | 14:30 | 1,234.56 |
| `de-DE` | 03.05.2026 | 14:30 | 1.234,56 |
| `pt-BR` | 03/05/2026 | 14:30 | 1.234,56 |

Le code applicatif doit utiliser `Intl.DateTimeFormat`, `Intl.NumberFormat`, `date_i18n` (WP), ou équivalent.

---

## 12. Récap par stack — tableau de référence

| Pattern | PHP statique | Next.js + next-intl | Next.js + i18next | WordPress thème | Laravel | Rails | Django |
|---|---|---|---|---|---|---|---|
| `{name}` | si custom helper | OUI | NON | NON | NON | NON | NON |
| `{{count}}` | NON | NON | OUI | NON | NON | NON | NON |
| `%s`, `%d` | OUI | NON | NON | OUI | NON | NON | NON |
| `%1$s`, `%2$s` | OUI | NON | NON | OUI | NON | NON | NON |
| `:name` | NON | NON | NON | NON | OUI | NON | NON |
| `%{name}` | NON | NON | NON | NON | NON | OUI | NON |
| `%(name)s` | NON | NON | NON | NON | NON | NON | OUI |
| `${var}` | NON | NON | NON | NON | NON | NON | NON |
| `<0>...</0>` | NON | NON | OUI | NON | NON | NON | NON |
| `<link>...</link>` | NON | OUI | NON | NON | NON | NON | NON |
| `__()`, `_e()` | NON | NON | NON | OUI | NON | NON | NON |
| ICU plural | NON | OUI | OUI | NON | NON | NON | NON |
| `_n()` plural | NON | NON | NON | OUI | NON | NON | NON |

---

## 13. Procédure de vérification post-traduction

Pour chaque chaîne traduite, vérifier que :

1. **tous** les placeholders du source sont **présents** dans la traduction ;
2. les placeholders sont **identiques** caractère par caractère (`{name}` ≠ `{ name }`) ;
3. les balises HTML / composants ouvrent **et** ferment ;
4. les positionnels numérotés (`%1$s`, `%2$s`) ne sont pas confondus ;
5. les pluriels ICU couvrent toutes les catégories de la langue cible ;
6. les codes machine (textdomains, codes d'erreur) sont **inchangés**.

Un script de vérification (`scripts/diff-i18n-keys.sh` ou équivalent) peut détecter automatiquement les placeholders disparus.

---

Created by João de Almeida
