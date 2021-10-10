FROM python:alpine

ARG DEBIAN_FRONTEND="noninteractive"

ARG DLIB_VERSION="v19.21"

RUN set -xe\
    && apk add build-base cmake git \
    && git clone --single-branch --branch ${DLIB_VERSION} https://github.com/davisking/dlib.git \
    && cd dlib \
    && python3 setup.py install --no USE_AVX_INSTRUCTIONS --no DLIB_USE_CUDA \
    && cd .. \
    && rm -rf dlib \
    && git clone --depth 1 https://github.com/ageitgey/face_recognition.git \
    && cd face_recognition \
    && pip3 install -r requirements.txt \
    && python3 setup.py install \
    && cd .. \
    && rm -rf face_recognition \
    && apk del build-base cmake git \
    && rm -rf /tmp/* /var/tmp/*
