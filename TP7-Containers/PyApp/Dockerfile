FROM docker.ntl.nc/debian:buster

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/* 

RUN pip3 install flask jsonify

ADD hello.py /

EXPOSE 5000

ENTRYPOINT ["python3", "/hello.py"]
