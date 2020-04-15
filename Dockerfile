FROM python:3.8-windowsservercore

RUN mkdir C:\proj
WORKDIR C:/proj

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY src src

RUN pyinstaller src/main.py
RUN pip freeze > dist/main/pip-lock.txt

ENTRYPOINT [ "dist/main/main.exe" ]
