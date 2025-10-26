# frontend/Dockerfile
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
# optional: custom nginx config for SPA routing
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
