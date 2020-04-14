#!bash

# exit when any command fails
set -e
trap 'echo ''; echo Error at $(basename "$0"):${LINENO}: $BASH_COMMAND' ERR
# set working directory to this script's directory
cd "${0%/*}"

unix2dospath() {
    echo $(realpath "$1") | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/'
}

HOST_BUILD_DIR="dist"
IMAGE="pyinstaller-builder"
WIN_HOST_MOUNT=$(unix2dospath "$HOST_BUILD_DIR")

# [ -d "$HOST_BUILD_DIR" ] && rm -r "$HOST_BUILD_DIR"
mkdir -p "$HOST_BUILD_DIR"

docker build -t $IMAGE .
# docker run -it --rm --entrypoint cmd $IMAGE
docker run -v "$WIN_HOST_MOUNT":'C:\mount' --rm \
    --entrypoint cmd $IMAGE '//c' \
    'robocopy C:\proj\dist\main C:\mount /MIR /copy:dat || rem'