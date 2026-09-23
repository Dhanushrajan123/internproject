FROM nginx:alpine

COPY Index.html /usr/share/nginx/html/index.html

EXPOSE 80
