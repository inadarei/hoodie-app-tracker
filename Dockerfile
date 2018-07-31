FROM node:8-alpine

# Set credentials from the environment
ENV HOODIE_USER=admin
ENV HOODIE_PWD=secret

WORKDIR /app

ADD package.json ./
ADD ./public ./public
# ADD ./.hoodierc ./

RUN apk add --no-cache git && npm install --production --no-optional && \
    apk del git && \
    rm -rf /tmp/* /root/.npm

ENV hoodie_dbUrl http://$HOODIE_USER:$HOODIE_PWD@couchdb:5984/

EXPOSE 8080

CMD ["npm", "start", "--", "--bind-address", "0.0.0.0"]
