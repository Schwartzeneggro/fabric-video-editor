# 1. Use Node.js
FROM node:18

# 2. Create a folder for the app
WORKDIR /app

# 3. COPY all files from GitHub into that folder
# (This fixes your "no such file" error)
COPY . .

# 4. Install the dependencies
RUN npm install --legacy-peer-deps

# 5. Open the port
EXPOSE 5173

# 6. Run the app in Dev mode (so it doesn't crash on build errors)
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
