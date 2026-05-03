<?php
// Created by João de Almeida
// Fixture PHP statique — homepage monolingue (FR)
require_once __DIR__ . '/header.php';
?>

<main>
  <section class="hero">
    <h1>Bienvenue chez ArtOfDev</h1>
    <p class="lead">
      Nous concevons des sites premium pour des marques exigeantes.
      Direction artistique, développement, SEO multilingue : tout sous le même toit.
    </p>
    <a href="/contact.php" class="btn-primary">Prendre contact</a>
  </section>

  <section class="features">
    <div class="card">
      <h2>Sites sur-mesure</h2>
      <p>Pas de template revendu trois fois. Chaque projet part d'une page blanche.</p>
    </div>
    <div class="card">
      <h2>SEO sérieux</h2>
      <p>Audit technique, contenu travaillé, suivi mesuré. Pas de promesses creuses.</p>
    </div>
    <div class="card">
      <h2>Multilingue propre</h2>
      <p>Traduction humaine, hreflang, slugs cohérents. Pas de Google Translate.</p>
    </div>
  </section>
</main>

<?php require_once __DIR__ . '/footer.php'; ?>
