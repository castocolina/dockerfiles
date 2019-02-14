FROM openjdk:8

LABEL maintainer="castocolina@gmail.com"

ARG SONAR_VERSION=6.7.6
ARG RUN_FILE=https://raw.githubusercontent.com/SonarSource/docker-sonarqube/master/${SONAR_VERSION}-community/run.sh
ARG DOWNLOAD_URL=https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip

ENV SONAR_VERSION=$SONAR_VERSION \
    SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    # DEPRECATED. Use -v sonar.jdbc.username=... instead
    # Drop these in the next release, also in the run script
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL= \
    BUNDLE_PLUGIN_DIR=/opt/sonarqube/lib/bundled-plugins \
    PLUGIN_DIR=/opt/sonarqube/extensions/plugins

# Http port
EXPOSE 9000

RUN groupadd -r sonarqube && useradd -r -g sonarqube sonarqube \
     && echo ">>>>> '$DOWNLOAD_URL'"

# grab gosu for easy step-down from root
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && (gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
        || gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4) \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

COPY plugins.txt install-plugins.sh /

RUN set -x \
    # pub   2048R/D26468DE 2015-05-25
    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
    # uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
    # sub   2048R/06855C1D 2015-05-25
    && (gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
	    || gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE) \
    && cd /opt \
    && curl -o sonarqube.zip -fSL $DOWNLOAD_URL \
    && curl -o sonarqube.zip.asc -fSL $DOWNLOAD_URL.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip -q sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && chown -R sonarqube:sonarqube sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/* \
    && ln -s sonarqube/lib/sonar-application-$SONAR_VERSION.jar sonarqube/lib/sonar-application.jar \
    && rm -vrf $BUNDLE_PLUGIN_DIR/*.jar && bash /install-plugins.sh

VOLUME "$SONARQUBE_HOME/data"

WORKDIR $SONARQUBE_HOME
ADD $RUN_FILE $SONARQUBE_HOME/bin/
RUN chmod +xr $SONARQUBE_HOME/bin/run.sh
USER sonarqube
ENTRYPOINT ["./bin/run.sh"]