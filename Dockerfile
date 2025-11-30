FROM node:18

# Install System Dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# Force install again
RUN rm -rf node_modules
RUN npm install --legacy-peer-deps

EXPOSE 5173

# --- THE CHANGE IS HERE ---
# Instead of starting the app, we just keep the container alive
CMD ["tail", "-f", "/dev/null"]
