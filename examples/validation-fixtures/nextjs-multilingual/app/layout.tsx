// Created by João de Almeida
// Layout global Next.js App Router — header / nav / footer
import { NextIntlClientProvider } from 'next-intl';
import { getMessages } from 'next-intl/server';
import { useTranslations } from 'next-intl';

export default async function RootLayout({
  children,
  params: { locale },
}: {
  children: React.ReactNode;
  params: { locale: string };
}) {
  const messages = await getMessages();

  return (
    <html lang={locale}>
      <body>
        <NextIntlClientProvider messages={messages}>
          <SiteHeader />
          {children}
          <SiteFooter />
        </NextIntlClientProvider>
      </body>
    </html>
  );
}

function SiteHeader() {
  const t = useTranslations('nav');
  return (
    <header className="site-header">
      <a href="/" className="brand">ArtOfDev</a>
      <nav aria-label={t('aria_label')}>
        <ul>
          <li><a href="/">{t('home')}</a></li>
          <li><a href="/about">{t('about')}</a></li>
          <li><a href="/services">{t('services')}</a></li>
          <li><a href="/contact">{t('contact')}</a></li>
        </ul>
      </nav>
    </header>
  );
}

function SiteFooter() {
  const t = useTranslations('footer');
  return (
    <footer className="site-footer">
      <p>{t('copyright', { year: new Date().getFullYear() })}</p>
    </footer>
  );
}
