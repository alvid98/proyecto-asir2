# Ensure that Apache listens on port 80
Listen 80
<VirtualHost *:80>
    DocumentRoot @
    ServerName www.dominio.com
    <Directory @>
            Require all granted
    </Directory>

    # Other directives here
</VirtualHost>
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
