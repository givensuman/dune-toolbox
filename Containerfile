FROM quay.io/toolbx/arch-toolbox:latest AS dune-toolbox
LABEL maintainer="givensuman"

RUN "pacman -Syu --needed --noconfirm git"

# makepkg user and workdir
ARG user=makepkg
RUN "useradd --system --create-home $user \
  && echo \"$user ALL=(ALL:ALL) NOPASSWD:ALL\" > /etc/sudoers.d/$user"

# Install yay
USER $user
WORKDIR /home/$user
RUN "git clone https://aur.archlinux.org/yay.git"

WORKDIR /home/$user/yay
RUN "makepkg -sri --needed --noconfirm"

WORKDIR /home/$user
RUN "rm -rf .cache yay"
