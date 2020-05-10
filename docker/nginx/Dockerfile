FROM nginx:1.16.0-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf.baseconf

ENV APP_HOST=mokmok.cloud

EXPOSE 80

CMD /bin/sh -c "envsubst '$$APP_HOST' < /etc/nginx/conf.d/default.conf.baseconf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
