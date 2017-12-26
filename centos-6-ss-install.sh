#!/bin/bash
yum install -y epel-release
yum install -y git vim wget screen gettext gcc autoconf libtool automake make asciidoc xmlto udns-devel libev-devel zlib-devel openssl-devel unzip libevent pcre pcre-devel perl perl-devel cpio expat-devel gettext-devel htop rng-tools c-ares-devel

yum remove -y libtool autoconf automake

# cp /usr/include/libev/* /usr/include/
LIBEV_VER=4.24
LIBTOOL_VER=2.4.6
AUTOCONF_VER=2.69
AUTOMAKE_VER=1.15.1
LIBSODIUM_VER=1.0.15
MBEDTLS_VER=2.6.0

wget http://dist.schmorp.de/libev/libev-$LIBEV_VER.tar.gz
wget https://ftp.gnu.org/gnu/libtool/libtool-$LIBTOOL_VER.tar.gz
wget https://ftp.gnu.org/gnu/autoconf/autoconf-$AUTOCONF_VER.tar.gz
wget https://ftp.gnu.org/gnu/automake/automake-$AUTOMAKE_VER.tar.gz
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
git clone https://github.com/shadowsocks/shadowsocks-libev.git
git clone https://github.com/shadowsocks/simple-obfs.git

tar -zxf libev-$LIBEV_VER.tar.gz
pushd libev-$LIBEV_VER
./configure --prefix=/usr
make
make install
popd
ldconfig
rm -rf libev-$LIBEV_VER

chkconfig ip6tables off
chkconfig iptables off
service iptables stop
service ip6tables stop

tar zxf libtool-$LIBTOOL_VER.tar.gz
rm -rf libtool-$LIBTOOL_VER.tar.gz
pushd libtool-$LIBTOOL_VER
./configure --prefix=/usr
make 
make install
popd
ldconfig
rm -rf libtool-$LIBTOOL_VER

tar zxf autoconf-$AUTOCONF_VER.tar.gz
rm -rf autoconf-$AUTOCONF_VER.tar.gz
pushd autoconf-$AUTOCONF_VER
./configure --prefix=/usr
make
make install
popd
ldconfig
rm -rf autoconf-$AUTOCONF_VER

tar zxf automake-$AUTOMAKE_VER.tar.gz
rm -rf automake-$AUTOMAKE_VER.tar.gz
pushd automake-$AUTOMAKE_VER
./configure --prefix=/usr
make 
make install
popd
ldconfig
rm -rf automake-$AUTOMAKE_VER

tar zxf libsodium-$LIBSODIUM_VER.tar.gz
rm -rf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr
make
make install
popd
ldconfig
rm -rf libsodium-$LIBSODIUM_VER

tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
rm -rf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
make DESTDIR=/usr install
popd
ldconfig
rm -rf mbedtls-$MBEDTLS_VER

pushd shadowsocks-libev
git submodule update --init --recursive
./autogen.sh
./configure --prefix=/srv/
make
make install
popd
rm -rf shadowsocks-libev

pushd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure
make 
make install
popd
rm -rf simple-obfs

source lns-ss-server.sh

chkconfig ip6tables on
chkconfig iptables on
service iptables start
service ip6tables start
