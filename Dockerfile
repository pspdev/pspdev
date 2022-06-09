ARG BASE_DOCKER_IMAGE

FROM $BASE_DOCKER_IMAGE

COPY . /src

# There are some dependencies needed because it is checked by "depends" scripts
RUN apk add build-base git bash patch wget zlib-dev ucl-dev readline-dev libusb-compat-dev \
    autoconf automake bison flex python3 py3-pip cmake pkgconfig libarchive-dev openssl-dev gpgme-dev libtool
RUN cd /src && ./build-extra.sh

# Second stage of Dockerfile
FROM alpine:latest

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}
RUN apk add --no-cache gmp mpc1 mpfr4 make bash pkgconf
