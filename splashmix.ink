server {
    server_name splashmix.ink www.splashmix.ink api.splashmix.ink;

    location / {
	root /var/www/splashmix.ink;
        index index.html;
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
