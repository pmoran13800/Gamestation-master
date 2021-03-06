FROM ubuntu:16.04
MAINTAINER digitalLumberjack <digitallumberjack@gamestation.com>

ENV TERM xterm
ENV ARCH ''
ENV GAMESTATION_VERSION_LABEL ''
ENV GAMESTATION_CCACHE_DIR ''

# Install dependencies
# needed ? xterm
RUN apt-get update -y && \
apt-get -y install build-essential git libncurses5-dev qt5-default qttools5-dev-tools \
mercurial libdbus-glib-1-dev texinfo zip openssh-client libxml2-utils \
software-properties-common wget cpio bc locales rsync imagemagick \
nano vim automake mtools dosfstools subversion openjdk-8-jdk libssl-dev && \
rm -rf /var/lib/apt/lists/*

# Set the locale needed by toolchain
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

RUN mkdir -p /work
WORKDIR /work

CMD echo ">>> Setting gamestation version to ${GAMESTATION_VERSION_LABEL}" && echo "${GAMESTATION_VERSION_LABEL}" > board/gamestation/fsoverlay/gamestation/gamestation.version && \
    echo ">>> Fetching and reseting buildroot submodule" && ( git submodule init; git submodule update; cd buildroot && git reset HEAD --hard && git clean -dfx ) && \
    echo ">>> Making gamestation-${ARCH}_defconfig" && make gamestation-${ARCH}_defconfig && \
    export GAMESTATION_CCACHE=${GAMESTATION_CCACHE_DIR:+"BR2_CCACHE=y BR2_CCACHE_DIR=$GAMESTATION_CCACHE_DIR BR2_CCACHE_INITIAL_SETUP=--max-size=500G BR2_CCACHE_USE_BASEDIR=y"} && \
    echo ">>> Make with cache : ${GAMESTATION_CCACHE}" && \
    GAMESTATION_VERSION=${GAMESTATION_VERSION_LABEL} make BR2_DL_DIR="/share/dl" BR2_HOST_DIR=/share/host $GAMESTATION_CCACHE
