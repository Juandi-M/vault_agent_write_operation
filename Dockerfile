# Use a Node.js base image
FROM node:20.5.1

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container from WebRender
COPY WebRender/package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application files from WebRender
COPY WebRender/ .

# Expose the port that your application runs on
EXPOSE 3001

# Define the command to start your application
CMD ["node", "app.js"]