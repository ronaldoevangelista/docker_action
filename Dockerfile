ARG IMAGE_BASE
FROM $IMAGE_BASE

ARG APP_HOME=${USER_WORKSPACE:-"~/workspace"}
ENV WORKSPACE ${APP_HOME}

WORKDIR ${APP_HOME}

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

RUN pwd
RUN ls -laF
