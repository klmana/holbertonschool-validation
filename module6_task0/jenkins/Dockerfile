FROM jenkins/jenkins:lts-jdk11
WORKDIR /module6_task0
USER root

# Disable the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file to the container
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the plugins defined in the plugins.txt file with fixed version 
RUN jenkins-plugin-cli --plugins-file /usr/share/jenkins/ref/plugins.txt --install --available-updates

# Install the plugins defined in the plugins.txt file with latest version
RUN jenkins-plugin-manager --plugins-file /usr/share/jenkins/ref/plugins.txt --install --available-updates

# Copy the seed job to the container
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

USER jenkins
