FROM ubuntu

WORKDIR /root

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install git curl lsof net-tools openssl gcc g++ wget git cmake protobuf-compiler libprotobuf-dev libssl-dev

RUN  mkdir boost && \
	cd boost && \
	wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz && \
	tar -xzf boost_1_67_0.tar.gz && \
	cd boost_1_67_0 && \
	./bootstrap.sh && \
	./b2 headers && \
	./b2 -j2 

RUN cd /root && \
    git clone https://github.com/JBcoin-JBC/JBcoin.git jbcoin && \
    cd jbcoin && \
    git checkout master && \
    export BOOST_ROOT=/root/boost/boost_1_67_0 && \
    mkdir my_build

RUN cd /root/jbcoin/my_build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBOOST_ROOT=/root/boost/boost_1_67_0 -DCMAKE_INSTALL_PREFIX=/opt/jbcoin .. && \
    cmake --build . -- -j2 && \
    ln -s /root/jbcoin/my_build/jbcoind /usr/bin/jbcoind && \
    echo "/usr/bin/jbcoind --net --conf /root/jbcoin/my_build/jbcoind.cfg" > /start.sh && \
    chmod +x /start.sh

COPY jbcoind.cfg /root/jbcoin/my_build/jbcoind.cfg

EXPOSE  5005 15005 6006 50235

ENTRYPOINT  [ "/start.sh"]
