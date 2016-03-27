FROM alpine 

MAINTAINER Alvaro Hurtado Mochon <alvarohurtado84@gmail.com>

RUN apk add --update py-pip mysql-client bash apk-cron && \
  pip install awscli && \
  rm -fR /var/cache/apk/*

# this prevent "TERM environment variable not set.""
ENV TERM dumb

# predefine required env vars
ENV AWS_ACCESS_KEY_ID **ID**
ENV AWS_SECRET_ACCESS_KEY **KEY**
ENV AWS_DEFAULT_REGION eu-west-1
ENV BUCKET **BUCKET**
ENV FILENAME backup
ENV BACKUP_WINDOW 0 6 * * *

RUN mkdir -p /backup
ADD . /backup
RUN chmod +x /backup/bin/*

WORKDIR /backup/bin/

ENTRYPOINT ["/backup/bin/entrypoint"]
