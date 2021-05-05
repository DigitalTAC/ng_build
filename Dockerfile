FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# gnupg2, unzip, curl, wget
RUN apt-get update && apt-get install -y software-properties-common gnupg2 unzip libkrb5-dev build-essential curl wget && rm -rf /var/lib/apt/lists/*

# nodejs
# RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
# RUN sh -c "echo deb https://deb.nodesource.com/node_10.x bionic main > /etc/apt/sources.list.d/nodesource.list"
# RUN apt-get install -y nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# sonar-scanner-cli
WORKDIR /root
RUN wget "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip"
RUN unzip sonar-scanner-cli-4.0.0.1744-linux.zip
ENV PATH $PATH:/root/sonar-scanner-4.0.0.1744-linux/bin

# chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# firefox
RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN apt-get update && apt-get install -y firefox && rm -rf /var/lib/apt/lists/*

# angular/cli
RUN npm install -g @angular/cli

# IBM® DevOps Insights integration
RUN npm install -g grunt-idra3
