# Base image
FROM node:20-alpine AS base
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci

# ----------------------
# Development
# ----------------------
FROM base AS dev
ENV NODE_ENV=development
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]

# ----------------------
# Build (used by staging & prod)
# ----------------------
FROM base AS builder
ENV NODE_ENV=production
COPY . .
RUN npm run build

# ----------------------
# Staging
# ----------------------
FROM node:20-alpine AS staging
WORKDIR /app
ENV NODE_ENV=staging

COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "run", "start"]

# ----------------------
# Production
# ----------------------
FROM node:20-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production

# Copy only necessary files for smaller image
COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["npm", "run", "start"]