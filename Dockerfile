FROM node:12-alpine

WORKDIR /app
COPY package.json .
RUN yarn
COPY . .

RUN yarn build

EXPOSE 23456
CMD ["yarn", "start"]
