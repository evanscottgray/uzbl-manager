
SERVICE_DIR=/etc/systemd/system
SERVICES=$(patsubst browser-session@%.service,$(SERVICE_DIR)/browser-session@%.service,$(wildcard browser-session@*.service))

all:
	cp browser-session.service browser-session@$(shell whoami).service

$(SERVICE_DIR)/browser-session@%.service: browser-session@%.service executable
	cp $< $@

@PHONY: executable
executable: uzbl-session-manager
	cp $< $(DESTDIR)/usr/local/bin

install: executable $(SERVICES)

uninstall:
	rm -f $(DESTDIR)/usr/local/bin/uzbl-session-manager
	rm -f $(SERVICE_DIR)/browser-session@*.service

clean:
	rm -f browser-session@*.service
