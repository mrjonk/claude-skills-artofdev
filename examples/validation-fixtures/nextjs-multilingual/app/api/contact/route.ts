// Created by João de Almeida
// API route — code technique, NE DOIT PAS être traduit par le skill
import { NextRequest, NextResponse } from 'next/server';

interface ContactPayload {
  name: string;
  email: string;
  message: string;
}

export async function POST(request: NextRequest) {
  const body = (await request.json()) as ContactPayload;

  if (!body.name || !body.email) {
    return NextResponse.json(
      { error: 'INVALID_PAYLOAD', field: !body.name ? 'name' : 'email' },
      { status: 400 }
    );
  }

  // Pseudo-envoi : aucune logique réelle, fixture uniquement.
  return NextResponse.json({ ok: true });
}
