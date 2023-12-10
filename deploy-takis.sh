export HOST_IP=52.206.69.183 #change the ip

wget -NP . https://dokku.com/install/v0.32.3/bootstrap.sh
sudo DOKKU_TAG=v0.32.3 bash bootstrap.sh

dokku domains:set-global $HOST_IP

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y

cat ~/.ssh/id_rsa.pub | sudo dokku ssh-keys:add admin

dokku apps:create takis-kowan

sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
dokku postgres:create takis-database

dokku postgres:link takis-database takis-kowan

git clone https://github.com/richiecsenlia/takis.git

cd takis

git remote add dokku dokku@$HOST_IP:takis-kowan

rm runtime.txt Procfile
wget -O Dockerfile https://raw.githubusercontent.com/adillahptr/files/master/Dockerfile
wget -O entrypoint.sh https://raw.githubusercontent.com/adillahptr/files/master/entrypoint.sh

git add -A
git commit -m "update"

git push dokku master