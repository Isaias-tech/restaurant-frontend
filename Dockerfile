FROM node:latest AS Install-Packages

WORKDIR /app

COPY package.json .

RUN npm install

COPY . /app/

RUN npm run build

FROM nginx:latest AS Serve-App

COPY --from=Install-Packages /app/config/nginx/conf.d/restaurant-frontend.conf /etc/nginx/conf.d/

COPY --from=Install-Packages /app/build /usr/share/nginx/html

