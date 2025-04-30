FROM node:22.15

WORKDIR /app

# Create the app non-interactively with Vite 6.3 and React template
RUN npx create-vite@6.3 vt-app --template react

WORKDIR /app/vt-app

# Install dependencies
RUN npm install

# Expose the dev server port
EXPOSE 5173

# Start Vite with host binding so it's accessible from outside
CMD ["npm", "run", "dev", "--", "--host"]
