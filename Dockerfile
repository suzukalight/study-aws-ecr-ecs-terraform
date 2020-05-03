FROM node:12-alpine

WORKDIR /app
COPY package.json .
RUN yarn
COPY . .

EXPOSE 23456
CMD ["node", "dist/index.js"]
