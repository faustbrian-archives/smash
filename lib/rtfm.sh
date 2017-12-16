#!/usr/bin/env bash

read_the_fucking_manual()
{
    printf "%s# ---------------------------------------------------------------------------"
    printf "%s\n#"
    printf "%s\n#  $(get_config_details title)"
    printf "%s\n#    Version: $(get_config_details version)"
    printf "%s\n#"
    printf "%s\n#  Usage:"
    printf "%s\n#    $(get_config_details syntax)"
    printf "%s\n#"
    printf "%s\n"

    local MAX_COL=0
    local COUNT_ARGS=$(get_config_args_length)

    for (( i = 0; i < COUNT_ARGS; i++ )) do
        ARG_LEN=$(get_config_arg $i abbreviation)+$(get_config_arg $i command)

        ((${#ARG_LEN} > MAX_COL)) && MAX_COL=${#ARG_LEN}

        (($i == COUNT_ARGS-1 )) && ((MAX_COL+=6))
    done

    for (( i = 0; i < COUNT_ARGS; i++ )) do
        printf "%-${MAX_COL}s %s\n" "#  $(get_config_arg $i abbreviation), $(get_config_arg $i command)" "$(get_config_arg $i description)"
    done

    printf "%s#\n"
    printf "%s# ---------------------------------------------------------------------------"
}
