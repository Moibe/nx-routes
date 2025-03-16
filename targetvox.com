server {
    server_name targetvox.com www.targetvox.com;

    location / {
        root /var/www/noxoroxo.com;
        index noxoroxo.com.html;
        
    listen 80;
    server_name targetvox.com www.targetvox.com;
    }
