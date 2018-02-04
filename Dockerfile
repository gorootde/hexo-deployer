FROM alpine

MAINTAINER Michael Kolb <dev@goroot.de>
RUN apk --no-cache add nodejs-npm git openssh imagemagick && npm install -g hexo

ENV GIT_URL=ssh://git@foo.com:60000/site.git
ENV SECRET=password

VOLUME /repo
WORKDIR /repo
COPY entrypoint.sh /opt/entrypoint.sh
COPY ssh/config /root/.ssh/config
RUN chmod +x /opt/entrypoint.sh


ENTRYPOINT ["/opt/entrypoint.sh"]
