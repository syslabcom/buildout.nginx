# Package description
This is a proof of concept for a buildout that installs a local nginx that can run on an unprivileged port and that can easily be configured by adding some nginx conf snippets in a local folder.

## Basic usage
To get started run:
```
make && make start
```

Then you can browse to your local nginx: http://0.0.0.0:8080/.

You can optionally place additional configuration files in the `etc/conf.d` and then run `make reload` like in this example:
```
[ale@emily buildout.nginx]$ curl -sI 127.0.0.1:8080/README.md|grep HTTP
HTTP/1.1 404 Not Found
[ale@emily buildout.nginx]$ cat > etc/conf.d/foo << EOF
> server {
>     listen 8080;
>     server_name 127.0.0.1;
>     root $PWD;
> }
> EOF
[ale@emily buildout.nginx]$ make reload
./bin/nginx -s reload
[ale@emily buildout.nginx]$ curl -sI 127.0.0.1:8080/README.md|grep HTTP
HTTP/1.1 200 OK
```
