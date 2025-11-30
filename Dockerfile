# Stage 1: Build the application
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json AND package-lock.json
COPY package*.json ./

# Install dependencies using NPM instead of Yarn
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the project
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built artifacts from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
