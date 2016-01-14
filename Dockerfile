FROM alpine

MAINTAINER Sullivan SENECHAL <soullivaneuh@gmail.com>

RUN apk add --no-cache --virtual .deps ruby \
&& apk add --no-cache --virtual .build-deps ruby-rake ruby-libs ruby-dev musl-dev gcc make \
&& gem install --no-ri --no-rdoc bson_ext:1.9 genghisapp \
&& apk del .build-deps

EXPOSE 5678

ADD entrypoint.sh /

COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/genghisapp --no-launch --foreground --no-update-check --servers $(cat servers)
