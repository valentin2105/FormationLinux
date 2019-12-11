FROM docker.ntl.nc/alpine:latest

RUN apk update && \
    apk add python3 && \
    pip3 install --upgrade pip

RUN pip3 install flask jsonify

ADD hello.py /

EXPOSE 5000

ENTRYPOINT ["python3", "/hello.py"]
