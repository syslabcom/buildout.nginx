.PHONY: all

PYTHON ?= python3

all: .installed.cfg

buildout.cfg:
	[ test -f buildout.cfg ] || \
		echo '[buildout]' > buildout.cfg; \
		echo 'extends =' >> buildout.cfg; \
		echo '    config/base.cfg' >> buildout.cfg; \
		echo '    custom.cfg' >> buildout.cfg; \
	touch custom.cfg

.venv/bin/buildout: .venv/bin/pip requirements.txt
	./.venv/bin/pip install -IUr requirements.txt

.venv/bin/pip:
	$(PYTHON) -m venv .venv

.installed.cfg: .venv/bin/buildout buildout.cfg custom.cfg config/base.cfg templates/nginx.conf templates/nginx_command
	./.venv/bin/buildout

.PHONY: start
start: .installed.cfg
	./bin/nginx

.PHONY: reload
reload: .installed.cfg
	./bin/nginx -t && ./bin/nginx -s reload

.PHONY: quit
quit: .installed.cfg
	./bin/nginx -s quit

.PHONY: clean_venv
clean_venv:
	rm -rf .venv

.PHONY: clean
clean: clean_venv
