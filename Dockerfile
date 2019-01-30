FROM alpine:latest

RUN apk add --no-cache python3 python3-dev py3-cffi cairo pango gdk-pixbuf \
  zlib-dev jpeg-dev build-base linux-headers msttcorefonts-installer \
  && update-ms-fonts && fc-cache -f \
  && pip3 install --upgrade pip && pip3 install WeasyPrint Flask uWSGI \
  && rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip \
  && find /usr/lib/python3.6 -name '*.pyc' -delete

WORKDIR /opt
ADD ./wsgi.py .

CMD uwsgi --http :9090 --wsgi-file wsgi.py --callable app
