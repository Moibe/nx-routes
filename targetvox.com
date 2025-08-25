server {
	server_name targetvox.com www.targetvox.com api.targetvox.com;

    error_page 404 /404.html;

location = /404.html {
    root /var/www/targetvox.com; # O donde sea que esté tu 404.html
    internal; # Esto es clave: evita el acceso directo
}

    location / {
	root /var/www/splashmix.ink;
	index index.html;
    }
  
    location = /login {
	return 301 https://app.targetvox.com/login$is_args$args;
    }

    location = /buy {
	return 301 https://app.targetvox.com/buy$is_args$args;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/targetvox.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/targetvox.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {   

    if ($host = api.targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = www.targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name targetvox.com www.targetvox.com api.targetvox.com;
    listen 80;
    return 404; # managed by Certbot

}
