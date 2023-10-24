# Docker file of Python flask application
FROM python:3.11-slim-bookworm
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .
EXPOSE 80
ENV FLASK_APP=web-api.py
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=80"]