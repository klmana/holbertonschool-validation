FROM jenkins/jenkins:lts-jdk11@sha256:f8b19176b7d4f62cc40ae8605fbbfb2abc6ed7aec9f36989fc7b3e616371b956
WORKDIR /module6_task2
USER jenkins

# Disable the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file to the container
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins/jenkins.yml /var/jenkins_home/


# Install the plugins defined in the plugins.txt file with fixed version 
RUN  jenkins-plugin-cli --plugins configuration-as-code -v 1.32


# Copy the groovy scripts to the container
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]


# syntax=docker/dockerfile:1
FROM ubuntu:22.04
WORKDIR /module6_task2

USER jenkins
