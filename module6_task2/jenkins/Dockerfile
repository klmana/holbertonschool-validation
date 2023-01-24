# Use a specific version of the Jenkins LTS image with JDK11
# FROM jenkins/jenkins:lts-jdk11-20.10.23

# Set the Jenkins version to 2.0
# RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# Copy the list of plugins and their specific versions
# COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the specified plugins
# RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy the Jenkins configuration file
# COPY --chown=jenkins:jenkins jenkins.yml /usr/share/jenkins/ref/jenkins.yaml

FROM jenkins/jenkins:lts-jdk11-20.10.23

# Set the timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install additional plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy custom configuration files
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

# Add a user
ARG JENKINS_USER=jenkins
ARG JENKINS_PASS=jenkins
ENV JENKINS_USER ${JENKINS_USER}
ENV JENKINS_PASS ${JENKINS_PASS}

# Set Jenkins home directory
ENV JENKINS_HOME /var/jenkins_home
RUN chown -R ${JENKINS_USER} "$JENKINS_HOME"

# Switch to the jenkins user
USER ${JENKINS_USER}

# Expose the Jenkins port
EXPOSE 8080

# Start Jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
