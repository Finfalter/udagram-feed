# Use NodeJS base image
FROM node:13

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm ci 

# Bundle app source
COPY . .

EXPOSE 8085

CMD [ "npm", "run", "prod" ]


# # Use NodeJS base image
# FROM node:13

# # Create app directory
# WORKDIR /usr/src/app

# # Install app dependencies by copying
# # package.json and package-lock.json
# COPY package*.json ./

# # Copy app source
# COPY . .

# # Install dependencies
# RUN npm install

# # Copy app source
# COPY ./www/. .

# # Bind the port that the image will run on
# EXPOSE 8080

# # Define the Docker image's behavior at runtime
# CMD ["node", "www/server.js"]