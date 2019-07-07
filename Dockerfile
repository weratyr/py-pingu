FROM arm64v8/ubuntu:xenial

ADD ./qemu-aarch64-static /usr/bin/

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3-dev gcc g++ python3-pip libz-dev python3-setuptools  && \
    python3 -m pip install --upgrade pip && \
    pip3 install --no-cache-dir pyinstaller scapy pyroute2 && \
    mkdir -p /pypingu && \
    mkdir -p /output

WORKDIR /
#
#ADD requirements.txt .
#
#RUN pip3 install --no-cache-dir -r requirements.txt

ADD ./pypingu.py /pypingu/

RUN pyinstaller -F /pypingu/pypingu.py

ENTRYPOINT ["/bin/cp", "/dist/pypingu", "/output"]
