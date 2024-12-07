openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certbot/conf/sensuo.site.key -out ./certbot/conf/sensuo.site.crt -subj "/CN=sensuo.site"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certbot/conf/buildsource.site.key -out ./certbot/conf/buildsource.site.crt -subj "/CN=buildsource.site"

docker network create mynetwork

docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

docker-compose down -v
docker-compose up -d --build



docker logs certbot

docker stop 37ebe29c5c2e
docker rm 37ebe29c5c2e

docker restart nginx


docker exec -it mongo sh
mongosh --authenticationDatabase admin -u buildsource -p 4d77739b-36dd-4760-a98f-981efdc92cc0


db.createUser({ user: "sensuo", pwd: "2d3ece0c-7c22-46f2-892f-9de4f69e7dd5", roles: [{ role: "readWrite", db: "sensuo" }] });

docker rm -f nginx
docker rm -f site_buildsource

docker restart site_buildsource


sudo apt update && sudo apt upgrade -y
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d buildsource.site -d www.buildsource.site -d mongo.buildsource.site -d minioapi.buildsource.site -d minioweb.buildsource.site
sudo certbot --nginx -d sensuo.site -d www.sensuo.site

sudo crontab -e
0 3 * * * certbot renew --quiet


sudo lsof -i :80
sudo kill -9 12343

docker swarm init

