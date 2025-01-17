 FROM nginx:latest
 COPY ./web_export/* /usr/share/nginx/html/
 COPY ./web_export/* /etc/nginx/html/
 COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
 COPY ./nginx/key.pem /etc/nginx/certs/key.pem
 COPY ./nginx/cert.pem /etc/nginx/certs/cert.pem

 EXPOSE 443

 LABEL Name=community.connections Version=0.0.1
