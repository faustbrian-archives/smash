#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
# set -o nounset
set -o pipefail
set -o noclobber

shopt -s extglob

readonly EXEC_APP=$(basename "$0")
readonly EXEC_DIR=$(dirname "$0")
readonly MANIFESTO="${EXEC_DIR}/manifesto.json"

readonly -a DEPENDENCIES_PROGRAMS=('jq')
readonly -a DEPENDENCIES_NODEJS=('pm2')
# readonly -a DEPENDENCIES_FILES=()
# readonly -a DEPENDENCIES_PROCESSES=()

source "${EXEC_DIR}/lib/bootstrap.sh"
source "${EXEC_DIR}/app/bootstrap.sh"

main()
{
    check_program_dependencies "${DEPENDENCIES_PROGRAMS[@]}"
    check_nodejs_dependencies "${DEPENDENCIES_NODEJS[@]}"
    # check_file_dependencies "${DEPENDENCIES_FILES[@]}"
    # check_process_dependencies "${DEPENDENCIES_PROCESSES[@]}"

    parse_args "$@"

    trap cleanup SIGINT SIGTERM SIGKILL
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
