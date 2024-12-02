openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certbot/conf/sensuo.site.key -out ./certbot/conf/sensuo.site.crt -subj "/CN=sensuo.site"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./certbot/conf/buildsource.site.key -out ./certbot/conf/buildsource.site.crt -subj "/CN=buildsource.site"

docker network create mynetwork

docker-compose down -v
docker-compose up -d --build

docker stop $(docker ps -q)
docker rm $(docker ps -a -q)

docker logs certbot

docker stop 37ebe29c5c2e
docker rm 37ebe29c5c2e

docker restart nginx


docker exec -it mongo sh
mongosh --authenticationDatabase admin -u buildsource -p 4d77739b-36dd-4760-a98f-981efdc92cc0


db.createUser({ user: "sensuo", pwd: "2d3ece0c-7c22-46f2-892f-9de4f69e7dd5", roles: [{ role: "readWrite", db: "sensuo" }] });