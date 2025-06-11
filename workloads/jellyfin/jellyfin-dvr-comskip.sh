#!/usr/bin/env bash

#
# This is for Jellyfin docker.
# The comskip.ini file used is stored in /config/comskip for easy access, editing and to survive upgrades.
#

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set ffmpeg path to Jellyfin ffmpeg
__ffmpeg="$(which ffmpeg || echo '/usr/lib/jellyfin-ffmpeg/ffmpeg')"

# Set to skip commericals (mark as chapters) or cut commericals
__command="/config/comskip/comchap"
# __command="/config/comcut"

# Set video container
__container="mkv"

# Green Color
GREEN='\033[0;32m'

# No Color
NC='\033[0m'

# Set Path
__path="${1:-}"

PWD="$(pwd)"

die () {
        echo >&2 "$@"
        cd "${PWD}"
        exit 1
}

# verify a path was provided
[ -n "$__path" ] || die "path is required"
# verify the path exists
[ -f "$__path" ] || die "path ($__path) is not a file"

__dir="$(dirname "${__path}")"
__file="$(basename "${__path}")"
__base="$(basename "${__path}" ".ts")"

# Debbuging path variables
# printf "${GREEN}path:${NC} ${__path}\ndir: ${__dir}\nbase: ${__base}\n"

# Change to the directory containing the recording
cd "${__dir}"

# Transcode to mkv
printf "[post-process.sh] %bTranscoding file..%b\n" "$GREEN" "$NC"
$__ffmpeg -hide_banner -loglevel info -txt_page 888 -txt_format text -i "${__file}" -acodec "aac" -vcodec "copy" -scodec "subrip" "${__base}.${__container}"

#comcut/comskip - currently using jellyfin ffmpeg in docker
#printf "[post-process.sh] %bComskipping...%b\n" "$GREEN" "$NC"
#$__command --ffmpeg=$__ffmpeg --comskip=/usr/bin/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/config/comskip/comskip.ini --keep-edl "${__base}.${__container}"

# Remove the original recording file
printf "[post-process.sh] %bRemoving original file...%b\n" "$GREEN" "$NC"
rm "${__file}"

# Jellyfin server details
API_KEY="8571b207ab2a44918082548e07e75c95"

# Trigger library scan
printf "[post-process.sh] %bTriggering Library Scan...%b\n" "$GREEN" "$NC"
curl -H "X-MediaBrowser-Token: $API_KEY" -H "Content-Type: application/json" -d '{"Updates": [{"Path":"/data/recordings","UpdateType":"scan"}]}' https://jellyfin.prutser.net/Library/Media/Updated

# Return to the starting directory
cd "${PWD}"
