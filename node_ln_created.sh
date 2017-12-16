rm -rf /usr/local/bin/node /usr/bin/node /usr/lib/node
rm -rf /usr/local/bin/npm /usr/bin/npm

echo 'rm ln success'

ln -s ~/work/node/bin/node /usr/local/bin/node
ln -s ~/work/node/bin/node /usr/bin/node
ln -s ~/work/node/bin/node /usr/lib/node
echo 'node ln is created success'
ln -s ~/work/node/bin/npm /usr/local/bin/npm
ln -s ~/work/node/bin/npm /usr/bin/npm
echo 'npm ln is created success'
