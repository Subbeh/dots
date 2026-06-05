FROM --platform=linux/amd64 archlinux:latest

ARG USERNAME=dev

RUN echo "DisableSandbox" >> /etc/pacman.conf \
    && pacman -Syu --noconfirm \
      base-devel \
      curl \
      git \
      sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && useradd -m -s /bin/bash "$USERNAME"

USER $USERNAME
WORKDIR /home/$USERNAME
