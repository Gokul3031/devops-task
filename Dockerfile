# Node.js as base image
FROM node:18

# Setting working directory
WORKDIR /app

# Copy package.json and package-lock.json from src
COPY src/package*.json ./

# Install dependencies
RUN npm install

# Copy all app files into container
COPY src/ ./

# Expose app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
