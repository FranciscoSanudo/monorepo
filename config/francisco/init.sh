#replace current configuration

rm -rf /etc/nginx/conf.d/default.conf
cp default.conf /etc/nginx/conf.d

echo "conf succesfully loaded"

#install apache2-tools
apt update
apt install -y apache2-tools

#setup pwd
htpasswd -c /etc/nginx/.htpasswd solovino

#restart nginx
service restart nginx
