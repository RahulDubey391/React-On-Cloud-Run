FROM node:16.13.1 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:latest AS ngi

COPY --from=build /app/build /usr/share/nginx/html

COPY /nginx.conf  /etc/nginx/conf.d/default.conf

EXPOSE 80