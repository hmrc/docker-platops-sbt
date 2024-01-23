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
RUN mkdir -p $HOME/.cache/sbt/boot/sbt-launch/$SBT_VERSION
RUN curl --fail -L -o "$HOME/.cache/sbt/boot/sbt-launch/$SBT_VERSION/sbt-launch-$SBT_VERSION.jar" "https://artefacts.tax.service.gov.uk/content/groups/mdtp-proxied-maven-repositories/org/scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch-$SBT_VERSION.jar"
RUN sbt 'inspect writeVersion'





