FROM ubuntu:18.04

WORKDIR /root

RUN \
    apt-get update && apt-get install -y \
    sysstat \
    openjdk-8-jre-headless

COPY . .

RUN chmod 777 *

CMD ["./main_rundocker.sh", "avrora", "avrora"]
