server {
    server_name targetvox.com www.targetvox.com api.targetvox.com;

    # Forzar www -> apex para que ORIGIN=https://targetvox.com siempre cuadre
    if ($host = www.targetvox.com) { return 301 https://targetvox.com$request_uri; }

    # El login/admin solo viven en admin.targetvox.com — en el apex no existen.
    location = /acceso { return 404; }
    location = /admin  { return 404; }

    # commerce-crm (SvelteKit adapter-node) bajo pm2 en :3100
    location / {
        proxy_pass http://127.0.0.1:3100;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/targetvox.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/targetvox.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 12M;
}

server {
    if ($host = www.targetvox.com) { return 301 https://targetvox.com$request_uri; } # managed by Certbot
    if ($host = api.targetvox.com) { return 301 https://$host$request_uri; } # managed by Certbot
    if ($host = targetvox.com)     { return 301 https://$host$request_uri; } # managed by Certbot
    listen 80;
    server_name targetvox.com www.targetvox.com api.targetvox.com;
    return 404; # managed by Certbot
}

# --- admin.targetvox.com: acceso de administración (HTTPS) ---
server {
    server_name admin.targetvox.com;

    # Raíz del subdominio: sin cookie de admin -> al login; con cookie -> la app.
    # (Chequeo de PRESENCIA del cookie; la validez la verifica la app.)
    location = / {
        if ($cookie_admin = "") {
            return 302 /acceso;
        }
        proxy_pass http://127.0.0.1:3100;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location / {
        proxy_pass http://127.0.0.1:3100;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/admin.targetvox.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/admin.targetvox.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 12M;
}

server {
    listen 80;
    server_name admin.targetvox.com;
    return 301 https://$host$request_uri;
}
