server {
    listen 80;
    server_name powerlineup.io www.powerlineup.io;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }
}
