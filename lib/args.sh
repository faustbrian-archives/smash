#!/usr/bin/env bash

get_config_details()
{
    cat $MANIFESTO | jq -r '.details.'$1''
}

get_config_arg()
{
    cat $MANIFESTO | jq -r '.commands['$1'].'$2''
}

get_config_args_length()
{
    cat $MANIFESTO | jq -r '.commands|length'
}

get_config_arg_value()
{
    local COUNT_ARGS=$(get_config_args_length)

    for (( i = 0; i < COUNT_ARGS; i++)) do
        local ARG_OPTIONS=$(get_config_arg $i command)

        case $1 in
            $ARG_OPTIONS)
                echo "${ARG_VALUE[$i]}"
                return
            ;;
        esac
    done
}

parse_args()
{
    local method=$(cat $MANIFESTO | jq -r --arg COMMAND "$1" '.commands[] | select(.command == $COMMAND) | .method')

    if [[ -z "$method" ]]; then
        method=$(cat $MANIFESTO | jq -r --arg COMMAND "$1" '.commands[] | select(.abbreviation == $COMMAND) | .method')
    fi

    if [[ -z "$method" ]]; then
        read_the_fucking_manual
    fi

    $method "${@:2}"
}
