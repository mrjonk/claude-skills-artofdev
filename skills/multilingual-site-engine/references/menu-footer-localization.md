# Guide localisation menus / footers — `multilingual-site-engine`

Comment traduire et adapter menus et footers sans casser la cohérence ergonomique.

Created by João de Almeida

---

## 1. Pourquoi traiter menus et footers à part

Les menus et footers :

- apparaissent sur **toutes** les pages ;
- sont les premiers éléments **vus** ;
- contiennent les **liens vers les pages clés** ;
- doivent être traduits **et** pointés vers les **bonnes versions linguistiques**.

Un menu mal traduit ou mal pointé casse la navigation entière du site.

---

## 2. Règles communes

### 2.1 Mêmes liens, même ordre

Dans toutes les langues, le menu doit avoir :

- les **mêmes items** (sauf justification réelle) ;
- dans le **même ordre** ;
- avec un **libellé traduit** (pas de mélange `Home / Accueil`).

### 2.2 Switch langue toujours visible

- placé en **haut** (header) ou **en bas** (footer) ;
- visible **mobile** et **desktop** ;
- libellé clair (`FR / EN / DE` ou drapeaux + nom de la langue).

### 2.3 Ne pas traduire les éléments techniques

- noms de marque ;
- noms propres de fonctionnalités si la marque les garde tels quels ;
- pictogrammes / icônes (Tx CSS).

---

## 3. Menus

### 3.1 Cas simple — menu statique

```json
// menu/fr.json
{
  "home": "Accueil",
  "about": "À propos",
  "services": "Services",
  "blog": "Blog",
  "contact": "Contact"
}

// menu/en.json
{
  "home": "Home",
  "about": "About",
  "services": "Services",
  "blog": "Blog",
  "contact": "Contact"
}
```

→ **mêmes clés**, libellés traduits.

### 3.2 Cas avec sous-menus

Toutes les sections et sous-sections traduites.

### 3.3 Menu dynamique (CMS)

Si le menu est géré dans le CMS (WordPress, Strapi) :

- créer un **menu par langue** dans le CMS ;
- s'assurer que le frontend appelle le bon menu selon la locale.

### 3.4 Menus admin

Si le site a un panel admin, traduire **les libellés admin** dans la langue de l'admin connecté (souvent EN par défaut) — ne pas oublier.

---

## 4. Footers

### 4.1 Sections classiques

| Section | Traduire |
|---|---|
| Logo / nom marque | non (sauf adaptation locale) |
| Liens produits | oui (libellés) |
| Liens entreprise | oui (À propos, Carrières, Presse) |
| Liens ressources | oui (Blog, Aide, Documentation) |
| Liens légaux | **oui obligatoire** (mentions, CGV, RGPD, cookies) |
| Liens sociaux | non (URL identiques, libellés non) |
| Newsletter | oui (titre, label, bouton) |
| Copyright | oui (texte autour de l'année) |
| Adresse postale | oui (format local si plusieurs entités) |

### 4.2 Liens légaux

Cf. `references/forms-errors-emails-localization.md` pour la conformité RGPD multilingue.

- chaque langue doit avoir ses **mentions légales** propres ;
- la **politique de confidentialité** est obligatoire si collecte de données ;
- la **politique cookies** doit être traduite si le site utilise des trackers.

Si le site est seulement traduit pour faciliter la lecture (pas de présence légale dans la langue cible), les mentions peuvent rester dans la langue source mais doivent être **étiquetées** clairement.

### 4.3 Newsletter

- titre traduit ;
- label de champ traduit ;
- bouton traduit ;
- message de succès / erreur traduit ;
- la liste **destinataire** dans le tool d'emailing peut avoir des segments par langue.

### 4.4 Copyright

```html
<!-- FR -->
<p>&copy; 2026 NomDeMarque. Tous droits réservés.</p>

<!-- EN -->
<p>&copy; 2026 BrandName. All rights reserved.</p>

<!-- DE -->
<p>&copy; 2026 MarkenName. Alle Rechte vorbehalten.</p>
```

Année toujours **dynamique** (pas de `2024` en dur).

---

## 5. Liens internes du footer

Chaque lien doit pointer vers la **version traduite** correspondante :

```html
<!-- Sur /fr/ -->
<a href="/fr/mentions-legales">Mentions légales</a>

<!-- Sur /en/ -->
<a href="/en/legal-notice">Legal notice</a>
```

Pas de lien `/legal-notice` qui marche pour l'EN mais casse pour le FR.

---

## 6. Erreurs fréquentes

### 6.1 Mix linguistique

Footer FR avec libellés EN au milieu :

```html
<a href="/fr/contact">Nous contacter</a>
<a href="/fr/about">About us</a>  <!-- mélange -->
<a href="/fr/legal">Mentions légales</a>
```

→ tout traduire ou rien.

### 6.2 Ordre divergent

Menu FR : Accueil, Services, À propos, Blog, Contact.
Menu EN : Home, About, Services, Contact, Blog.

→ mêmes liens, **même ordre**.

### 6.3 Libellés différents pour la même fonction

Menu FR : *"Nous contacter"*.
Menu EN : *"Get in touch"*.
CTA en bas de page FR : *"Contacter l'équipe"*.

→ choisir un terme par langue et **le garder**.

### 6.4 Switch langue cassé

Sur `/fr/contact`, cliquer sur EN renvoie sur `/en/` (perte du chemin) au lieu de `/en/contact`.

→ implémentation classique cassée.

### 6.5 Liens admin visibles

Menu public qui inclut un lien `/admin` ou `/dashboard` dans une seule langue (parce que le développeur a oublié de l'enlever de la version traduite).

---

## 7. CTA dans menu / footer

### Règle

Un CTA principal au menu **doit** être :

- traduit ;
- pointer vers la version traduite de la page de destination ;
- garder le même **rôle** (tous les CTA *"S'inscrire"* sur le site mènent au même funnel).

### Exemple

| FR | EN | DE |
|---|---|---|
| *"Essayer gratuitement"* | *"Try for free"* | *"Kostenlos testen"* |
| → `/fr/inscription` | → `/en/signup` | → `/de/registrierung` |

---

## 8. Mobile

- menu mobile (burger / drawer) **identique** à desktop en libellés ;
- switch langue **accessible** (pas caché tout en bas dans un sous-menu invisible) ;
- pas d'overflow horizontal causé par un libellé allemand trop long.

---

## 9. Composant partagé

### Bonne architecture

- un seul **composant** Header / Footer ;
- les libellés viennent du système i18n ;
- les liens viennent d'un **mapping de routes** localisé.

### Mauvaise architecture

- un Header par langue (`HeaderFR.tsx`, `HeaderEN.tsx`) ;
- un Footer par langue ;
- des conditions `{lang === 'fr' ? 'Accueil' : 'Home'}` partout.

→ refactoriser vers un composant unique avec i18n propre.

---

## 10. Tester menus / footers traduits

### Manuellement

- ouvrir chaque page traduite ;
- vérifier que **menu** et **footer** sont corrects ;
- cliquer sur le **switch langue** depuis chaque page ;
- vérifier que la **destination** est correcte ;
- tester en **mobile**.

### Automatiquement

- utiliser le script `scripts/scan-locale-files.sh` pour vérifier que toutes les clés existent dans toutes les langues ;
- utiliser le script `scripts/scan-translatable-text.sh` pour repérer les chaînes non extraites ;
- crawler le site avec un outil comme Screaming Frog.

---

## 11. Checklist menu / footer multilingue

### Menu
- [ ] mêmes items dans toutes les langues ;
- [ ] mêmes ordre ;
- [ ] libellés traduits ;
- [ ] switch langue présent et fonctionnel ;
- [ ] CTA principal traduit ;
- [ ] mobile identique ;
- [ ] pas de mix linguistique ;
- [ ] composant unique partagé.

### Footer
- [ ] sections traduites ;
- [ ] mentions légales par langue ;
- [ ] copyright avec année dynamique et marque traduite ;
- [ ] liens sociaux non traduits ;
- [ ] liens internes pointant vers la bonne version ;
- [ ] newsletter traduite (label, bouton, succès, erreur) ;
- [ ] mobile lisible ;
- [ ] composant unique partagé.

---

Created by João de Almeida
