docker build -t nageshvashist/multi-client:latest -t nageshvashist/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nageshvashist/multi-server:latest -t nageshvashist/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nageshvashist/multi-worker:latest -t nageshvashist/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nageshvashist/multi-client:latest
docker push nageshvashist/multi-server:latest
docker push nageshvashist/multi-worker:latest
docker push nageshvashist/multi-client:$SHA
docker push nageshvashist/multi-server:$SHA
docker push nageshvashist/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nageshvashist/multi-client:$SHA
kubectl set image deployments/server-deployment server=nageshvashist/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nageshvashist/multi-worker:$SHA
