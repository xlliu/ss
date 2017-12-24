#!/bin/bash
yum install -y epel-release
yum install -y git vim screen gettext gcc autoconf libtool automake make asciidoc xmlto udns-devel libev-devel zlib-devel openssl-devel unzip libevent pcre pcre-devel perl perl-devel cpio expat-devel gettext-devel htop rng-tools c-ares-devel

yum remove -y libtool autoconf automake

cp /usr/include/libev/* /usr/include/

chkconfig ip6tables off
chkconfig iptables off
service iptables stop
service ip6tables stop

export LIBTOOL_VER=2.4.6
wget https://ftp.gnu.org/gnu/libtool/libtool-$LIBTOOL_VER.tar.gz
tar zxf libtool-$LIBTOOL_VER.tar.gz
rm -rf libtool-$LIBTOOL_VER.tar.gz
cd libtool-$LIBTOOL_VER
./configure --prefix=/usr
make 
make install
cd ..
ldconfig
rm -rf libtool-$LIBTOOL_VER

export AUTOCONF_VER=2.69
wget https://ftp.gnu.org/gnu/autoconf/autoconf-$AUTOCONF_VER.tar.gz
tar zxf autoconf-$AUTOCONF_VER.tar.gz
rm -rf autoconf-$AUTOCONF_VER.tar.gz
cd autoconf-$AUTOCONF_VER
./configure --prefix=/usr
make
make install
cd ..
ldconfig
rm -rf autoconf-$AUTOCONF_VER

export AUTOMAKE_VER=1.15.1
wget https://ftp.gnu.org/gnu/automake/automake-$AUTOMAKE_VER.tar.gz
tar zxf automake-$AUTOMAKE_VER.tar.gz
rm -rf automake-$AUTOMAKE_VER.tar.gz
cd automake-$AUTOMAKE_VER
./configure --prefix=/usr
make 
make install
cd ..
ldconfig
rm -rf automake-$AUTOMAKE_VER

export LIBSODIUM_VER=1.0.15
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar zxf libsodium-$LIBSODIUM_VER.tar.gz
rm -rf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr
make
make install
popd
ldconfig
rm -rf libsodium-$LIBSODIUM_VER

export MBEDTLS_VER=2.6.0
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
rm -rf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
make DESTDIR=/usr install
popd
ldconfig
rm -rf mbedtls-$MBEDTLS_VER

export LIBEV_VER=4.24
wget http://dist.schmorp.de/libev/libev-$LIBEV_VER.tar.gz
tar -zxf libev-$LIBEV_VER.tar.gz
pushd libev-$LIBEV_VER
./configure
make
make install
popd
ldconfig
rm -rf libev-$LIBEV_VER

git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive
./autogen.sh
./configure
make
make install
cd ..
rm -rf shadowsocks-libev

git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure
make 
make install
cd ..
rm -rf simple-obfs
