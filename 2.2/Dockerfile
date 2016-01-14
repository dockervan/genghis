FROM alpine:3.1

MAINTAINER Sullivan SENECHAL <soullivaneuh@gmail.com>

RUN apk add --update --virtual .deps ruby libstdc++ && rm -rf /var/cache/apk/* \
&& apk add --update --virtual .build-deps ruby-rake ruby-libs ruby-dev musl-dev gmp-dev gcc g++ make && rm -rf /var/cache/apk/* \
&& gem install --no-ri --no-rdoc bson_ext:'~>1.8.0' genghisapp:'~>2.2.0' \
&& apk del .build-deps

EXPOSE 5678

ADD entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/genghisapp --no-launch --foreground --no-update-check --servers $(cat servers)
