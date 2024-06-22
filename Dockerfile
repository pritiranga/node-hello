# Stage 1: Build the application
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if you have a build step)
# RUN npm run build

# Stage 2: Create the production image
FROM node:14-alpine AS production

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app .

# Install only production dependencies
RUN npm install --only=production

# Expose the port that the application will run on
EXPOSE 3000

# Define the command to run the application
CMD ["node", "app.js"]
