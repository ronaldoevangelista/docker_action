#!/bin/sh -l

export AUTOPROJ_INSTALL=https://raw.githubusercontent.com/rock-core/autoproj/master/bin/autoproj_install

export PROJECT="${PROJECT:-}"
export BOOTSTRAP_URL="${BOOTSTRAP_URL:-}"
export USER_NAME="${USER_NAME:-}"
export USER_EMAIL="${USER_EMAIL:-}"
export PRIVATE_SSH_KEY="${PRIVATE_SSH_KEY:-}"
export WORKSPACE="${PROJECT}_ws"
export AUTOPROJ_OSDEPS_MODE=all
export AUTOPROJ_BOOTSTRAP_IGNORE_NONEMPTY_DIR=1

git config --global user.name  ${USER_NAME}
git config --global user.email ${USER_EMAIL}

mkdir -p ~/${WORKSPACE}
cd ~/${WORKSPACE}

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

