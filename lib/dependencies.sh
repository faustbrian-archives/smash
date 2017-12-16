#!/usr/bin/env bash

check_program_dependencies()
{
    local -a DEPENDENCIES=$1

    for dep in "${DEPENDENCIES[@]}"; do
        if [[ -z $(command -v "$dep") ]]; then
            read -p "$i is not installed. Do you want to install it? [y/N] :" choice

            if [[ $choice =~ ^(yes|y) ]]; then
                success "Installing ${dep}..."
                sudo apt-get install "$dep" -y
                success 'Installation OK!'
            else
                abort 1 "Please ensure that [${dep}] is installed and try again."
            fi
        fi
    done
}

check_nodejs_dependencies()
{
    local -a DEPENDENCIES=$1

    for dep in "${DEPENDENCIES[@]}"; do
        if [[ -z $(command -v "$dep") ]]; then
            read -p "$i is not installed. Do you want to install it? [y/N] :" choice

            if [[ $choice =~ ^(yes|y) ]]; then
                success "Installing ${dep}..."
                npm install -g "$dep"
                success 'Installation OK!'
            else
                abort 1 "Please ensure that [${dep}] is installed and try again."
            fi
        fi
    done
}

check_file_dependencies()
{
    local -a DEPENDENCIES=$1

    for dep in "${DEPENDENCIES[@]}"; do
        if [[ ! -f "$dep" ]]; then
            abort 1 "Please ensure that [${dep}] exists and try again."
        fi
    done
}

check_process_dependencies()
{
    local -a DEPENDENCIES=$1

    for dep in "${DEPENDENCIES[@]}"; do
        if [[ ! $(pgrep -x "$dep") ]]; then
            read -p "[${dep}] is not running. Do you want to start it? [y/N] :" choice

            if [[ $choice =~ ^(yes|y) ]]; then
                success "Starting ${i}..."
                sudo service "$i" start
                success 'Start OK!'
            else
                abort 1 "Please ensure that [${dep}] is running and try again."
            fi
        fi
    done
}
