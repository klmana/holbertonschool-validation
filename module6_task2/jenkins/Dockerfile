FROM jenkins/jenkins:lts-jdk11

RUN echo "2.0" > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

COPY --chown=jenkins:jenkins jenkins.yml /usr/share/jenkins/ref/jenkins.yaml
