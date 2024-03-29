from eclipse-temurin:21

ARG SBT_VERSION 
ARG HOME=/root
ENV SBT_OPTS=-Dsbt.override.build.repos=true
ENV SBT_LAUNCH_REPO=https://artefacts.tax.service.gov.uk/content/groups/mdtp-proxied-maven-repositories

WORKDIR $HOME

RUN apt-get update -qq \
    && apt-get install -qqy \
    curl \
    git


COPY sbt-files/ $HOME/.sbt/

RUN mkdir ~/build
RUN git config --global --add safe.directory /root/build

RUN curl --fail -L -o "sbt-$SBT_VERSION.deb" "https://scala.jfrog.io/artifactory/debian/sbt-$SBT_VERSION.deb"
RUN dpkg -i "sbt-$SBT_VERSION.deb"
RUN rm "sbt-$SBT_VERSION.deb"
RUN sbt 'inspect writeVersion'





