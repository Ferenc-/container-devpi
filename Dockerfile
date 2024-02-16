FROM python:3.12

ARG ARG_DEVPI_SERVER_VERSION=6.10.0
ENV DEVPI_SERVER_VERSION $ARG_DEVPI_SERVER_VERSION

RUN addgroup --system --gid 1000 devpi \
    && adduser --disabled-password --system --uid 1000 --home /data --shell /sbin/nologin --gid 1000 devpi
    pip install --verbose "devpi-server==${ARG_DEVPI_SERVER_VERSION}"

VOLUME /data
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh && \
    mkdir /data/server && chown devpi:nogroup /data/server

USER devpi
ENV HOME /data
WORKDIR /data

EXPOSE 3141
ENTRYPOINT ["/docker-entrypoint.sh"]
