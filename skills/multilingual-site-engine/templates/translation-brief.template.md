# Brief de traduction — {{PROJECT_NAME}}

> Cadrage de la traduction / localisation avant tout travail.
> Created by João de Almeida

---

## Métadonnées

- **Date** : {{YYYY-MM-DD}}
- **Stack** : {{framework / CMS}}
- **Système i18n** : {{i18next / next-intl / gettext / WPML / autre}}

---

## 1. Langues

- **Langue source** : {{ex: fr-FR}}
- **Langues cibles** : {{ex: en-US, de-DE}}
- **Langue par défaut** : {{ex: fr-FR}}
- **Variantes régionales** : {{si pertinent}}
- **Fallback** : {{stratégie}}

---

## 2. Public et ton

- **Public cible par langue** :
  - {{lang}} : {{description}}
- **Ton** :
  - {{lang}} : {{formel / informel / technique / chaleureux / ...}}
- **Tutoiement / vouvoiement** :
  - {{lang}} : {{choix}}

---

## 3. Glossaire (terminologie)

| Terme source | {{lang_target_1}} | {{lang_target_2}} |
|---|---|---|
| {{ex: cart}} | {{panier}} | {{Warenkorb}} |
| {{ex: dashboard}} | {{tableau de bord}} | {{Dashboard}} |
| {{ex: login}} | {{connexion}} | {{Anmeldung}} |
| {{...}} | {{...}} | {{...}} |

---

## 4. Termes à NE PAS traduire

- {{ex: nom de marque}}
- {{ex: nom de fonctionnalité phare}}
- {{ex: commandes / codes / classes CSS}}
- {{ex: slogans signature}}

---

## 5. Stratégie de routes

- **Stratégie choisie** : {{sous-dossier / sous-domaine / domaine séparé / paramètre / slug traduit}}
- **Mapping de slugs** (si applicable) :

```json
{
  "{{key}}": {
    "{{lang_source}}": "{{slug-source}}",
    "{{lang_target_1}}": "{{slug-target-1}}"
  }
}
```

---

## 6. Stratégie SEO

- [ ] balises `hreflang` à générer ;
- [ ] `x-default` ciblera : {{langue}}
- [ ] sitemap multilingue à produire ;
- [ ] balises OG par locale ;
- [ ] canonical par version.

---

## 7. Formats locaux

- **Dates** : {{format par locale}}
- **Heures** : {{format par locale}}
- **Monnaie** : {{EUR / USD / autre, par locale}}
- **Téléphone** : {{format international ou local}}

---

## 8. RTL

- **Langues RTL incluses** : {{oui / non, lesquelles}}
- **CSS logique en place** : {{oui / non}}
- **Police compatible** : {{nom de police}}

---

## 9. Style IA détecté dans le source

- **Tirets longs abusifs** : {{oui / non, où}}
- **Phrases creuses** : {{liste}}
- **Conclusion vide** : {{oui / non}}
- **Action** : {{humaniser avant traduction / traduire tel quel / ...}}

---

## 10. Volume estimé

| Type | Nombre |
|---|---|
| Pages statiques | {{N}} |
| Articles / posts | {{N}} |
| Produits / fiches | {{N}} |
| Clés i18n | {{N}} |
| Emails transactionnels | {{N}} |
| Templates erreur | {{N}} |

---

## 11. Hors scope

- {{ex: contenus archivés à ne pas retraduire}}
- {{ex: emails marketing}}
- {{ex: sections beta non publiées}}

---

## 12. Validations

- [ ] brief relu par {{nom}}
- [ ] glossaire validé
- [ ] stratégie routes validée
- [ ] modes d'exécution choisi (1 / 2 / 3 / 4)

---

Created by João de Almeida
