FROM python:3.8-windowsservercore

RUN mkdir C:/proj
WORKDIR C:/proj

COPY src/requirements.txt src/
RUN pip install -r src/requirements.txt

COPY src src

RUN pyinstaller src/main.py
RUN pip freeze > dist/main/pip-lock.txt

ENTRYPOINT [ "dist/main/main.exe" ]
