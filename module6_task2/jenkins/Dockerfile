# Use a specific version of the Jenkins LTS image with JDK11
FROM jenkins/jenkins:lts-jdk11-20.10.23

# Set the Jenkins version to 2.0
RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# Copy the list of plugins and their specific versions
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the specified plugins
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy the Jenkins configuration file
COPY --chown=jenkins:jenkins jenkins.yml /usr/share/jenkins/ref/jenkins.yaml
