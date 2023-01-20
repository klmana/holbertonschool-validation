FROM ubuntu:20.04

# Update the package manager and install SSH
RUN apt-get update && apt-get install -y ssh

# Install Docker version 20.10
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add the ubuntu user and give it permission to execute administrative commands and run Docker
RUN groupadd docker
RUN useradd -m ubuntu
RUN usermod -aG sudo ubuntu
RUN usermod -aG docker ubuntu

# Copy the ensure-server-setup.sh script to the image
COPY ensure-server-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ensure-server-setup.sh

# Set the entrypoint to the ensure-server-setup.sh script
ENTRYPOINT ["/usr/local/bin/ensure-server-setup.sh"]

