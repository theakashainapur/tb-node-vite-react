FROM node:20-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --if-present
RUN mkdir -p /out && (cp -r dist/. /out/ || cp -r build/. /out/)

FROM nginx:alpine
COPY --from=builder /out /usr/share/nginx/html
EXPOSE 80