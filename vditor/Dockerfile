FROM node:lts-alpine

# Create dir for application
WORKDIR /app

RUN apk add git \
    && git clone --depth=1 https://github.com/Vanessa219/vditor.git ./ \
    && npm install

# Expose the port the application will run on
EXPOSE 8080

# Run the application
CMD ["npm", "run", "server"]
