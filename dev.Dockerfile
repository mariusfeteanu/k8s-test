FROM debian:jessie

# Pre-requisites for Google Cloud SDK
RUN apt-get update -y && \
    apt-get install -y \
      wget \
      telnet \
      iputils-ping \
      gnupg2 \
      lsb-core \
      curl \
      apt-utils \
      tmux

# Install the Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y


RUN useradd -ms /bin/bash gc
WORKDIR /home/gc
COPY --chown=gc:gc build/ build/

USER gc

RUN chmod +x build/gcloud.sh && ./build/gcloud.sh
