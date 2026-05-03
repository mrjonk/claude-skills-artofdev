// Created by João de Almeida
// Homepage Next.js — App Router avec next-intl + interpolation {count}
import { useTranslations } from 'next-intl';

export default function HomePage() {
  const t = useTranslations('home');
  const count = 42;

  return (
    <main className="home">
      <section className="hero">
        <h1>{t('hero.title')}</h1>
        <p className="lead">{t('hero.subtitle')}</p>
        <a href="/contact" className="btn-primary">
          {t('hero.cta')}
        </a>
      </section>

      <section className="cards">
        <article className="card">
          <h2>{t('cards.design.title')}</h2>
          <p>{t('cards.design.body')}</p>
        </article>
        <article className="card">
          <h2>{t('cards.dev.title')}</h2>
          <p>{t('cards.dev.body')}</p>
        </article>
        <article className="card">
          <h2>{t('cards.seo.title')}</h2>
          <p>{t('cards.seo.body')}</p>
        </article>
      </section>

      <p className="counter">
        {t('projects_count', { count })}
      </p>
    </main>
  );
}
