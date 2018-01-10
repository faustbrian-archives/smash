#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
# set -o nounset
set -o pipefail
set -o noclobber

shopt -s extglob

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly __file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
readonly __base="$(basename ${__file} .sh)"
readonly __root="$(cd "$(dirname "${__dir}")" && pwd)"
readonly __manifest="${__dir}/manifest.json"
readonly __daemon="${__dir}/daemon.json"

readonly -a DEPENDENCIES_PROGRAMS=('jq')
readonly -a DEPENDENCIES_NODEJS=('pm2')
# readonly -a DEPENDENCIES_FILES=()
# readonly -a DEPENDENCIES_PROCESSES=()

source "${__dir}/bootstrap/lib.sh"
source "${__dir}/bootstrap/app.sh"

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
