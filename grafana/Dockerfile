ARG BASE_IMAGE=latest
FROM ${BASE_IMAGE}

LABEL maintainer="castocolina@gmail.com"

USER grafana

ARG GF_INSTALL_PLUGINS=""
RUN set -x && echo; \
echo "DOWNLOAD PLUGINS >>> ['${GF_INSTALL_PLUGINS}'] ..."; \
echo "--------------------------------------------------"; \
echo; \
if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then \
    OLDIFS=$IFS; \
        IFS=','; \
    for plugin in ${GF_INSTALL_PLUGINS}; do \
        IFS=$OLDIFS; \
        grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install ${plugin}; \
    done; \
fi
