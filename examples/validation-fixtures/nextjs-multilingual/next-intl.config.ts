// Created by João de Almeida
// Configuration minimale next-intl pour la fixture
import { getRequestConfig } from 'next-intl/server';

export const locales = ['en', 'fr'] as const;
export const defaultLocale = 'fr' as const;

export default getRequestConfig(async ({ locale }) => ({
  messages: (await import(`./messages/${locale}.json`)).default,
}));
