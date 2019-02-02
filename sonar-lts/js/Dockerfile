FROM castocolina/sonar-lts:base

COPY plugins.txt /

USER root
RUN set -x && cd /opt && bash /install-plugins.sh
USER sonarqube