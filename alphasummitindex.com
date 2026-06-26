# nx-routes: ruta de alphasummitindex.com → app SvelteKit en 127.0.0.1:3200 (pm2).
# El nombre de ESTE archivo debe ser EXACTAMENTE el dominio: alphasummitindex.com
#
# Las líneas "# managed by Certbot" las gestiona certbot al correr en el droplet:
#     sudo certbot --nginx -d alphasummitindex.com
# Si nginx se queja de que el cert aún no existe (primer deploy del dominio):
#   1) obtén el cert primero:  sudo certbot certonly --nginx -d alphasummitindex.com
#   2) crea el symlink + reload (ver checklist de la skill).
# (Para un dominio apex con www, agrega "www.alphasummitindex.com" a server_name + su redirect.)

server {
    server_name alphasummitindex.com;

    location / {
        proxy_pass http://127.0.0.1:3200;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $host;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/alphasummitindex.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/alphasummitindex.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 12M;
}

server {
    if ($host = alphasummitindex.com) { return 301 https://$host$request_uri; } # managed by Certbot
    listen 80;
    server_name alphasummitindex.com;
    return 404; # managed by Certbot
}
