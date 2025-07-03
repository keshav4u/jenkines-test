FROM jenkins/jenkins:lts-jdk17

USER root

# Update package lists and upgrade existing packages to reduce vulnerabilities
RUN apt-get update && \
    apt-get upgrade -y && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm --version && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins