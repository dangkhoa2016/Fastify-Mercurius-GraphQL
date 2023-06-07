FROM node:alpine

WORKDIR /project

ENV TZ=America/Sao_Paulo

ENV NODE_ENV=production

COPY ["package.json", "./"]

RUN apk update && \
    apk add --no-cache tzdata

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN echo "America/Sao_Paulo" > /etc/timezone

RUN npm install

COPY . .

CMD ["node", "app.js"]
