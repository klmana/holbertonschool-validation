FROM jenkins/jenkins:lts-jdk11
WORKDIR /module6_task0
USER root

# Disable the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file to the container
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the plugins defined in the plugins.txt file with fixed version 
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copy the groovy scripts to the container
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
CMD [ "/docker-gs-ping" ]

# syntax=docker/dockerfile:1
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3 python3-pip 
RUN pip install flask==2.1.*

# install app dependencies
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip install flask==2.1.*

# final configuration
ENV FLASK_APP=hello
EXPOSE 8000
CMD flask run --host 0.0.0.0 --port 8000

USER jenkins
