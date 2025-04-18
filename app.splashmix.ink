server {
    server_name app.splashmix.ink;

    location /login123/ {
	root /var/www/splashmix-login;
        index login.html;
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
