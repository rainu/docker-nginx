FROM nginx

ADD ./entrypoint.sh /bin/entrypoint.sh

CMD [ "/bin/entrypoint.sh" ]