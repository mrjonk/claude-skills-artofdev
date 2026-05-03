// Created by João de Almeida
// Page contact Next.js — formulaire React avec messages d'erreur
'use client';

import { useState } from 'react';
import { useTranslations } from 'next-intl';

export default function ContactPage() {
  const t = useTranslations('contact');
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [success, setSuccess] = useState(false);

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const newErrors: Record<string, string> = {};

    if (!formData.get('name')) newErrors.name = t('errors.name_required');
    if (!formData.get('email')) newErrors.email = t('errors.email_required');

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }
    setErrors({});
    setSuccess(true);
  }

  return (
    <main className="contact-page">
      <h1>{t('title')}</h1>
      <p>{t('intro')}</p>

      {success && <div className="alert-success">{t('success')}</div>}

      <form onSubmit={handleSubmit} className="contact-form">
        <label htmlFor="name">{t('fields.name.label')}</label>
        <input id="name" name="name" type="text" placeholder={t('fields.name.placeholder')} />
        {errors.name && <span className="field-error">{errors.name}</span>}

        <label htmlFor="email">{t('fields.email.label')}</label>
        <input id="email" name="email" type="email" placeholder={t('fields.email.placeholder')} />
        {errors.email && <span className="field-error">{errors.email}</span>}

        <button type="submit" className="btn-primary">{t('submit')}</button>
      </form>
    </main>
  );
}
