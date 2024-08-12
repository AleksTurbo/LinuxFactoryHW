FROM debian:latest
RUN apt-get update \
&& apt-get -y install gcc \
&& apt-get -y install libpcre3 libpcre3-dev \
&& apt-get -y install zlib1g-dev \
&& apt-get -y install wget \
&& apt-get -y install make \
&& apt-get -y install git \
&& apt-get clean

RUN mkdir -p /lua

RUN wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz && tar -zxvf LuaJIT-2.0.5.tar.gz -C /lua
RUN cd /lua/LuaJIT-2.0.5 && make install PREFIX=/usr/local/LuaJIT

RUN cd / && git clone https://luajit.org/git/luajit.git
RUN cd luajit && make && make install

RUN mkdir -p /lua-nginx-module
RUN wget https://github.com/openresty/lua-nginx-module/archive/refs/tags/v0.10.27.tar.gz && tar -zxvf v0.10.27.tar.gz -C /lua-nginx-module

RUN cd / && git clone https://github.com/openresty/lua-resty-core.git
RUN cd lua-resty-core && make install LUA_LIB_DIR=/usr/local/share/lua/5.1

RUN cd / && git clone https://github.com/openresty/lua-resty-lrucache.git
RUN cd lua-resty-lrucache && make install LUA_LIB_DIR=/usr/local/share/lua/5.1

RUN mkdir -p /nginx
RUN wget https://nginx.org/download/nginx-1.18.0.tar.gz && tar -xf nginx-1.18.0.tar.gz -C /nginx --strip-components=1 

RUN chown -R root:root /nginx

RUN cd /nginx \
  && chmod +x ./configure \
  && export LUAJIT_LIB=/usr/local/LuaJIT/lib \
  && export LUAJIT_INC=/usr/local/LuaJIT/include/luajit-2.0 \
  && ./configure --with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib" --add-module=/lua-nginx-module/lua-nginx-module-0.10.27 \
  && make && make install

COPY nginx.conf /usr/local/nginx/conf/

COPY index.html /usr/local/nginx/html/
  
EXPOSE 80
CMD [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]