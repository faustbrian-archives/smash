#!/usr/bin/env bash

read_the_fucking_manual()
{
    printf "%s# ---------------------------------------------------------------------------"
    printf "%s\n#"
    printf "%s\n#  $(manifesto_details title)"
    printf "%s\n#    Version: $(manifesto_details version)"
    printf "%s\n#"
    printf "%s\n#  Usage:"
    printf "%s\n#    $(manifesto_details syntax)"
    printf "%s\n#"
    printf "%s\n"

    local MAX_COL=0
    local COUNT_ARGS=$(manifesto_commands_length)

    for (( i = 0; i < COUNT_ARGS; i++ )) do
        ARG_LEN=$(manifesto_command_value $i abbreviation)+$(manifesto_command_value $i command)

        ((${#ARG_LEN} > MAX_COL)) && MAX_COL=${#ARG_LEN}

        (($i == COUNT_ARGS-1 )) && ((MAX_COL+=6))
    done

    for (( i = 0; i < COUNT_ARGS; i++ )) do
        local abbreviation="$(manifesto_command_value $i abbreviation)"

        if [[ "$abbreviation" == "null" ]]; then
            printf "%-${MAX_COL}s %s\n" "#  $(manifesto_command_value $i command)" "$(manifesto_command_value $i description)"
        else
            printf "%-${MAX_COL}s %s\n" "#  ${abbreviation}, $(manifesto_command_value $i command)" "$(manifesto_command_value $i description)"
        fi
    done

    printf "%s#\n"
    printf "%s# ---------------------------------------------------------------------------"
}
