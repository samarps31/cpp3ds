FROM thecruel/devkitarm-3ds:latest
MAINTAINER Thomas Edvalson "machin3@gmail.com"

ENV CPP3DS /opt/cpp3ds

COPY . /usr/src/cpp3ds
WORKDIR /usr/src

RUN apt-get update && apt-get -y install \
    libgtest-dev \
	libsfml-dev \
	libglew-dev \
	qt5-default \
	libopenal-dev \
	libjpeg-dev \
	libpng-dev \
	libfreetype6-dev \
	libvorbis-dev

RUN apt-get -y clean

RUN wget -q https://github.com/cpp3ds/3ds_portlibs/releases/download/r3/portlibs-3ds-r3.tar.xz -O portlibs.tar.xz && \
    tar -xaf portlibs.tar.xz && \
    rm portlibs.tar.xz && \
    ln -s $(pwd)/portlibs $DEVKITPRO/portlibs && \
    ln -s $DEVKITPRO/portlibs/3ds $DEVKITPRO/portlibs/armv6k

RUN wget -q https://github.com/cpp3ds/3ds-tools/releases/download/r4/3ds-tools-linux-r4.tar.gz -O tools.tar.gz && \
    tar -xaf tools.tar.gz && \
    cp 3ds-tools/* $DEVKITARM/bin && \
    rm tools.tar.gz

WORKDIR /usr/src/gtest
RUN cmake . && \
    make -j4 && \
    cp *.a /usr/lib && \
    make clean

WORKDIR /usr/src/cpp3ds
RUN mkdir build && \
    cd build && \
    cmake -DBUILD_EMULATOR=ON -DENABLE_OGG=ON -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=ON .. && \
    make -j4 && \
    cd .. && \
    ./bin/tests && \
    mkdir $CPP3DS && \
    cp -r build/lib $CPP3DS && \
    cp -r include $CPP3DS && \
    cp -r cmake $CPP3DS && \
    cp -r scripts $CPP3DS && \
    cd .. && \
    rm -r cpp3ds
