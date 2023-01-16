FROM jenkins/jenkins:latest-jdk11
WORKDIR /module6_task0
USER root


# Disable the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file into the image
COPY plugins.txt ./jenkins/

# Install the plugins defined in the plugins.txt file
RUN /usr/local/bin/install-plugins.sh < ./jenkins/plugins.txt

USER jenkins
