mvn clean package

docker build -t hellomule4 .

docker run -it --rm -p 80:8081 hellomule4 