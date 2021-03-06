FROM fradelg/pdal
LABEL version="1.1.0" maintainer="frandelhoyo@gmail.com" author="Connor Manning <connor@hobu.co>"

RUN apt-get update && \
    apt-get install -y g++ git cmake ninja-build liblzma-dev libjsoncpp-dev libcurl4-gnutls-dev libatomic1 && \
    # Install entwine
    git clone --depth 1 -b 1.1.0 https://github.com/connormanning/entwine /tmp/entwine && \
    mkdir /tmp/entwine/build && cd /tmp/entwine/build && \
    cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. && \
    ninja install && \
    # Remove all dev dependencies and clean workspace
    apt-get purge -y g++ git cmake ninja-build liblzma-dev libjsoncpp-dev libcurl4-gnutls-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT ["entwine"]
