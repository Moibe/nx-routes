server {
    listen 80;
    server_name targetvox.com www.targetvox.com;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }
}
