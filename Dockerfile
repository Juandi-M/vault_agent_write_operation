# Use a specific Node.js base image
FROM node:20.5.1-alpine

# Set the working directory in the container
WORKDIR /app

# Create a new user 'appuser'
RUN addgroup -S appuser && adduser -S appuser -G appuser

# Copy package.json and package-lock.json to the container
COPY web/js/package*.json ./

# Install application dependencies
RUN npm install

# Copy the application files
COPY web/js/ ./

# Change ownership of the /jsproject directory to appuser
RUN chown -R appuser:appuser /app

# Switch to 'appuser'
USER appuser

# Expose the port that your application runs on
EXPOSE 3001

# Define the command to start your application
CMD ["node", "app.js"]
