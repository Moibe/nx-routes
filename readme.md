A que apps apunta cada dominio existente.
Cada dominio y cada subdominio tendrán un archivo que apunta hacia su app correspondiente.

path: /etc/nginx/sites-available

template:

server {
    server_name splashmix.ink app.splashmix.ink;
    location / {
	root /usr/share/nginx/html;
	index dualvibe.com.html;
    }
}

y no olvidar agregar el enlace simbólico: 
Estándo en sites-enabled:
ln -s /etc/nginx/sites-available/otrodominio.com otrodominio.com
Una vez agregado debes hacer reload así: systemctl reload nginx
