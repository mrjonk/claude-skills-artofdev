<?php
// Created by João de Almeida
// Page contact — formulaire avec labels, placeholders, erreurs et succès
require_once __DIR__ . '/header.php';

$errors = [];
$success = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $message = trim($_POST['message'] ?? '');

    if ($name === '') {
        $errors['name'] = 'Ce champ est requis.';
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Format d\'e-mail invalide.';
    }
    if (strlen($message) < 10) {
        $errors['message'] = 'Le message doit contenir au moins 10 caractères.';
    }

    if (empty($errors)) {
        $success = true;
    }
}
?>

<main class="contact-page">
  <h1>Nous contacter</h1>
  <p>Une question, un projet ? Écrivez-nous, on répond sous 48 heures.</p>

  <?php if ($success): ?>
    <div class="alert-success" role="status">
      Votre message a bien été envoyé. Nous revenons vers vous rapidement.
    </div>
  <?php endif; ?>

  <form method="POST" action="/contact.php" class="contact-form">
    <label for="name">Nom complet</label>
    <input type="text" id="name" name="name" placeholder="Jeanne Dupont" required>
    <?php if (isset($errors['name'])): ?>
      <span class="field-error"><?= $errors['name'] ?></span>
    <?php endif; ?>

    <label for="email">Adresse e-mail</label>
    <input type="email" id="email" name="email" placeholder="vous@email.com" required>
    <?php if (isset($errors['email'])): ?>
      <span class="field-error"><?= $errors['email'] ?></span>
    <?php endif; ?>

    <label for="message">Votre message</label>
    <textarea id="message" name="message" rows="6" placeholder="Décrivez votre projet en quelques lignes..."></textarea>
    <?php if (isset($errors['message'])): ?>
      <span class="field-error"><?= $errors['message'] ?></span>
    <?php endif; ?>

    <button type="submit" class="btn-primary">Envoyer le message</button>
  </form>
</main>

<?php require_once __DIR__ . '/footer.php'; ?>
