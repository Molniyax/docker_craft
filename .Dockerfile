FROM alpine:3.16.8
WORKDIR /server

RUN apk update && apk add openjdk17 udev screen

COPY ./init/* .

CMD screen -S server java -Xmx1024M -Xms1024M -jar server.jar nogui
