# This Dockerfile creates a android enviroment prepared to run integration tests
from ubuntu:16.04

RUN apt-get update && apt-get install openjdk-8-jdk git wget -y

#Install Android
RUN wget -qO- https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz --show-progress \
  | tar -xz -C /opt/
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools

#Install Android Tools
RUN echo y | android update sdk --filter tools --no-ui --force -a \
  && echo y | android update sdk --filter platform-tools --no-ui --force -a \
  && echo y | android update sdk --filter build-tools-24.0.3 --no-ui -a \
  && echo y | android update sdk --filter android-24 --no-ui --force -a \
  && echo y | android update sdk --no-ui --all --filter extra-android-m2repository \
  && echo y | android update sdk --no-ui --all --filter extra-google-m2repository

# Add platform-tools to path
ENV PATH $PATH:$ANDROID_HOME/platform-tools

ADD entrypoint.sh /home/entrypoint.sh
RUN chmod +x /home/entrypoint.sh

ENTRYPOINT ["/home/entrypoint.sh"]

#Label
MAINTAINER Catbag <developer@catbag.com.br>
LABEL Version="1.0" \
      Vendor="Catbag" \
      Description="Android CI ready environment"
