FROM node:18.10

WORKDIR /app 
COPY /app/* /app 

RUN npm install --prooduction

EXPOSE 3000

ENTRYPOINT ["yarn", "start"]