# Dockerfile for XV6-RISC-V 

# --- Base container --- #
FROM ubuntu:25.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Dependency installs + clean up

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        ca-certificates \
        curl \
        qemu-system-x86 \
        qemu-system-misc \
        gdb-multiarch \
        python3 \
        make \
        nasm \
        gcc-riscv64-linux-gnu \
        binutils-riscv64-linux-gnu \
        libc6-dev \
        libncurses-dev \
        device-tree-compiler \
        sudo 

RUN update-ca-certificates

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# --- Builder stage --- #
FROM base AS builder

# Set environment variables
ARG USERNAME="xv6"
ARG USER_HOME="/home/${USERNAME}"
ARG XV6_ROOT="${USER_HOME}"


# Create and set user
RUN useradd --create-home --home-dir "${USER_HOME}" --shell=/bin/bash --user-group "${USERNAME}" --groups sudo && \
    mkdir -p "${XV6_ROOT}" && \
    chown "${USERNAME}:${USERNAME}" "${XV6_ROOT}" && \
    echo "${USERNAME}:xv6" | chpasswd
USER ${USERNAME}
WORKDIR ${USER_HOME}

# Clone the XV6-RISC-V repository
RUN git clone https://github.com/mit-pdos/xv6-riscv.git 

# Set working directory
WORKDIR ${USER_HOME}/xv6-riscv

# Build Xv6
RUN make

# Set default container executable
CMD ["/bin/bash"]