FROM alpine:latest AS builder
WORKDIR /git
RUN apk add git \
    && git clone --depth=1 https://github.com/viliusle/miniPaint.git
    
#Written by Ange Cesari
# Use official Node.js based on Alpine
FROM node:alpine

# Create dir for application
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY --from=builder /git/miniPaint ./

# Install dependencies
RUN npm i

# Expose the port the application will run on
EXPOSE 8080

# Run the application
CMD ["npm", "run", "server"]
