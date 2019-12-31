docker build -t stephengrider/multi-client:latest -t iamallaboutk8/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t iamallaboutk8/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t stephendrider/multi-worker:latest -t iamallaboutk8/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push iamallaboutk8/multi-client:latest
docker push iamallaboutk8/multi-server:latest
docker push iamallaboutk8/multi-worker:latest

docker push iamallaboutk8/multi-client:$SHA
docker push iamallaboutk8/multi-server:$SHA
docker push iamallaboutk8/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
