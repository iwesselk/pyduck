FROM alpine

RUN apk add --no-cache\
    uwsgi-python3 \
    python3


RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

#RUN apt-get update && \
#    apt-get install -y uwsgi-plugin-python3

COPY ./requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt
COPY ./ /usr/src/app

EXPOSE 80

CMD ["uwsgi", "--http-socket", "0.0.0.0:80",\
    "--plugins", "python3", \
    "--wsgi-file", "app.py", "--callable", "app"]