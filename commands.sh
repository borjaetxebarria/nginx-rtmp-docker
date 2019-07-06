docker login --username=borjaetxebarria
docker build -t borjaetxebarria/nginx_rtmp:latest .
docker push borjaetxebarria/nginx_rtmp:latest
docker run -it --rm --name nginx -p 8080:80 borjaetxebarria/nginx_rtmp

