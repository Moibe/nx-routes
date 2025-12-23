server {
    server_name imagen.splashmix.ink;
    root /code/splashmix_dash/dist;

    # Cache para archivos estáticos (JS/CSS con hash en nombre)
    location ~* ^/(_app/|assets/).*\.(js|css|png|jpg|jpeg|gif|svg|woff2?)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # index.html y archivos estáticos
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Política de cache para index.html (no cachear)
    location = /index.html {
        expires -1;
        add_header Cache-Control "public, must-revalidate";
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/splashmix.ink-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/splashmix.ink-0001/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = imagen.splashmix.ink) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    server_name imagen.splashmix.ink;
    listen 80;
    return 404; # managed by Certbot
}
