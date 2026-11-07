# nx-routes: ruta de opensimcard.com → app SvelteKit en 127.0.0.1:5390 (pm2).
# Copia/renombra este archivo a <nx-routes>/opensimcard.com (nombre EXACTO = el dominio).
#
# Las líneas "# managed by Certbot" las gestiona certbot al correr en el droplet:
#     sudo certbot --nginx -d opensimcard.com -d www.opensimcard.com
# (apex + www en el MISMO comando: un solo cert cubre ambos)
# Si nginx se queja de que el cert aún no existe (primer deploy del dominio):
#   1) obtén el cert primero:  sudo certbot certonly --nginx -d opensimcard.com -d www.opensimcard.com
#   2) crea el symlink + reload (ver checklist).

server {
    server_name opensimcard.com www.opensimcard.com;

    location / {
        proxy_pass http://127.0.0.1:5390;
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
    ssl_certificate /etc/letsencrypt/live/opensimcard.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/opensimcard.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 12M;
}

server {
    if ($host = www.opensimcard.com) { return 301 https://opensimcard.com$request_uri; } # managed by Certbot
    if ($host = opensimcard.com) { return 301 https://$host$request_uri; } # managed by Certbot
    listen 80;
    server_name opensimcard.com www.opensimcard.com;
    return 404; # managed by Certbot
}
