docker build -t nadjibdeveloper/multi-client:latest -t nadjibdeveloper/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t nadjibdeveloper/multi-server -f -t nadjibdeveloper/multi-server:$SHA ./server/Dockerfile.dev ./server
docker build -t nadjibdeveloper/multi-worker -f -t nadjibdeveloper/multi-worker:$SHA ./worker/Dockerfile.dev ./worker

docker push nadjibdeveloper/multi-client:latest
docker push nadjibdeveloper/multi-server:latest
docker push nadjibdeveloper/multi-worker:latest

docker push nadjibdeveloper/multi-client:$SHA
docker push nadjibdeveloper/multi-server:$SHA
docker push nadjibdeveloper/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nadjibdeveloper/multi-server:$SHA
kubectl set image deployments/client-deployment client=nadjibdeveloper/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nadjibdeveloper/multi-worker:$SHA
