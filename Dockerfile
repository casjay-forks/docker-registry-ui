FROM casjaysdevdocker/nodejs as build

ARG LICENSE="WTFPL" \
  IMAGE_NAME="docker-registry-ui" \
  TIMEZONE="America/New_York" \
  LICENSE="MIT" \
  NODE_ENV="production" \
  PORT="80"

ENV SHELL=/bin/bash \
  TERM=xterm-256color \
  HOSTNAME=${HOSTNAME:-casjaysdev-$IMAGE_NAME} \
  TZ=$TIMEZONE \
  NODE_ENV=$NODE_ENV \
  NODE_MANAGER="fnm" \
  NODE_VERSION=8

RUN apk update -U --no-cache

COPY ./bin/. /usr/local/bin/
COPY ./config/. /config/
COPY ./data/. /data/

WORKDIR /app
COPY ./app/. /app/
ADD ./LICENSE.md /app/

RUN mkdir -p /bin/ /config/ /data/ && \
  rm -Rf /bin/.gitkeep /config/.gitkeep /data/.gitkeep && \
  setup_node "$NODE_VERSION"

RUN eval "$(fnm env --shell bash)" && \
  fnm install $NODE_VERSION && \
  npm i

FROM scratch
ARG BUILD_DATE="2022-10-07 20:08" \
  BUILD_VERSION="latest"

LABEL org.label-schema.name="docker-registry-ui" \
  org.label-schema.description="Containerized version of docker-registry-ui" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/docker-registry-ui" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/docker-registry-ui" \
  org.label-schema.build-date="$BUILD_VERSION" \
  org.label-schema.version="$BUILD_VERSION" \
  org.label-schema.vcs-ref="$BUILD_VERSION" \
  org.label-schema.license="$LICENSE" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="$BUILD_VERSION" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-docker-registry-ui" \
  TZ="${TZ:-America/New_York}"

VOLUME ["/config","/data"]

EXPOSE $PORT

COPY --from=build /. /

ENTRYPOINT [ "tini", "--" ]
CMD [ "/usr/local/bin/entrypoint-docker-registry-ui.sh" ]
HEALTHCHECK --start-period=1m --interval=2m --timeout=3s CMD [ "/usr/local/bin/entrypoint-docker-registry-ui.sh", "healthcheck" ]
