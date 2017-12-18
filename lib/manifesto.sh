#!/usr/bin/env bash

manifesto_details()
{
    cat "${__manifesto}" | jq -r '.details.'$1''
}

manifesto_command_value()
{
    cat "${__manifesto}" | jq -r '.commands['$1'].'$2''
}

manifesto_commands_length()
{
    cat "${__manifesto}" | jq -r '.commands|length'
}
