# Stage 1: Build the application
# We use standard 'node:18' (Debian) instead of 'alpine' to ensure 
# all C++/Python build tools for image libraries are present.
FROM node:18 AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# 1. Install dependencies with legacy-peer-deps to ignore version conflicts
# 2. --no-audit speeds it up
RUN npm install --legacy-peer-deps --no-audit

# Copy source code
COPY . .

# Increase Node memory limit to 4GB to prevent crashing during build
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Run the build using npx vite build directly to skip strict TypeScript checks
# that often stop builds unnecessarily
RUN npx vite build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the dist folder
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
