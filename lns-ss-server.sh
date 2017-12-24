rm -rf /usr/local/bin/ss-server /usr/bin/ss-server /usr/lib/ss-server

echo 'rm ln success'

ln -s /srv/bin/ss-server /usr/local/bin/ss-server
ln -s /srv/bin/ss-server /usr/bin/ss-server
ln -s /srv/bin/ss-server /usr/lib/ss-server
echo 'ln is created success'
