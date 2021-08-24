docker build -t ste5an/multi-client:latest -t ste5an/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ste5an/multi-server:latest -t ste5an/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ste5an/multi-worker:latest -t ste5an/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ste5an/multi-client:latest
docker push ste5an/multi-server:latest
docker push ste5an/multi-worker:latest

docker push ste5an/multi-client:$SHA
docker push ste5an/multi-server:$SHA
docker push ste5an/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ste5an/multi-server:$SHA
kubectl set image deployments/client-deployment client=ste5an/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ste5an/multi-worker:$SHA