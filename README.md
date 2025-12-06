# Impostorul - Joc Social

Un joc social de deducție pentru 5 jucători inspirat din Among Us și Werewolf.

## Descriere

Într-o rundă, 4 jucători primesc același cuvânt secret, iar 1 jucător (impostorul) primește cuvântul "IMPOSTOR". Scopul celorlalți jucători este să descopere cine este impostorul prin discuții, în timp ce impostorul trebuie să se integreze fără să știe cuvântul secret.

## Dezvoltare Locală

### Instalare Dependențe

```bash
npm install
```

### Pornire Server de Dezvoltare

```bash
npm run dev
```

Aplicația va rula pe `http://localhost:5173`

### Build pentru Producție

```bash
npm run build
```

## Deployment pe Vercel

### Metoda 1: Deploy prin Vercel CLI

1. Instalează Vercel CLI:
```bash
npm install -g vercel
```

2. Deploy aplicația:
```bash
vercel
```

### Metoda 2: Deploy prin GitHub

1. Push codul pe GitHub:
```bash
git add .
git commit -m "Ready for deployment"
git push origin main
```

2. Mergi pe [vercel.com](https://vercel.com)
3. Click pe "Import Project"
4. Selectează repository-ul tău
5. Vercel va detecta automat că este un proiect Vite
6. Click pe "Deploy"

### Metoda 3: Deploy Direct din Local

```bash
vercel --prod
```

## Tehnologii Utilizate

- React 18
- Vite
- Tailwind CSS
- Lucide React (icons)

## Cum se Joacă

1. Adună 5 jucători
2. Pasează telefonul de la un jucător la altul
3. Fiecare jucător apasă pentru a-și vedea rolul în secret
4. După ce toți au văzut rolurile, discutați și votați cine este impostorul
5. Dacă impostorul este prins, sătenii câștigă. Altfel, câștigă impostorul!
