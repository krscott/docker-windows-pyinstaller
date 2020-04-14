# docker-windows-pyinstaller
Boilerplate for building a PyInstaller exe in a Windows Docker container.

## Quick Start
Add project files to `src/`.

Change `Dockerfile` to use your preferred version of python.

From a bash environment, run `build.sh`. Or, just execute the docker commands manually.

PyInstaller exe will be copied to `dist/` in the host's project directory.
