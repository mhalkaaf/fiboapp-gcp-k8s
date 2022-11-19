docker build -t mhalkaaf/fiboclient:latest -t mhalkaaf/fiboclient:$SHA -f ./client/Dockerfile ./client
docker build -t mhalkaaf/fiboserver:latest -t mhalkaaf/fiboserver:$SHA -f ./server/Dockerfile ./server
docker build -t mhalkaaf/fiboworker:latest -t mhalkaaf/fiboworker:$SHA -f ./worker/Dockerfile ./worker
docker push mhalkaaf/fiboclient:latest
docker push mhalkaaf/fiboserver:latest
docker push mhalkaaf/fiboworker:latest
docker push mhalkaaf/fiboclient:$SHA
docker push mhalkaaf/fiboserver:$SHA
docker push mhalkaaf/fiboworker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mhalkaaf/fiboserver:$SHA
kubectl set image deployments/client-deployment client=mhalkaaf/fiboclient:$SHA
kubectl set image deployments/worker-deployment worker=mhalkaaf/fiboworker:$SHA
