server {
    server_name noxoroxo.com www.noxoroxo.com;

    location / {
	root /usr/share/nginx/html;
	index noxoroxo.com.html;
    }

    location /detecta-integra/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7877/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /astroblend/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7877/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /superheroes/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7888/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /super/ {  # Free ver for Chrs 
        proxy_pass http://127.0.0.1:7889/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /fortnite/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7899/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /sampler/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7811/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /palette/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7822/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /acuarela/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7822/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /observa/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7833/; # Change this if your Gradio app will be running on a different port
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
    ssl_certificate /etc/letsencrypt/live/noxoroxo.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/noxoroxo.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 12M;



}

server {
    if ($host = www.noxoroxo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    if ($host = noxoroxo.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    server_name noxoroxo.com www.noxoroxo.com;
    return 404; # managed by Certbot

}
