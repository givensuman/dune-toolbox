FROM archlinux:latest
LABEL maintainer="givensuman"

# Update the system and install git
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git base-devel && \
    pacman -Scc --noconfirm

RUN useradd -m -G wheel aur && \
    # Allow the 'aur' user to run sudo without a password
    echo "aur ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/aur

USER aur
WORKDIR /home/aur

# Clone the yay repository and build it
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -rf yay
