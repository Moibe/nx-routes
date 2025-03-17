server {
    server_name targetvox.com www.targetvox.com;

    location / {
        root /var/www/noxoroxo.com;
        index noxoroxo.com.html;
        }

    location /boilerplate/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7860/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /astroblend-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7870/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /superheroes-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7880/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /super-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7881/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /fortnite-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7890/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /sampler-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7810/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /palette-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7820/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /observa-dev/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7830/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/amazonpaypal.cards/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/amazonpaypal.cards/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 10M;

}

server {
    if ($host = www.targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    server_name targetvox.com www.targetvox.com;
    return 404; # managed by Certbot

}
