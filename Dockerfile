ARG IMAGE_BASE
FROM $IMAGE_BASE

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:brightbox/ruby-ng  && \
    apt-get update  && \
    apt-get install -y --no-install-recommends \
    build-essential \
    pkg-config \
    git \
    wget \
    curl  \
    sudo \
    ruby2.5 \
    ruby2.5-dev \
    locales \
    tzdata \
    bash-completion && \
    apt-get clean && \
    echo 'Etc/UTC' > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get install -q -y --no-install-recommends tzdata && \
    echo "Binary::apt::APT::Keep-Downloaded-Packages \"true\";" | tee /etc/apt/apt.conf.d/bir-keep-cache && \
    rm -rf /etc/apt/apt.conf.d/docker-clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /root

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

