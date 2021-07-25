# First stage
FROM pspdev/pspsdk

COPY . /src

RUN apk add build-base autoconf automake bash bison cmake curl-dev doxygen \
            flex git gpgme-dev libarchive-dev libtool libusb-compat-dev \
            openssl-dev patch python3 readline-dev sdl-dev subversion tcl \
            texinfo wget zlib-dev xz
RUN cd /src && ./pspdev.sh 3 4 5 6 7

# Second stage of Dockerfile
FROM alpine:latest

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}
