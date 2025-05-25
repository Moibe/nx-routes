A que apps apunta cada dominio existente.

path: /etc/nginx/sites-available

template:

server {
    server_name splashmix.ink www.splashmix.io;

    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }
}
