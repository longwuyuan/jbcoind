FROM ubuntu

WORKDIR /root

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install iputils-ping vim-tiny net-tools git curl lsof openssl gcc g++ wget git cmake protobuf-compiler libprotobuf-dev libssl-dev && \
    mkdir boost && \
    cd boost && \
    wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz && \
    tar -xzf boost_1_67_0.tar.gz && \
    cd boost_1_67_0 && \
    ./bootstrap.sh && \
    ./b2 headers && \
    ./b2 -j4 

RUN cd /root && \
    git clone https://github.com/JBcoin-JBC/JBcoin.git jbcoin && \
    cd jbcoin && \
    mkdir my_build && \
    cd my_build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBOOST_ROOT=/root/boost/boost_1_67_0 .. && \
    cmake --build . -- -j4 && \
    cp /root/jbcoin/cfg/validators.txt /root/jbcoin/my_build/validators.txt && \
    echo "#!/bin/bash" >> /start.sh && \
    echo "exec /root/jbcoin/my_build/jbcoind --conf /root/jbcoin/my_build/jbcoind.cfg" >> /start.sh && \
    chmod +x /start.sh

COPY jbcoind.cfg /root/jbcoin/my_build/jbcoind.cfg

EXPOSE  5005 50235

ENTRYPOINT  [ "/start.sh" ]
