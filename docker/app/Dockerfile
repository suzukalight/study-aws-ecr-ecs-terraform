FROM node:12

WORKDIR /app
COPY package.json .
RUN yarn
COPY . .

RUN yarn build

EXPOSE 23456
CMD ["yarn", "start"]
