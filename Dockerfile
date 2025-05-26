# Use official Node.js LTS image (version 18 as of 2023)
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies first for better layer caching
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Create a non-root user and switch to it for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose the port the app runs on
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1

# Define the command to run the application
CMD ["npm", "start"]
