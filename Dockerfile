# Stage 1: Build
FROM node:18-slim AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --legacy-peer-deps
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:18-slim
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY package*.json ./
RUN npm ci --production --legacy-peer-deps
ENV NODE_ENV=production
CMD ["node", "dist/index.js"]
