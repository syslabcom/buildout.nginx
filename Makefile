.PHONY: all

PYTHON ?= python3

all: .installed.cfg

bin/buildout: bin/pip requirements.txt
	./bin/pip install -IUr requirements.txt

bin/pip:
	$(PYTHON) -m venv .

.installed.cfg: bin/buildout buildout.cfg templates/nginx.conf templates/nginx_command
	./bin/buildout

.PHONY: start
start: .installed.cfg
	./bin/nginx

.PHONY: reload
reload: .installed.cfg
	./bin/nginx -s reload

.PHONY: quit
quit: .installed.cfg
	./bin/nginx -s quit

.PHONY: clean_venv
clean_venv:
	rm -rf bin lib* include share

.PHONY: clean
clean: clean_venv
