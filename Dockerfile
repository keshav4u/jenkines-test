# Stage 1: Build the app
FROM node:24-alpine AS builder

WORKDIR /app

# Install all dependencies (dev + prod)
COPY package*.json ./
RUN npm install


# Copy source code and build the app
COPY . .
RUN npm run build


# Stage 2: Run the app
FROM node:24-alpine

WORKDIR /app

# Copy only package.json files and install prod dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy built app from builder stage
COPY --from=builder /app/dist ./dist

# Expose the port the app runs on
EXPOSE 3000

# Run the app
CMD ["node", "dist/main"]
