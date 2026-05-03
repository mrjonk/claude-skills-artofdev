# Fixture 1 — `php-static-multilingual`

> Created by João de Almeida
> Fixture de validation pour le skill `multilingual-site-engine`.

## Stack simulée

Site PHP statique sans framework, sans build tool. Architecture de fichiers :

```
php-static-multilingual/
├── index.php                  # Homepage avec hero + 3 cards
├── header.php                 # Header global + menu (4 entrées)
├── footer.php                 # Footer + copyright "© 2024"
├── contact.php                # Formulaire avec labels / placeholders / erreurs / succès
├── services.php               # 3 sections, 2 paragraphes au style IA, tirets longs en boucle
├── lang/
│   └── fr.php                 # Amorce i18n minimale
├── email-templates/
│   └── welcome.php            # Email transactionnel avec placeholders {{...}}
└── assets/
    └── style.css              # Commentaire piège "to be translated"
```

## Demande utilisateur simulée

> *"Traduis ce site PHP en anglais. La langue source est le français."*

## Ce que le skill devrait faire

1. **Reconnaître que les langues sont déjà cadrées** (FR → EN explicite) et NE PAS reposer la question.
2. **Détecter la stack** PHP statique + amorce i18n via `lang/fr.php`.
3. **Cartographier les textes** dans `index.php`, `header.php`, `footer.php`, `contact.php`, `services.php`, `email-templates/welcome.php`.
4. **Préserver** :
   - les placeholders `{{user_name}}` et `{{verification_link}}` dans `welcome.php` ;
   - les classes CSS, les `require_once`, le code PHP ;
   - le commentaire `to be translated` dans `style.css` (c'est un commentaire technique, pas un texte UI).
5. **Humaniser** :
   - paragraphe 1 de `services.php` (3 tirets longs + *"dans le monde d'aujourd'hui"*) ;
   - paragraphe 2 de `services.php` (3 tirets longs + *"solution innovante / révolutionnaire / expérience fluide / interface intuitive"*) ;
6. **Signaler le footer copyright "© 2024"** comme statique (à dynamiser ou à mettre à jour).
7. **Proposer une stratégie de routes** (sous-dossier `/fr/` `/en/` ou domaines séparés).
8. **Proposer un plan SEO** (hreflang, balise `<html lang>` à dynamiser, sitemap multilingue).
9. **Produire un fichier `lang/en.php`** miroir de `lang/fr.php` une fois l'extraction faite.

## Ce qu'il NE DOIT PAS faire

- traduire le texte du commentaire CSS *"to be translated"* ;
- modifier `{{user_name}}`, `{{verification_link}}`, ou les noms de fichiers PHP ;
- traduire les noms de classes (`.site-header`, `.btn-primary`) ;
- traduire les attributs `name="..."` des champs de formulaire (clés techniques) ;
- pousser un commit (le skill n'a aucun mandat git ici).

## Points de friction attendus

- **Site sans architecture i18n complète** : le skill doit proposer une refonte (extraction des chaînes vers `lang/`) ou une duplication par dossier (`/fr/` `/en/`). Les deux sont valides — il doit choisir avec justification.
- **Copyright statique 2024** : doit être signalé. Date courante : 2026.
- **Footer email "Pour vous désinscrire, répondez avec stop"** : à traduire en EN avec une formulation idiomatique (*"reply STOP"*).
- **Tirets longs en série** : le skill doit corriger la ponctuation à la passe humanisation, pas seulement traduire.

## Score readiness attendu (estimation manuelle)

- Translation Quality Score : ~75-85 si la passe humanisation est correctement faite.
- Multilingual Site Readiness Score : ~30-50 sur l'état brut (pas de routes, pas de hreflang, pas de switch langue, pas de `<html lang>` dynamique). Le skill doit proposer un plan pour passer à 75+.

## Comment tester ce fixture en runtime (humain)

1. Ouvrir une session Claude Code dans ce dossier.
2. Lancer : *"Traduis ce site PHP en anglais. La langue source est le français."*
3. Vérifier que le skill :
   - n'a pas reposé les questions de cadrage langues (déjà fournies) ;
   - a préservé `{{user_name}}` ;
   - a corrigé les tirets longs dans `services.php` ;
   - a signalé le copyright 2024 ;
   - a produit un plan de routes documenté ;
   - a calculé les deux scores.
