NAME="flutter_element_ui"

CONTAINER_ID=$(docker ps -aqf name=${NAME})

if [ -n "$CONTAINER_ID" ]; then
 echo "delete docker ID $CONTAINER_ID"
 docker stop "$CONTAINER_ID"
 docker rm "$CONTAINER_ID"
fi

IMAGE_ID=$(docker images -q ${NAME})
if [ -n "$IMAGE_ID" ]; then
 echo "delete old image, ID $IMAGE_ID"
 docker rmi "$IMAGE_ID"
fi

echo "build docker image"
docker build -t $NAME .

echo "run docker container"
docker run --name $NAME -p 8082:80 -d $NAME
