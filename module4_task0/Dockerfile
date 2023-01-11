# Start from base image
FROM golang:1.15.8-buster

# update package lists
RUN apt-get update

# install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add brew to path
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Check brew 
RUN which brew

# Install hugo
RUN brew install hugo

# Check hugo
RUN which hugo
