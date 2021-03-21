FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# RUN npm install
# If you are building your code for production
RUN npm ci --only=production

# Bundle app source
COPY index.js .

ENV LOGS_FOLDER=/var/log
ENV FILE_NAME=output.log
ENV FILE_MAX_SIZE_BYTES=5000
ENV MAX_FILES=100
ENV TAILABLE=true

EXPOSE 8080
CMD [ "node", "index.js" ]