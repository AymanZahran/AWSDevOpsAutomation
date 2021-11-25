FROM nginx
RUN rm -rf /usr/share/nginx/html/*
COPY ./index.html /usr/share/nginx/html/index.html
RUN sed -i 's/Service_Type/ECS Task/g' /usr/share/nginx/html/index.html
RUN sed -i 's/CodeDeploy_Stage/ECS Rolling Update/g' /usr/share/nginx/html/index.html
RUN chmod 664 /usr/share/nginx/html/index.html