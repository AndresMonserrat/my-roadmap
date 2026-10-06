# ---------- Etapa 1: build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# 1. Actualizar Corepack a su última versión para evitar errores de verificación
RUN npm i -g corepack@latest

# 2. Habilitar y preparar la versión de pnpm que necesita tu proyecto
RUN corepack enable && corepack prepare pnpm@12.8.1 --activate

# Copiar manifiestos primero (mejor caché)
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Instalar TODAS las deps (incluidas dev, para compilar)
RUN pnpm install --frozen-lockfile 

# Copiar el resto del código
COPY src ./src
COPY tsconfig.json ./

# Compilar TypeScript → dist/
RUN pnpm build

# ---------- Etapa 2: runtime ----------
FROM node:20-alpine AS runtime

WORKDIR /app
RUN npm i -g corepack@latest 
RUN corepack enable && corepack prepare pnpm@12.8.1 --activate

# Solo dependencias de producción
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

# Copiar el JavaScript compilado
COPY --from=builder /app/dist ./dist

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "dist/index.js"]