
XDG_DATA_HOME ?= $(HOME)/.local/share
SCRIPT_DIR=${XDG_DATA_HOME}/uzbl/scripts/session-manager
ifeq ($(strip $(DESTDIR)),)
	EXECUTABLE=/usr/local/bin/browser-session
else
	EXECUTABLE=$(DESTDIR)/bin/browser-session
endif
SERVICE=/lib/systemd/system/browser-session@$(shell whoami).service

all:
	@echo > /dev/null

${SCRIPT_DIR}: session_defines session-client.sh uzbl-session uzbl-session-dmenu browser-session.service
	mkdir -p ${SCRIPT_DIR} >/dev/null 2>&1
	cp ${^} ${SCRIPT_DIR}

${SERVICE}: browser-session.service ${EXECUTABLE}
	-sudo rm $@
	sudo cp $< $@

${EXECUTABLE}: uzbl-session-dmenu
	-unlink $@
	ln -s ${SCRIPT_DIR}/$^ $@

install: ${SCRIPT_DIR} ${SERVICE}

uninstall:
	rm ${EXECUTABLE}
	sudo rm ${SERVICE}
	rm -rf ${SCRIPT_DIR}
