FROM node:10-slim

# docker build process is treated as locale with in the POSIX.
# It must be defined explicitly in Dockerfile
# https://github.com/docker/docker/issues/2424#issuecomment-27269233
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# apt-get upgrade
RUN set -x \
        && apt-get update -q \
        && apt-get install -qy --no-install-recommends \
             # base toolbelt
             build-essential ca-certificates locales git autotools-dev automake ssh \
             # optional toolbelt
             vim less \
        # Update Locale to en_US.UTF-8
        && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
        && locale-gen && update-locale LANG=en_US.UTF-8 

# node setup
ENV NPM_CONFIG_LOGLEVEL info

# Install react and react-dom
ENV REACT_VERSION 16.6.0
ENV REACT_DOM_VERSION 16.6.0

RUN set -x \
            && npm install -g yarn \
            && yarn add react@${REACT_VERSION} \ 
            && yarn add react-dom@${REACT_DOM_VERSION} 
            # && yarn add create-react-app \

# Install redux
RUN set -x \
            && yarn add prop-types \
            && yarn add redux redux-actions redux-logger redux-promise react-redux \
            && yarn add --dev redux-devtools 

# Install webpack
RUN set -x \
            && yarn add webpack webpack-cli \
            && yarn add --dev webpack-dev-server 

# Install babel
RUN set -x \
            && yarn add --dev babel-core babel-loader@7 babel-preset-react babel-preset-env babel-preset-es2015
            

# Install ajax related 
RUN set -x \
            && yarn add isomorphic-fetch

# Install material-ui
RUN set -x \
            && yarn add material-ui react-tap-event-plugin

# Install loader
RUN set -x \
            && yarn add --dev css-loader style-loader source-map-loader

# Install eslint
RUN set -x \
            && yarn add --dev eslint-config-airbnb eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react


WORKDIR /usr/src/app

# Install npm_modules and bower_components
COPY package.json /usr/src/app

RUN set -x \
            && yarn install
