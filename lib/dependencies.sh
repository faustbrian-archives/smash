#!/usr/bin/env bash

check_program_dependencies()
{
    local -a dependencies="${1}"

    for dependency in ${dependencies[@]}; do
        if [[ -z $(command -v "${dependency}") ]]; then
            read -p "[${dependency}] is not installed. Do you want to install it? [y/N] :" choice

            if [[ "$choice" =~ ^(yes|y) ]]; then
                success "Installing ${dependency}..."
                sudo apt-get install "${dependency}" -y
                success 'Installation OK!'
            else
                abort 1 "Please ensure that [${dependency}] is installed and try again."
            fi
        fi
    done
}

check_nodejs_dependencies()
{
    local -a dependencies="${1}"

    for dependency in ${dependencies[@]}; do
        if [[ -z $(command -v "${dependency}") ]]; then
            read -p "[${dependency}] is not installed. Do you want to install it? [y/N] :" choice

            if [[ "$choice" =~ ^(yes|y) ]]; then
                success "Installing ${dependency}..."
                npm install -g "${dependency}"
                success 'Installation OK!'
            else
                abort 1 "Please ensure that [${dependency}] is installed and try again."
            fi
        fi
    done
}

check_file_dependencies()
{
    local -a dependencies="${1}"

    for dependency in ${dependencies[@]}; do
        if [[ ! -f "${dependency}" ]]; then
            abort 1 "Please ensure that [${dependency}] exists and try again."
        fi
    done
}

check_process_dependencies()
{
    local -a dependencies="${1}"

    for dependency in ${dependencies[@]}; do
        if [[ ! $(pgrep -x "${dependency}") ]]; then
            read -p "[${dependency}] is not running. Do you want to start it? [y/N] :" choice

            if [[ "$choice" =~ ^(yes|y) ]]; then
                success "Starting ${dependency}..."
                sudo service "${dependency}" start
                success 'Start OK!'
            else
                abort 1 "Please ensure that [${dependency}] is running and try again."
            fi
        fi
    done
}
