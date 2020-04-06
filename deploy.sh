docker build -t skitecode/multi-client:latest -t skitecode/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skitecode/multi-server:latest -t skitecode/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skitecode/multi-worker:latest -t skitecode/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push skitecode/multi-client:latest
docker push skitecode/multi-server:latest
docker push skitecode/multi-worker:latest
docker push skitecode/multi-client:$SHA
docker push skitecode/multi-server:$SHA
docker push skitecode/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=skitecode/multi-client:$SHA
kubectl set image deployments/server-deployment server=skitecode/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=skitecode/multi-worker:$SHA
