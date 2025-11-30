FROM node:18

# Install System Dependencies (Required for image processing)
RUN apt-get update && apt-get install -y \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy files
COPY . .

# Clean install
RUN rm -rf node_modules
RUN npm install --legacy-peer-deps

# Next.js uses Port 3000
EXPOSE 3000

# Start Next.js binding to all interfaces
CMD ["npx", "next", "dev", "-H", "0.0.0.0"]
