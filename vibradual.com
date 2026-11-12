server {
	server_name vibradual.com www.vibradual.com api.vibradual.com print.vibradual.com;

    error_page 404 /404.html;

location = /404.html {
    root /var/www/splashmix.ink; # O donde sea que esté tu 404.html
    internal; # Esto es clave: evita el acceso directo
}

    location /images/ {
        root /var/www/splashmix.ink;
    }

    location / {
	root /var/www/splashmix.ink;
	
	if ($host = print.vibradual.com) {
	    rewrite ^/$ /print.html break;
	}

	try_files $uri $uri/ @print;
	index index.html;
    }

    location @print {
	if ($host = print.vibradual.com) {
	    rewrite ^.*$ /print.html last;
	}
	return 404;
    }

	location = /nu_index {
	root /var/www/splashmix.ink;
	index nu_index.html;
    }

	location = /reddit {
	root /var/www/splashmix.ink;
	index reddit.html;
    }	
  
    location = /login {
	return 301 https://app.vibradual.com/login$is_args$args;
    }

    location = /buy {
	return 301 https://app.vibradual.com/buy$is_args$args;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/vibradual.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/vibradual.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {   

    if ($host = api.vibradual.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = www.vibradual.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = vibradual.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    if ($host = print.vibradual.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    server_name vibradual.com www.vibradual.com api.vibradual.com print.vibradual.com;
    listen 80;
    return 404; # managed by Certbot

}
