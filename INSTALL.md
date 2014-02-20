
* git clone into /u/apps/
* install freeTDS `yum install freetds-devel`
* `cd /u/apps/jackalope`
* `bundle`
* edit /etc/httpd/conf/httpd.conf like so ...


```
NameVirtualHost *:80

LoadModule passenger_module /usr/local/lib/ruby/gems/2.0.0/gems/passenger-4.0.37/buildout/apache2/mod_passenger.so
<IfModule mod_passenger.c>
  PassengerRoot /usr/local/lib/ruby/gems/2.0.0/gems/passenger-4.0.37
  PassengerDefaultRuby /usr/local/bin/ruby
</IfModule>



RackEnv production

<VirtualHost *:80>
  ServerName sfo-lemur01.int.plos.org
  DocumentRoot /u/apps/lemur/public
  <Directory /u/apps/lemur/public>
    # This relaxes Apache security settings.
    AllowOverride all
    # MultiViews must be turned off.
    Options -MultiViews
  </Directory>

  Alias /jackalope /u/apps/jackalope/app/public
  <Location /jackalope>
        PassengerBaseURI /jackalope
        PassengerAppRoot /u/apps/jackalope/app
    </Location>
    <Directory /u/apps/jackalope/app/public>
        Allow from all
        Options -MultiViews
    </Directory>
</VirtualHost>
```
* ensure /u/apps/ is owned by non-root
* service http restart