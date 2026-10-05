# ---------- Etapa 1: build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Habilitar pnpm con corepack
RUN corepack enable

# Copiar manifiestos primero (mejor caché)
COPY package.json pnpm-lock.yaml ./

# Instalar TODAS las deps (incluidas dev, para compilar)
RUN pnpm install --frozen-lockfile

# Copiar el resto del código
COPY tsconfig.json ./
COPY src ./src

# Compilar TypeScript → dist/
RUN pnpm build

# ---------- Etapa 2: runtime ----------
FROM node:20-alpine AS runtime

WORKDIR /app
RUN corepack enable

# Solo dependencias de producción
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

# Copiar el JavaScript compilado
COPY --from=builder /app/dist ./dist

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "dist/index.js"]