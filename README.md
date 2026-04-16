# 🚀 My Portfolio

A containerized portfolio application using Docker multi-stage builds for **development, staging, and production** environments.

---

## Tech Stack

- Node.js 20 (Alpine)
- Docker (multi-stage build)
- Next.js (assumed build output: `.next`)
- npm

---

## Docker Setup

This project supports three environments:

- **dev** → Development mode with live reload
- **staging** → Pre-production build
- **prod** → Optimized production build

---

## Build & Run Commands

### Development

```bash
docker build --target dev -t my-portfolio:dev .
docker run -p 3000:3000 my-portfolio:dev
```

### Staging
```bash
docker build --target staging -t my-portfolio:staging .
docker run -p 3000:3000 my-portfolio:staging
```
### Production
```bash
docker build --target prod -t my-portfolio:prod .
docker run -p 3000:3000 my-portfolio:prod
```

## Access App
```bash
http://localhost:3000
```