FROM eleidan/base:ubuntu-20.04

USER root

### Browser tests need a browser
ARG CHROME_FILE="google-chrome-stable_current_amd64.deb"
RUN wget https://dl.google.com/linux/direct/${CHROME_FILE} \
    && apt-get update \
    && apt install -y ./${CHROME_FILE} \
    && rm ${CHROME_FILE}

### Ngrok for exposing local server to outer world
ARG NGROK_FILE="ngrok-stable-linux-amd64.zip"
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/${NGROK_FILE} \
    && unzip ${NGROK_FILE} -d /usr/local/bin/ \
    && rm ${NGROK_FILE}

### Adapt container user for the host UID and GID
ARG HOST_UID=1000
ARG HOST_GID=1000
RUN usermod -u ${HOST_UID} phantom
RUN groupmod -g ${HOST_GID} phantom
RUN chown -R phantom:phantom ${HOME}

USER phantom
WORKDIR ${HOME}/app

