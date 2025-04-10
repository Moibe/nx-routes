server {
    server_name powerlineup.io www.powerlineup.io;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/powerlineup.io/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/powerlineup.io/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.powerlineup.io) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = powerlineup.io) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name powerlineup.io www.powerlineup.io;
    return 404; # managed by Certbot




}