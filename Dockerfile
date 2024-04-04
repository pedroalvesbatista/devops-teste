FROM node-alpine:18.10

WORKDIR /app 
COPY /app/* /app 

RUN npm install 

EXPOSE 3000

RUN npm test
RUN npm start