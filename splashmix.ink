server {
	server_name splashmix.ink www.splashmix.ink api.splashmix.ink print.splashmix.ink;

    error_page 404 /404.html;

location = /404.html {
    root /var/www/splashmix.ink; # O donde sea que esté tu 404.html
    internal; # Esto es clave: evita el acceso directo
}

    location / {
	root /var/www/splashmix.ink;
	if ($host = print.splashmix.ink) {
	    rewrite ^/$ /print.html break;
	}
	index index.html;
    }

	location = /reddit {
	root /var/www/splashmix.ink;
	index reddit.html;
    }
  
    location = /login {
	return 301 https://app.splashmix.ink/login$is_args$args;
    }

    location = /buy {
	return 301 https://app.splashmix.ink/buy$is_args$args;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/splashmix.ink/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/splashmix.ink/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {   

    if ($host = api.splashmix.ink) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = www.splashmix.ink) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = splashmix.ink) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    server_name splashmix.ink www.splashmix.ink api.splashmix.ink;
    listen 80;
    return 404; # managed by Certbot

}
