ifndef APP
$(error APP is not set, run "make APP=<your app>")
endif

ifndef APP_VERSION
APP_VERSION = 1.0.0
endif

.PHONY: app clean

app clean:
	@$(MAKE) -C platforms/bk7231t/bk7231t_os APP_NAME=${APP} APP_VERSION=${APP_VERSION} -f application.mk -j --no-print-directory $@
