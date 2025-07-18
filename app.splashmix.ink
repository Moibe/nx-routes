server {
    server_name app.splashmix.ink;

    location / {  
        proxy_pass http://127.0.0.1:7800/; 
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

   location = /buy {
    root /var/www/splashmix-buy;
    try_files /index.html =404;
}

   location = /login {
    root /var/www/splashmix-login;
    try_files /login.html =404;
}

location = /index.css {
    root /var/www/splashmix-login;
}

location = /auth.js {
    root /var/www/splashmix-login;
}

location = /config.js {
    root /var/www/splashmix-login;
}

location = /tabulator.js {
    root /var/www/splashmix-buy;
}

location = /index.js {
    root /var/www/splashmix-buy;
}

location = /api.js {
    root /var/www/splashmix-buy;
}

location = /precios.js {
    root /var/www/splashmix-buy;
}

location = /auth_buy.js {
    root /var/www/splashmix-buy;
}

location = /style.css {
    root /var/www/splashmix-buy;
}

location /imagenes/ {
    root /var/www/splashmix-buy;
    try_files $uri $uri/ =404;
}
    
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/splashmix.ink/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/splashmix.ink/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {   

    if ($host = app.splashmix.ink) {
        return 301 https://$host$request_uri;
    } # managed by Certbot
    
    server_name app.splashmix.ink;
    listen 80;
    return 404; # managed by Certbot

}
