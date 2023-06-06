docker build -t pr2n33th/multi-client:latest -t pr2n33th/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pr2n33th/multi-server:latest -t pr2n33th/multi-server:$SHA -f ./server/Dockerfile: ./server
docker build -t pr2n33th/multi-worker:latest -t pr2n33th/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pr2n33th/multi-client:latest
docker push pr2n33th/multi-server:latest
docker push pr2n33th/multi-worker:latest

docker push pr2n33th/multi-client:$SHA
docker push pr2n33th/multi-server:$SHA
docker push pr2n33th/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pr2n33th/multi-server:$SHA
kubectl set image deployments/client-deployment client=pr2n33th/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pr2n33th/multi-worker:$SHA
