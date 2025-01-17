 FROM nginx:latest
 COPY ./web_export/* /usr/share/nginx/html/

 LABEL Name=community.connections Version=0.0.1
