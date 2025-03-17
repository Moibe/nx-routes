server {
    server_name targetvox.com www.targetvox.com;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/targetvox.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/targetvox.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = targetvox.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name targetvox.com www.targetvox.com;
    return 404; # managed by Certbot




}