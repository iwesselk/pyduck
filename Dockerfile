FROM python:3.7.4-buster

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get install -y uwsgi-plugin-python3

COPY ./requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt
COPY ./ /usr/src/app

EXPOSE 80

CMD ["uwsgi --http 0.0.0.0:80 --wsgi-file app.py --callable app"]