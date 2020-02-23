docker build -t millsmcilroy/multi-client:latest -t millsmcilroy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t millsmcilroy/multi-server:latest -t millsmcilroy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t millsmcilroy/multi-worker:latest -t millsmcilroy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push millsmcilroy/multi-client:latest
docker push millsmcilroy/multi-server:latest
docker push millsmcilroy/multi-worker:latest

docker push millsmcilroy/multi-client:$SHA
docker push millsmcilroy/multi-server:$SHA
docker push millsmcilroy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=millsmcilroy/multi-server:$SHA
kubectl set image deployments/client-deployment client=millsmcilroy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=millsmcilroy/multi-worker:$SHA