server {
    server_name targetvox.com www.targetvox.com;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
	}
    location /astroblend/ {  # Change this if you'd like to server your Gradio app on a different path
        proxy_pass http://127.0.0.1:7877/; # Change this if your Gradio app will be running on a different port
        proxy_buffering off;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    }


    


server {      
    listen 80;
    server_name targetvox.com www.targetvox.com;
    }
