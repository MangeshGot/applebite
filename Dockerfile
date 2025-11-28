FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies (devDependencies are needed for the build)
COPY package*.json ./
RUN npm install

# Copy source and build
COPY . .
RUN npm run build

FROM nginx:alpine AS runner

# Copy built assets from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Use a custom nginx config to enable SPA fallback
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]