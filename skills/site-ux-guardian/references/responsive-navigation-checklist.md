# Checklist responsive navigation — `site-ux-guardian`

Vérifications spécifiques au **responsive** : navigation, layout, tables, formulaires.

Created by João de Almeida

---

## 1. Breakpoints à tester

| Nom | Largeur | Cible |
|---|---|---|
| **xs** | 320 px | mobile S (iPhone SE, Galaxy A petit) |
| **sm** | 375–414 px | mobile M (iPhone, Pixel) |
| **md** | 768 px | tablet portrait |
| **lg** | 1024 px | laptop |
| **xl** | 1280–1440 px | desktop |
| **2xl** | 1536+ px | grand écran |

**Tester au minimum** : 320 / 768 / 1024 / 1440.

---

## 2. Menu mobile (burger / drawer)

### À vérifier

- [ ] **bouton burger** visible sur mobile (typiquement < 768 px) ;
- [ ] **clic** sur burger → menu s'ouvre ;
- [ ] **clic** sur overlay → menu se ferme ;
- [ ] **touche Escape** ferme le menu ;
- [ ] **focus trap** : Tab ne sort pas du menu une fois ouvert ;
- [ ] **scroll body** désactivé pendant menu ouvert ;
- [ ] menu **identique** au menu desktop ;
- [ ] CTA primaire **visible** (en haut ou bas) ;
- [ ] menu **scrollable** si trop long ;
- [ ] animation **rapide** (200–300 ms) ;
- [ ] hamburger se transforme en X (UX claire).

### Anti-patterns

- burger qui n'ouvre rien ;
- menu mobile avec **moins de liens** que desktop ;
- menu qui prend 100 vh sans bouton fermer ;
- pas de focus trap (clavier perdu) ;
- scroll body actif → confusion utilisateur.

---

## 3. Sidebar admin sur mobile

### À vérifier

- [ ] **collapsible** : transformée en drawer sur mobile ;
- [ ] **ouverture** via bouton dédié dans la topbar mobile ;
- [ ] **fermeture** par overlay / Escape / re-clic ;
- [ ] navigation **intacte** une fois ouverte ;
- [ ] **active state** maintenu.

---

## 4. Footer responsive

### À vérifier

- [ ] **mobile** (< 640 px) : colonnes empilées en 1 ou 2 colonnes ;
- [ ] **tablet** (640–1023 px) : 2–3 colonnes ;
- [ ] **desktop** (≥ 1024 px) : 3–4 colonnes ;
- [ ] liens **tappable** (zone ≥ 44 × 44 px sur mobile) ;
- [ ] liens **légaux** toujours visibles ;
- [ ] copyright **lisible** (taille minimum 12 px) ;
- [ ] réseaux sociaux **alignés**.

### Anti-patterns

- 4 colonnes maintenues en mobile (texte écrasé) ;
- footer qui prend 80 % de la hauteur mobile sans hiérarchie ;
- liens trop petits / trop rapprochés.

---

## 5. Tables et dashboards admin

### Sur mobile

Deux options acceptables :

#### A. Scroll horizontal (avec indicateurs)

- table reste en table ;
- `overflow-x: auto` ;
- gradient sur les bords pour indiquer le scroll.

#### B. Conversion en cards

- chaque ligne devient une card ;
- labels visibles avec chaque valeur ;
- actions empilées en bas.

### Anti-patterns

- table qui déborde sans indication ;
- table avec colonnes **toutes** masquées en mobile ;
- table illisible (scroll sans gradient + colonnes étroites + textes coupés).

---

## 6. CTA / boutons mobile

### À vérifier

- [ ] zone **tappable** ≥ 44 × 44 px (Apple HIG) / 48 × 48 px (Material) ;
- [ ] espacement entre CTA ≥ 8 px ;
- [ ] CTA principal **visible** dès l'ouverture ;
- [ ] CTA sticky bottom si pertinent (e-commerce, booking) ;
- [ ] **pas de hover-only critical** (mobile = pas de hover).

### Anti-patterns

- 3 boutons côte à côte qui se touchent ;
- bouton 24 × 24 px (impossible à toucher) ;
- CTA principal sous la ligne de flottaison.

---

## 7. Overflow horizontal

### Cas typiques

- image qui dépasse la viewport ;
- table sans `overflow-x: auto` ;
- titre H1 trop grand (`text-7xl` sur mobile) ;
- container sans `max-width` qui dépasse.

### Détection

```bash
# Pratiquement : tester en DevTools en mobile et regarder le scrollbar horizontal
```

### Anti-patterns

- viewport qui scrolle horizontalement (fail UX critique).

---

## 8. Hero sur mobile

### À vérifier

- [ ] texte **lisible** sans zoom ;
- [ ] CTA **visible** au scroll initial ;
- [ ] image **cadrée** (pas un crop arbitraire qui coupe le sujet) ;
- [ ] **pas** un hero 100 vh qui pousse tout en dessous ;
- [ ] animation **désactivée** ou réduite si lourde.

### Anti-patterns

- hero plein écran qui force à scroller pour voir quoi que ce soit ;
- titre H1 qui sort de l'écran ;
- image hero pixelisée (pas adaptée au DPR mobile).

---

## 9. Formulaires sur mobile

### À vérifier

- [ ] champs **en colonne unique** ;
- [ ] **labels au-dessus** des champs (pas à côté) ;
- [ ] **type=email**, **type=tel**, **type=number** pour invoquer le bon clavier ;
- [ ] **autocomplete** activé (`name`, `email`, `tel`, etc.) ;
- [ ] zone **tappable** des champs ≥ 44 px de hauteur ;
- [ ] focus du **premier champ pas automatique** sur mobile (évite le scroll forcé).

---

## 10. Images responsive

### À vérifier

- [ ] **`max-width: 100%`** ;
- [ ] **`height: auto`** pour conserver le ratio ;
- [ ] **`<picture>`** avec srcset pour servir la bonne résolution ;
- [ ] **lazy-load** sous la ligne de flottaison ;
- [ ] **`width`** + **`height`** explicites pour éviter CLS.

---

## 11. Switch langue mobile

### À vérifier

- [ ] visible et **accessible** sur mobile (souvent dans le drawer menu) ;
- [ ] indication de la langue **active** ;
- [ ] menu de langues lisible (pas 5 drapeaux entassés).

---

## 12. Espacement mobile

### À vérifier

- [ ] padding latéral **suffisant** (16–24 px sur mobile) ;
- [ ] espacement entre sections adapté (48–64 px sur mobile) ;
- [ ] cards avec padding interne **adapté** (16 px minimum) ;
- [ ] line-height confortable (1.4–1.6) ;
- [ ] **pas** d'espaces énormes (32 vh entre sections sur mobile = perte d'attention).

---

## 13. Outils de test

| Outil | Usage |
|---|---|
| **Chrome DevTools** | Toggle device toolbar (Ctrl+Shift+M) |
| **Firefox** | Responsive Design Mode (Ctrl+Shift+M) |
| **Safari** | Develop > Enter Responsive Design Mode |
| **BrowserStack / LambdaTest** | tests sur vrais devices |
| **Lighthouse** | audit responsive |
| **resize manuel** | test final |

---

## 14. Checklist responsive

### Navigation

- [ ] menu mobile (burger / drawer) fonctionnel ;
- [ ] menu desktop fonctionnel ;
- [ ] **mêmes liens** mobile / desktop ;
- [ ] sidebar admin collapsible ;
- [ ] switch langue accessible.

### Layout

- [ ] **aucun overflow horizontal** ;
- [ ] container max-width respecté ;
- [ ] padding latéral suffisant.

### Composants

- [ ] cards lisibles ;
- [ ] tables : scroll ou conversion en cards ;
- [ ] formulaires en colonne unique ;
- [ ] images responsives.

### Interactions

- [ ] zones tappable ≥ 44 × 44 px ;
- [ ] espacement entre éléments cliquables ≥ 8 px ;
- [ ] pas de hover-only critique.

### Performance

- [ ] pas de CLS visible ;
- [ ] images lazy-loadées sous la ligne de flottaison ;
- [ ] LCP < 2.5 s sur mobile.

---

Created by João de Almeida
