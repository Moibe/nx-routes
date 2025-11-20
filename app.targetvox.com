server {
    server_name app.targetvox.com;

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
        proxy_intercept_errors on;
    }

error_page 404 /404.html;

location = /404.html {
    root /var/www/splashmix-login-dev; # O donde sea que esté tu 404.html
    internal; # Esto es clave: evita el acceso directo
}

   location = /buy {
    root /var/www/splashmix-buy-dev;
    try_files /index.html =404;
}

 location = /test {
    root /var/www/splashmix-buy-dev;
    try_files /tablaglass.html =404;
}

   location = /login {
    root /var/www/splashmix-login-dev;
    try_files /login.html =404;
}

location = /logout {
        # Realiza una redirección EXTERNA (302 Found) al navegador
        # El navegador entonces solicita /login?logout=true
        return 302 /login?logout=true;
    }

location = /index.css {
    root /var/www/splashmix-login-dev;
}

location = /environment.js {
    root /var/www/splashmix-login-dev;
}

location = /auth_login.js {
    root /var/www/splashmix-login-dev;
}

location = /table_generator.js {
    root /var/www/splashmix-buy-dev;
}

location = /firestore_db.js {
    root /var/www/splashmix-buy-dev;
}

location = /visit_tracker.js {
    root /var/www/splashmix-buy-dev;
}

location = /tablaglass.html {
    root /var/www/splashmix-buy-dev;
}

location = /main.js {
    root /var/www/splashmix-buy-dev;
}

location = /styles.css {
    root /var/www/splashmix-buy-dev;
}

location = /loader_login.js {
    root /var/www/splashmix-login-dev;
}

location = /loader_buy.js {
    root /var/www/splashmix-buy-dev;
}

location = /config_dev.js {
    root /var/www/splashmix-login-dev;
}

location = /config_prod.js {
    root /var/www/splashmix-login-dev;
}

location = /buy_config_dev.js {
    root /var/www/splashmix-buy-dev;
}

location = /buy_config_prod.js {
    root /var/www/splashmix-buy-dev;
}

location = /link.js {
    root /var/www/splashmix-login-dev;
}

location = /tabulador.js {
    root /var/www/splashmix-buy-dev;
}

location = /cards.js {
    root /var/www/splashmix-buy-dev;
}

location = /api.js {
    root /var/www/splashmix-buy-dev;
}

location = /ambiente.js {
    root /var/www/splashmix-buy-dev;
}

location = /precios.js {
    root /var/www/splashmix-buy-dev;
}

location = /tablas_precio.js {
    root /var/www/splashmix-buy-dev;
}

location = /auth_buy.js {
    root /var/www/splashmix-buy-dev;
}

location = /style.css {
    root /var/www/splashmix-buy-dev;
}

location = /config.js {
    root /var/www/splashmix-buy-dev;
}

location = /faqs.html {
    root /var/www/splashmix-buy-dev;
}

location = /policy.html {
    root /var/www/splashmix-buy-dev;
}

location = /contacto.html {
    root /var/www/splashmix-buy-dev;
}

location = /link_manager.js {
    root /var/www/splashmix-buy-dev;
}

location = /gtm-loader.js {
    root /var/www/splashmix-buy-dev;
}

location /imagenes/ {
    root /var/www/splashmix-buy-dev;
    try_files $uri $uri/ =404;
}
    
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/app.targetvox.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/app.targetvox.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
    client_max_body_size 10M;

}

server {   

    if ($host = app.targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot
    
    server_name app.targetvox.com;
    listen 80;
    return 404; # managed by Certbot

}
