FROM node:18

# 1. Install System Dependencies required for Fabric.js/Canvas
# (This prevents the "Module not found" or "Symbol lookup error" crashes)
RUN apt-get update && apt-get install -y \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. Copy files
COPY . .

# 3. Clean install (Force re-download of everything to be safe)
RUN rm -rf node_modules package-lock.json
RUN npm install --legacy-peer-deps

# 4. Expose Port
EXPOSE 5173

# 5. Start command
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
