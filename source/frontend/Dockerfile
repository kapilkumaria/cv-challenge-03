# Stage 1: Build
FROM node:16-alpine as build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built files from the first stage
COPY --from=build /app/dist /usr/share/nginx/html

# # Copy custom Nginx configuration for the server block
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
