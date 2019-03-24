docker build -t sherondale/multi-docker-client:latest -t sherondale/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t sherondale/multi-docker-server:latest -t sherondale/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker push sherondale/multi-docker-client:latest
docker push sherondale/multi-docker-server:latest

docker push sherondale/multi-docker-client:$SHA
docker push sherondale/multi-docker-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/multi-docker-server-deployment multi-docker-server=sherondale/multi-docker-server:$SHA
kubectl set image deployments/multi-docker-client-deployment multi-docker-client=sherondale/multi-docker-client:$SHA