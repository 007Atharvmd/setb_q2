# ---- Stage 1: The Builder Stage ----
# Use a full Node.js image to install all dependencies, including devDependencies
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files and install all dependencies
# This is done first to leverage Docker's layer caching
COPY package*.json ./
RUN npm install

# Copy the rest of the application source code
COPY . .

# --- Stage 2: The Production Stage ---
# Use a slim, lightweight base image for the final product
FROM node:18-alpine

WORKDIR /app

# Arguments passed from the Jenkins 'docker build' command
ARG BUILD_ID
ARG GIT_COMMIT

# Set them as environment variables available inside the container
ENV BUILD_ID=${BUILD_ID}
ENV GIT_COMMIT=${GIT_COMMIT}

# Copy only the production dependencies from the 'builder' stage
# This avoids copying devDependencies into the final image
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Copy the application code from the 'builder' stage
COPY --from=builder /app/server.js ./server.js

# Expose the port the app runs on
EXPOSE 8080

# The command to run when the container starts
CMD ["node", "server.js"]