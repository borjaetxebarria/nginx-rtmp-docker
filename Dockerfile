FROM buildpack-deps:stretch

LABEL maintainer="Borja Etxebarria <borja.snet@gmail.com>"

ENV NGINX_VERSION nginx-1.17.1

# Build directory
RUN mkdir -p /tmp/build 

# Download and decompress Nginx
RUN cd /tmp/build && \
 wget -q http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
 tar -xzf ${NGINX_VERSION}.tar.gz

# Download and decompress RTMP module
RUN cd /tmp/build && \
 wget -q https://github.com/arut/nginx-rtmp-module/archive/master.zip && \
 unzip -q master.zip

# Build and install Nginx
RUN cd /tmp/build/${NGINX_VERSION} && \
 ./configure \
  --with-threads \
  --add-module=/tmp/build/nginx-rtmp-module-master && \
  make && \
  make install && \
  rm -rf /tmp/build

EXPOSE 1935
EXPOSE 80
CMD /bin/bash

#CMD ["nginx", "-g", "daemon off;"]
