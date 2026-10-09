FROM ubuntu:26.04

RUN apt-get update  \
    && apt-get -y --no-install-recommends install \
      build-essential \
      chrpath \
      cpio \
      debianutils \
      diffstat \
      file \
      gawk \
      gcc \
      git \
      iputils-ping \
      libacl1 \
      libcrypt-dev \
      locales \
      lz4 \
      python3 \
      python3-git \
      python3-jinja2 \
      python3-pexpect \
      python3-pip \
      python3-subunit \
      socat \
      texinfo \
      unzip \
      wget \
      xz-utils \
      zstd \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ARG UID=1000
RUN (userdel -r ubuntu 2>/dev/null || true) \
    && useradd -l -u ${UID} -ms /bin/bash builder
USER builder

ENV PATH="/home/builder/.local/bin:${PATH}"

RUN uv tool install bitbake-setup
