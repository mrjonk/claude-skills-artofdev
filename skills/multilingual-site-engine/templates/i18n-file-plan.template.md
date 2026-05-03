# Plan des fichiers i18n — {{PROJECT_NAME}}

> Inventaire des fichiers de traduction à créer / modifier.
> Created by João de Almeida

---

## 1. Bibliothèque cible

- **Nom** : {{i18next / next-intl / vue-i18n / gettext / Laravel / Rails / Symfony / WPML / Polylang / autre}}
- **Version** : {{...}}
- **Format** : {{JSON / PO/MO / PHP arrays / YAML / autre}}

---

## 2. Structure de dossier

```
{{ex: locales/}}
├── fr/
│   ├── common.json
│   ├── home.json
│   ├── auth.json
│   ├── account.json
│   ├── pricing.json
│   ├── legal.json
│   └── emails.json
└── en/
    └── (mêmes fichiers)
```

---

## 3. Namespaces / fichiers

| Namespace | Description | Volume estimé |
|---|---|---|
| `common` | menus, footers, boutons, erreurs, labels génériques | {{N clés}} |
| `home` | textes spécifiques de la page d'accueil | {{N clés}} |
| `auth` | login, register, reset, MFA | {{N clés}} |
| `account` | profil, settings, billing | {{N clés}} |
| `pricing` | page tarifs | {{N clés}} |
| `legal` | mentions, CGV, RGPD, cookies | {{N clés}} |
| `emails` | sujets et corps des emails transactionnels | {{N clés}} |
| `errors` | 404, 500, maintenance | {{N clés}} |
| `forms` | labels, placeholders, erreurs validation | {{N clés}} |

---

## 4. Convention de nommage des clés

- **kebab-case** ou **snake_case** : {{choix}}
- **profondeur max** : 3 niveaux (`section.sub.key`)
- **préfixe** par namespace
- **pas de variations** par langue dans la clé (`hello_fr` interdit)
- **clés stables** (pas de renommage sauvage qui casse l'historique)

---

## 5. Variables et placeholders

- **format** : {{`{name}` / `{{count}}` / `%s` / `:user` / autre}}
- **gestion pluriels** : {{ICU MessageFormat / i18next plurals / autre}}

---

## 6. Lazy loading

- [ ] activé ;
- [ ] par namespace ;
- [ ] par locale ;
- [ ] préchargement de `common` au boot.

---

## 7. Détection / persistance

- détection : {{URL / cookie / storage / sélecteur}}
- persistance : {{cookie / storage / aucune}}
- nom du cookie : {{`NEXT_LOCALE` / `i18next` / autre}}

---

## 8. Fichiers extérieurs au système i18n

Liste des contenus **non** dans le système i18n principal :

- emails transactionnels : `{{path}}` ;
- pages légales : `{{path}}` ;
- contenu blog : {{CMS}} ;
- contenu produit : {{CMS / DB}} ;
- erreurs API : {{...}} ;
- messages système : {{...}}.

---

## 9. Audit du source

| Mesure | Source | Valeur |
|---|---|---|
| Chaînes hardcodées détectées | scan | {{N}} |
| Fichiers concernés | scan | {{N}} |
| Clés totales (toutes langues) | inventaire | {{N}} |
| Clés en double | scan | {{N}} |
| Clés manquantes par langue | diff | {{N}} |
| Clés orphelines | diff | {{N}} |

---

## 10. Plan de travail

### Phase 1 — Extraction
- [ ] passer toutes les chaînes hardcodées par `t()` ;
- [ ] créer le fichier source (`fr/common.json`).

### Phase 2 — Traduction
- [ ] traduire {{lang_target_1}} ;
- [ ] traduire {{lang_target_2}}.

### Phase 3 — Vérification
- [ ] diff entre langues ;
- [ ] aucune clé manquante ;
- [ ] aucune clé orpheline ;
- [ ] tous les pluriels gérés.

---

## 11. Risques

- {{ex: certaines chaînes contiennent du HTML, traiter avec Trans component}}
- {{ex: certaines clés ont des variables `%s` legacy à migrer en `{name}`}}
- {{ex: la légende sur la page tarifs est dans un composant non passé par i18n}}

---

Created by João de Almeida
