ARG IMAGE_BASE
FROM $IMAGE_BASE

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update  > /dev/null 2>&1 && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:brightbox/ruby-ng  && \
    apt-get update  > /dev/null 2>&1 && \
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
    ssh \
    bash-completion> /dev/null 2>&1 && \
    echo 'Etc/UTC' > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get clean && \
    echo "Binary::apt::APT::Keep-Downloaded-Packages \"true\";" | tee /etc/apt/apt.conf.d/bir-keep-cache && \
    rm -rf /etc/apt/apt.conf.d/docker-clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    export LANGUAGE=en_US.UTF-8; \
    export LANG=en_US.UTF-8; \
    export LC_ALL=en_US.UTF-8; \
    locale-gen en_US.UTF-8; \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales > /dev/null 2>&1

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]

CMD ["exit"]