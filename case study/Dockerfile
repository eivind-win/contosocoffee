# runs nginx
FROM nginx:1.23.1-alpine

#adds html folder to nginx folder
ADD /html /usr/share/nginx/html

#changes ownership nginx
RUN chown -R nginx:nginx /usr/share/nginx/html/

#exposes port 80 http
EXPOSE 80
