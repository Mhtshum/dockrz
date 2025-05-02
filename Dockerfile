# Dockerfile
FROM node:23-alpine3.20

WORKDIR /app

# Install additional tools if needed
RUN apk add --no-cache inotify-tools rsync bash

# Create app directory structure
RUN mkdir -p /app/temp-src

# Create the Vite app in the final location
#RUN npm create vite@6.3.1 vt-app --template react
RUN npx create-vite@6.3.1 vt-app --template react

WORKDIR /app/vt-app

# Install dependencies
#RUN npm install


# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]


# Default command (can be overridden)
CMD ["npm", "run", "dev", "--", "--host"]