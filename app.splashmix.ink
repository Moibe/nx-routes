server {
    server_name app.splashmix.ink;

    location / {
	root /var/www/splashmix-login;
        index login.html;
    }

    location /aplicacion/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7800/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
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
