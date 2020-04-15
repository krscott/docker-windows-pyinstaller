# docker-windows-pyinstaller
Boilerplate for building a PyInstaller exe in a Windows Docker container.

## Quick Start
Add project files to `src/` and update `requirements.txt`.

Optionally change `Dockerfile` to use your preferred version of python.

From a bash environment, run `build.sh`. Or, execute the docker commands manually.

PyInstaller exe will be copied to `dist/` in the host's project directory.

## Branches
Alternative feature boilerplates exist on other branches:

- `master` - windowsservercore, python
- `pyodbc` - windowsservercore, python (32bit), MS Access ODBC driver (32bit), pyodbc