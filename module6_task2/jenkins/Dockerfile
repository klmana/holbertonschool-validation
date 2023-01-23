FROM jenkins/jenkins:lts-jdk11
WORKDIR /module6_task2
USER ./jenkins

# Disable the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file to the container
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins/jenkins.yml /var/jenkins_home/
COPY --chown=jenkins:jenkins jenkins.yml /usr/share/jenkins/ref/jenkins.yaml

# Install the plugins defined in the plugins.txt file with fixed version
RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN  jenkins-plugin-cli --plugins configuration-as-code -v 1.32


# Copy the groovy scripts to the container
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]


# syntax=docker/dockerfile:1
FROM ubuntu:22.04
WORKDIR /module6_task2

USER /.jenkins
