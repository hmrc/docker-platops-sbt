from eclipse-temurin:21

ARG SBT_VERSION 
ARG HOME=/root


WORKDIR $HOME

RUN apt-get update -qq \
    && apt-get install -qqy \
    curl


COPY sbt-files/ $HOME/.sbt/


RUN curl --fail -L -o "sbt-launch.jar" "https://artefacts.tax.service.gov.uk/artifactory/jcenter-cache/org/scala-sbt/sbt-launch/1.9.7/sbt-launch-1.9.7.jar" 
RUN curl -L -o "sbt-$SBT_VERSION.deb" "https://scala.jfrog.io/artifactory/debian/sbt-$SBT_VERSION.deb"
RUN dpkg -i "sbt-$SBT_VERSION.deb"
RUN rm "sbt-$SBT_VERSION.deb"
RUN sbt -Dsbt.override.build.repos=true 'inspect writeVersion'



