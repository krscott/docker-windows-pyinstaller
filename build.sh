#!bash

# exit when any command fails
set -e
trap 'echo ''; echo Error at $(basename "$0"):${LINENO}: $BASH_COMMAND' ERR

# set working directory to this script's directory
cd "${0%/*}"

unix2dospath() {
    echo $(realpath "$1") | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/'
}

# Target directory of exe output on host machine
HOST_BUILD_DIR="dist"

# The starting python docker image tag
PY_IMAGE="windows-py-32bit"

# The project docker image tag
PROJ_IMAGE="pyinstaller-builder"

mkdir -p "$HOST_BUILD_DIR"

docker build -t $PY_IMAGE lib/python
docker build -t $PROJ_IMAGE .
# docker run -it --rm --entrypoint cmd $PROJ_IMAGE
docker run -v "$(unix2dospath "$HOST_BUILD_DIR")":'C:\mount' --rm \
    --entrypoint cmd $PROJ_IMAGE '//c' \
    'robocopy C:\proj\dist\main C:\mount /MIR /copy:dat || rem'