docker build -t brinduc/multi-client:latest -t brinduc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brinduc/multi-server:latest -t brinduc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brinduc/multi-worker:latest -t brinduc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brinduc/multi-client:latest
docker push brinduc/multi-client:$SHA

docker push brinduc/multi-server:latest
docker push brinduc/multi-server:$SHA

docker push brinduc/multi-worker:latest
docker push brinduc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brinduc/multi-server:$SHA
kubectl set image deployments/client-deployment client=brinduc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brinduc/multi-workeri:$SHA