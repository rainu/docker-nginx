FROM nginx
MAINTAINER rainu <rainu@raysha.de>

ADD ./entrypoint.sh /bin/entrypoint.sh

CMD [ "/bin/entrypoint.sh" ]