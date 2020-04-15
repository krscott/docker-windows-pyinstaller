# from standard python image
# FROM python:3.8-windowsservercore

# from custom 32bit python image (lib/python/Dockerfile)
FROM windows-py-32bit

RUN mkdir C:\proj
WORKDIR C:/proj

ADD https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe .

RUN cmd /C .\AccessDatabaseEngine.exe /quiet

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY src src

# RUN python src/main.py

RUN pyinstaller src/main.py
RUN pip freeze > dist/main/pip-lock.txt

ENTRYPOINT [ "dist/main/main.exe" ]
