#!/usr/bin/env bash

command_install()
{
    while getopts u:p: option; do
        case "$option" in
            u)
                local user=$OPTARG
            ;;
            p)
                local password=$OPTARG
            ;;
        esac
    done

    info "User is [$user]..."
    info "Password is [$password]..."
}
