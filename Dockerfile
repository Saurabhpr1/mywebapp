# stage1: Build the React app
FROM node:16.17.0-alpine AS build
# Set the working directory
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json .
# Install dependencies
RUN npm install
# Copy the remaining application code
COPY . .
# Build the React app
RUN npm run build

# stage2: Deploy on Nginx 
FROM nginx:alpine
# Copy the built app from the 'build' stage
COPY --from=build /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80
