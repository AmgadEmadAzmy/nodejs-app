FROM node:12
COPY . /nodeapp
WORKDIR /nodeapp
RUN npm install
EXPOSE 3000
CMD ["node", "/nodeapp/app.js"]
