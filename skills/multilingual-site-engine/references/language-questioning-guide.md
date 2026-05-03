# Guide — comment demander les langues à l'utilisateur

`multilingual-site-engine` ne traduit **jamais** sans avoir cadré les langues. Ce guide donne les questions à poser et la manière de les poser.

Created by João de Almeida

---

## 1. Pourquoi demander avant de traduire

Sans cadrage explicite :

- on suppose une langue source qui n'est pas la bonne ;
- on traduit dans une langue qui n'était pas demandée ;
- on oublie une variante régionale (`fr-CH` vs `fr-FR`) ;
- on ne sait pas quelle est la langue **par défaut** (celle qui s'affiche en cas de fallback) ;
- on traduit des contenus qui ne devraient pas l'être (slogans, marques, citations) ;
- on rate une **langue RTL** qui exige un layout adapté.

Le coût d'une question prend 10 secondes. Le coût d'une mauvaise traduction se mesure en heures de retravail.

---

## 2. Questions obligatoires

### 2.1 Bloc minimum (toujours)

> **Avant de commencer, peux-tu me préciser :**
> 1. La **langue source** du site (FR, EN, autre) ?
> 2. Les **langues cibles** souhaitées (par exemple FR + EN + DE) ?
> 3. La **langue par défaut** (celle qui s'affiche si une traduction manque) ?
> 4. Y a-t-il des **textes existants** au style IA que tu veux humaniser au passage ?

### 2.2 Bloc avancé (si site complexe)

> **Pour aller plus loin :**
> 5. Veux-tu une **variante régionale** précise (`fr-FR`, `fr-CH`, `en-US`, `en-GB`, `pt-BR`, `pt-PT`) ?
> 6. Y a-t-il des **contenus à ne pas traduire** (slogans, citations, marques, codes) ?
> 7. Quelle **stratégie de routes** préfères-tu (sous-dossier `/fr/`, sous-domaine `fr.site.com`, domaine séparé `site.fr`, paramètre `?lang=fr`) ?
> 8. Le site a-t-il un **CMS** dont la traduction passe par un plugin (WPML, Polylang, etc.) ?

### 2.3 Bloc RTL (si arabe, hébreu, farsi, ourdou demandés)

> **Pour les langues RTL :**
> 9. Le layout est-il déjà préparé pour le **RTL** (`dir="rtl"`, CSS logique) ?
> 10. Y a-t-il une **police compatible** (toutes les polices ne supportent pas l'arabe ou l'hébreu) ?
> 11. Faut-il **inverser** les icônes directionnelles (flèches, breadcrumbs) ?

---

## 3. Comment formuler les questions

### Bonne approche

- **regrouper** les questions en un seul message clair ;
- **numéroter** pour faciliter la réponse ;
- **donner des exemples** entre parenthèses ;
- **expliquer pourquoi** la question est posée si elle paraît technique ;
- **rester concis** (max 6-8 questions par bloc).

### Mauvaise approche

- poser une seule question puis attendre, poser la suivante, etc. (ralentit) ;
- noyer l'utilisateur sous 20 questions techniques ;
- supposer qu'il connaît tous les acronymes (`hreflang`, `x-default`, `RTL`) ;
- redemander une question dont la réponse est déjà dans le repo ou la conversation.

---

## 4. Détection automatique avant de demander

Avant de poser des questions, **scanner** ce qui est déjà dans le repo pour ne pas redemander :

| Indice | Ce qu'on en déduit |
|---|---|
| `<html lang="fr">` dans `index.html` | langue source probable = FR |
| Dossier `locales/` avec `fr.json` et `en.json` | langues cibles probables = FR + EN |
| `wp-content/plugins/sitepress-multilingual-cms/` | WPML installé |
| `wp-content/plugins/polylang/` | Polylang installé |
| `next.config.js` avec `i18n: { locales: [...] }` | Next.js i18n configuré |
| `.po` dans `/locale/` | gettext utilisé |

Si la détection donne des indices clairs, **les présenter** dans la question :

> *"J'ai détecté un site Next.js avec i18n configuré pour FR + EN. Confirmes-tu que ce sont les langues cibles ? Veux-tu en ajouter d'autres ?"*

---

## 5. Ne jamais supposer

Même si la détection donne des indices forts, **demander confirmation** :

- un fichier `en.json` peut être obsolète ;
- une langue déclarée dans `next.config.js` peut ne pas être réellement utilisée ;
- la langue par défaut visible peut ne pas être celle attendue par l'utilisateur.

---

## 6. Cas spéciaux

### 6.1 Site bilingue où une langue est très incomplète

Détecter :
- nombre de clés en `fr.json` : 320 ;
- nombre de clés en `en.json` : 12.

Question :

> *"Je vois que la version anglaise contient seulement 12 clés alors que la version française en a 320. Souhaites-tu que je complète la traduction anglaise pour atteindre la parité ?"*

### 6.2 Site avec textes hardcodés non extraits

Détecter :
- nombreux strings dans des fichiers JSX / Vue / PHP non passés par `t()` ou `__()`.

Question :

> *"J'ai repéré des textes hardcodés non passés par le système i18n (par exemple `<button>Send</button>` au lieu de `<button>{t('send')}</button>`). Veux-tu que je les extraie d'abord avant de traduire ?"*

### 6.3 Stack monolingue à internationaliser

Si le projet n'a **aucun** système i18n :

> *"Le site n'a actuellement aucun système i18n. Avant de traduire, il faut choisir une bibliothèque (i18next, next-intl, react-intl, vue-i18n, gettext si PHP). Quelle est ta préférence, ou veux-tu que je recommande la plus adaptée à ta stack ?"*

---

## 7. Réponse minimale acceptable

Pour démarrer, le skill a **besoin** au minimum de :

- langue source ;
- au moins une langue cible ;
- langue par défaut.

Si l'utilisateur répond *"traduis en anglais"* sans plus de détail, demander juste :

> *"Compris, EN comme cible. Quelle est la langue source — FR ? Et la langue par défaut, FR ou EN ?"*

Pas plus. Ne pas noyer.

---

## 8. Quand passer outre

**Jamais** sans validation explicite. Même si l'utilisateur insiste *"vas-y, devine"*, le skill doit répondre :

> *"Je préfère cadrer 30 secondes maintenant pour éviter de retravailler 2 heures après. Voici les 3 questions minimum :"*

---

Created by João de Almeida
