# Stage 1: The Builder Stage
# We use a full Node.js image to install dependencies
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies, including devDependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# ---

# Stage 2: The Runner/Production Stage
# We use a slim Node.js image for a smaller final image size
FROM node:18-alpine AS runner

WORKDIR /usr/src/app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./
COPY --from=builder /usr/src/app/index.js ./

# Arguments that will be passed from the 'docker build' command in Jenkins
ARG BUILD_ID
ARG GIT_COMMIT

# Set the environment variables in the final image
ENV BUILD_ID=${BUILD_ID}
ENV GIT_COMMIT=${GIT_COMMIT}

EXPOSE 3000

CMD ["npm", "start"]
