# Stage 1: Build the Vite application
FROM node:20-alpine

WORKDIR /app

# Copy package files to leverage Docker cache
COPY package*.json ./

RUN npm install

# Copy source code and build the app
COPY . .

EXPOSE 5173

CMD [ "npm", "run", "dev" ]