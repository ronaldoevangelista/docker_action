#!/bin/sh -l

export AUTOPROJ_INSTALL=https://raw.githubusercontent.com/rock-core/autoproj/master/bin/autoproj_install

export PROJECT="${PROJECT:-}"
export BOOTSTRAP_URL="${BOOTSTRAP_URL:-}"
export USER_NAME="${USER_NAME:-}"
export USER_EMAIL="${USER_EMAIL:-}"
export PRIVATE_SSH_KEY="${PRIVATE_SSH_KEY:-}"
export WORKSPACE="$HOME/workspace"

export AUTOPROJ_OSDEPS_MODE=all
export AUTOPROJ_BOOTSTRAP_IGNORE_NONEMPTY_DIR=1

if [ ! -d "$WORKSPACE" ]; then
    mkdir -p "$WORKSPACE"
    cd ${WORKSPACE}

    if [ ! -d "$WORKSPACE" ]; then
        printf "Could not create workspace dir"
        exit 1
    fi
fi

if [ ! -f "$HOME/.gitconfig" ]; then
    printf "Setup gitconfig \n\n"
    git config --global user.name  ${USER_NAME}
    git config --global user.email ${USER_EMAIL}
    printf $(cat "$HOME/.gitconfig")
fi

if [ ! -f "$HOME/.ssh" ]; then
    mkdir -p -m 700 $HOME/.ssh
    touch $HOME/.ssh/known_hosts
    sudo chmod 600 $HOME/.ssh/known_hosts
    ssh-keyscan github.com > $HOME/.ssh/known_hosts
    # echo "${PRIVATE_SSH_KEY}" > $HOME/.ssh/id_rsa
    # unset PRIVATE_SSH_KEY
    # chmod 400 $HOME/.ssh/id_rsa
    # eval $(ssh-agent -s)
    # ssh-add $HOME/.ssh/id_rsa
fi

git clone -o autobuild git@github.com:romulogcerqueira/sonar_simulation.git autoproj

[ -f "autoproj_install" ] || wget -nv ${AUTOPROJ_INSTALL}
[ -d ".autoproj" ] || { mkdir -p .autoproj; cat <<EOF > .autoproj/config.yml; }
---
osdeps_mode: all
GITORIOUS: ssh
GITHUB: ssh
ROCK_SELECTED_FLAVOR: master
ROCK_FLAVOR: master
ROCK_BRANCH: master
USE_OCL: false
rtt_corba_implementation: omniorb
rtt_target: gnulinux
cxx11: false
apt_dpkg_update: true
EOF

[ -f "autoproj.gemfile" ] || { cat <<EOF > autoproj.gemfile; }
source "https://rubygems.org"
gem "autoproj", github: 'rock-core/autoproj'
gem "autobuild", github: 'rock-core/autobuild'
EOF

ruby autoproj_install --no-interactive --gemfile=autoproj.gemfile

. ./env.sh

# autoproj bootstrap git ${BOOTSTRAP_URL}

