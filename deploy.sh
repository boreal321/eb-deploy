#!/usr/bin/env bash
#
# elastic beanstalk cli wrapper supporting multiple environments
#
if [ -z "$1" ]; then
    echo "error: please supply an environment name like qa or prod"
    exit 1
fi

env=$1

if [ "${env}" == "qa" ] || [ "${env}" == "prod" ]; then
    echo "configuring for environment: ${env}"
fi

if [ ! -d .ebextensions ]; then
    echo "error: no .ebextensions directory. make sure you are in the build directory."
    exit 1
fi

if [ "${env}" == "qa" ]; then
    cd .ebextensions
    for config in `ls -1 *.${env}`; do
        ln -sf ${config} `echo -n ${config}|sed -e "s/.${env}$//"`
    done
    ls -l *config
fi

if [ "${env}" == "prod" ]; then
    cd .ebextensions
    for config in `ls -1 *.${env}`; do
        ln -sf ${config} `echo -n ${config}|sed -e "s/.${env}$//"`
    done
    ls -l *config
fi

read -p "Ready to deploy. Are you sure? [y/n] "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo deploying...
    eb deploy
    echo deploy script finished!
fi