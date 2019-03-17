docker build -t sherondale/multi-docker-client:latest -t sherondale/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t sherondale/multi-docker-server:latest -t sherondale/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t sherondale/multi-docker-worker:latest -t sherondale/multi-docker-worker:$SHA -f ./server/Dockerfile ./server

docker push sherondale/multi-docker-client:latest
docker push sherondale/multi-docker-server:latest
docker push sherondale/multi-docker-worker:latest

docker push sherondale/multi-docker-client:$SHA
docker push sherondale/multi-docker-server:$SHA
docker push sherondale/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/multi-docker-server multi-docker-server=sherondale/multi-docker-server:$SHA
kubectl set image deployments/multi-docker-client multi-docker-client=sherondale/multi-docker-client:$SHA
kubectl set image deployments/multi-docker-worker multi-docker-worker=sherondale/multi-docker-worker:$SHA