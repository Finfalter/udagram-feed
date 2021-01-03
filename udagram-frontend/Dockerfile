FROM beevelop/ionic:latest AS ionic
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN ionic build
FROM nginx:alpine
#COPY www /usr/share/nginx/html
COPY --from=ionic  /usr/src/app/www /usr/share/nginx/html

# __CB__added
#EXPOSE 8100

# __CB__added
#CMD ["ionic", "serve"]
#CMD ["ionic", "serve", "--external"]


# # Use NodeJS base image
# FROM node:13

# # Create app directory
# WORKDIR /usr/src/app

# # Install app dependencies by copying
# # package.json and package-lock.json
# COPY package*.json ./

# # Install general dependencies
# RUN npm install

# # Install ionic
# RUN npm install -g ionic

# # compile the application into static files
# RUN ionic build

# # Copy app source
# COPY ./www/. .

# # Bind the port that the image will run on
# EXPOSE 8082

# # Define the Docker image's behavior at runtime
# CMD ["ionic", "serve"]
