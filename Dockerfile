from eclipse-temurin:21

ARG SBT_VERSION 
ARG HOME=/root
ENV SBT_OPTS=-Dsbt.override.build.repos=true

WORKDIR $HOME

RUN apt-get update -qq \
    && apt-get install -qqy \
    curl


COPY sbt-files/ $HOME/.sbt/

RUN mkdir ~/build

RUN curl --fail -L -o "sbt-$SBT_VERSION.deb" "https://scala.jfrog.io/artifactory/debian/sbt-$SBT_VERSION.deb"
RUN dpkg -i "sbt-$SBT_VERSION.deb"
RUN rm "sbt-$SBT_VERSION.deb"
RUN sbt -Dsbt.override.build.repos=true 'inspect writeVersion'





