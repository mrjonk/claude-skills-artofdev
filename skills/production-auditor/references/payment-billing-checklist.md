# Checklist paiement / facturation — `production-auditor`

Created by João de Almeida — Art of Dev — https://artofdev.space

À dérouler en phase 7 si le projet vend quelque chose (SaaS, boutique, donations, abonnements). Sinon, axe ignoré et **les 10 pts redistribués** vers Technique (+5) et Sécurité (+5) selon `SKILL.md §8`.

---

## 1. Plans / Pricing

- [ ] page de pricing claire ;
- [ ] **prix cohérents** entre la page publique, le checkout et la facture ;
- [ ] devise affichée (EUR, USD, CHF, etc.) ;
- [ ] TVA / taxes mentionnées (HT vs TTC selon contexte) ;
- [ ] mention des conditions (engagement, durée, remboursement) ;
- [ ] CTA sur chaque plan menant au checkout du bon plan.

---

## 2. Checkout

- [ ] flux de checkout fonctionnel de bout en bout ;
- [ ] champ par champ validé (email valide, code postal, etc.) ;
- [ ] support **3D Secure / SCA** (obligatoire UE depuis 2021) ;
- [ ] gestion des cartes refusées (message clair) ;
- [ ] retour utilisateur : succès et échec **différents** et **explicites** ;
- [ ] possibilité d'annuler avant le paiement final ;
- [ ] récapitulatif visible avant validation finale.

---

## 3. Stripe (si utilisé)

- [ ] intégration Stripe Checkout ou Stripe Elements + Payment Element ;
- [ ] mode **test** en dev / staging (`sk_test_...`) ;
- [ ] mode **live** en prod (`sk_live_...`) — **jamais** dans le repo ;
- [ ] webhook configuré ;
- [ ] webhook **secret** vérifié à chaque réception (signature HMAC) ;
- [ ] webhook idempotent (un même `event.id` ne crée pas deux factures) ;
- [ ] events traités au minimum : `checkout.session.completed`, `invoice.paid`, `invoice.payment_failed`, `customer.subscription.updated`, `customer.subscription.deleted`.

---

## 4. PayPal / autres (si utilisé)

- [ ] webhook configuré et vérifié ;
- [ ] mode sandbox en dev ;
- [ ] gestion des disputes / chargebacks documentée (au moins coté process).

---

## 5. Webhooks (général)

- [ ] endpoint accessible publiquement mais protégé par signature ;
- [ ] retry géré côté serveur (si Stripe retry, ne pas dupliquer la facture) ;
- [ ] log des webhooks reçus (avec date, type d'event, statut traité/erreur) ;
- [ ] alerte admin si webhook échoue de manière répétée.

---

## 6. Factures

- [ ] facture générée pour chaque paiement réussi ;
- [ ] format **PDF** (ou page HTML imprimable) ;
- [ ] mentions légales obligatoires : nom / adresse vendeur, numéro entreprise / SIRET, TVA si applicable, date, numéro unique séquentiel, détail des prestations, total HT/TVA/TTC ;
- [ ] facture accessible par le client dans son espace ;
- [ ] facture archivée côté admin (au moins 10 ans pour la France).

---

## 7. Emails transactionnels

- [ ] email **paiement réussi** envoyé immédiatement ;
- [ ] email **paiement échoué** avec lien pour ré-essayer ;
- [ ] email **renouvellement** avant échéance ;
- [ ] email **annulation** confirmant la fin de l'abonnement ;
- [ ] expéditeur configuré (`From`, `Reply-To`) ;
- [ ] templates non vides (pas de `{{customer_name}}` non remplacé) ;
- [ ] liens dans les emails : URLs absolues correctes, pas `localhost`.

---

## 8. Statut paiement (côté client)

- [ ] page `/account/billing` ou équivalent ;
- [ ] historique des paiements ;
- [ ] téléchargement des factures ;
- [ ] modification du moyen de paiement ;
- [ ] visibilité de l'abonnement courant (plan, date de renouvellement, statut).

---

## 9. Annulation

- [ ] possibilité d'**annuler** l'abonnement depuis l'espace client ;
- [ ] annulation : effet **fin de période** (pas immédiat sauf demande) ;
- [ ] confirmation d'annulation par email ;
- [ ] possibilité de réactiver avant la fin de période ;
- [ ] flux d'annulation pas trop frictionnel mais clair sur ce qui se passe.

---

## 10. Renouvellement

- [ ] renouvellement automatique fonctionnel si abonnement ;
- [ ] notification au client **avant** prélèvement (recommandé : 7 jours avant) ;
- [ ] gestion des cartes expirées (pré-notification, retry) ;
- [ ] dunning : retry programmé en cas d'échec (Stripe Smart Retries ou logique maison).

---

## 11. Erreurs de paiement

- [ ] message clair côté client si paiement refusé (sans dévoiler la raison technique) ;
- [ ] log côté admin avec raison réelle (insufficient_funds, expired_card, etc.) ;
- [ ] possibilité de relancer manuellement le paiement ;
- [ ] gestion gracieuse : ne pas bloquer immédiatement l'accès, laisser une période de grâce raisonnable.

---

## 12. Admin billing

- [ ] vue admin des paiements en cours / échoués ;
- [ ] vue admin des abonnements actifs ;
- [ ] possibilité d'**émettre un remboursement** depuis l'admin (avec confirmation) ;
- [ ] possibilité de **suspendre / réactiver** un abonnement ;
- [ ] export comptable (CSV des paiements / factures) ;
- [ ] cohérence : si l'admin annule, le client reçoit l'email approprié.

---

## 13. Cohérence pricing

- [ ] **mêmes prix** entre :
  - la page de pricing publique ;
  - le checkout ;
  - la confirmation de paiement ;
  - la facture ;
  - l'admin billing.
- [ ] aucune devise mélangée (pas un prix en EUR puis une facture en CHF).

---

## 14. Sécurité PCI / paiement

- [ ] **aucune** donnée carte stockée côté serveur (utiliser Stripe / processeur) ;
- [ ] CSP autorisant uniquement les domaines de paiement nécessaires ;
- [ ] HTTPS obligatoire sur les pages de checkout (HSTS recommandé) ;
- [ ] pas de log de numéro de carte (PCI-DSS) ;
- [ ] tokenisation côté client (Stripe.js, Elements).

---

## Sortie attendue

Pour chaque item failed :

- **zone** : `pricing`, `checkout`, `webhook`, `email`, `admin-billing`, etc. ;
- **gravité** : un webhook non vérifié = `critique`, un email transactionnel manquant = `important`, un libellé approximatif = `mineur` ;
- **impact** : 1 phrase ;
- **correction recommandée** : 1 phrase actionnable.

---

Created by João de Almeida — Art of Dev — https://artofdev.space
