FROM eleidan/buildpack-deps:jessie

LABEL maintainer="Oleg Kulyk" \
      description="Node.js 6.10.3 with Yarn 0.23.4 based on Debian Jessie" \
      init="docker run -it --rm -v $(pwd):/home/phantom/app eleidan/node:6.10.3-jessie docker-init.sh" \
      run="docker run -it --rm -v $(pwd):/home/phantom/app eleidan/node:6.10.3-jessie" \
      version="2017-05-08"

ENV NODE_VERSION=6.10.3 \
    NPM_CONFIG_LOGLEVEL="info" \
    YARN_VERSION=0.23.4 \
    PATH=$PATH:/home/phantom/app/node_modules/.bin/ \
    SERVICE_NAME="node:6.10.3-jessie"

# Install Node.js
RUN set -ex \
    && for key in \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      56730D5401028683275BD23C23EFEFE93C4CFFFE \
    ; do \
      gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
      gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
      gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
    && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install Yarn package manager
RUN set -ex \
    && for key in \
      6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
      gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
      gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
      gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done \
    && curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
    && curl -fSL -o yarn.js.asc "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js.asc" \
    && gpg --batch --verify yarn.js.asc yarn.js \
    && rm yarn.js.asc \
    && mv yarn.js /usr/local/bin/yarn \
    && chmod +x /usr/local/bin/yarn

COPY docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

# Needed for the docker-init.sh script
COPY recipes $HOME/recipes

WORKDIR "${HOME}/app"
