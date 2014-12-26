
USER=$(shell whoami)
SERVICE_PATH=/etc/systemd/system

all: main

init/uzbl-manager@%.service: init/uzbl-manager.service
	sed 's/<user>/$(USER)/g' $< > $@
init/uzbl-session@%.timer: init/uzbl-session.timer
	sed 's/<user>/$(USER)/g' $< > $@
init/uzbl-session-save@%.service: init/uzbl-session-save.service
	sed 's/<user>/$(USER)/g' $< > $@

@PHONY: service
service: uzbl-manager
	cp $< $(DESTDIR)/usr/local/bin

@PHONY: client
client: uzbl-session
	cp $< $(DESTDIR)/usr/local/bin

main: init/uzbl-manager@$(USER).service \
	init/uzbl-session-save@$(USER).service \
	init/uzbl-session@$(USER).timer

install: service client \
		$(wildcard init/uzbl-manager@*.service) \
		$(wildcard init/uzbl-session-save@*.service) \
		$(wildcard init/uzbl-session@*.timer)
	cp init/uzbl-manager@*.service $(SERVICE_PATH)
	cp init/uzbl-session-save@*.service $(SERVICE_PATH)
	cp init/uzbl-session@*.timer $(SERVICE_PATH)

uninstall:
	rm -f $(DESTDIR)/usr/local/bin/uzbl-manager
	rm -f $(DESTDIR)/usr/local/bin/uzbl-session
	rm -f $(SERVICE_PATH)/uzbl-manager@*.service
	rm -f $(SERVICE_PATH)/uzbl-session-save@*.service
	rm -f $(SERVICE_PATH)/init/uzbl-session@*.timer

clean:
	rm -f init/uzbl-manager@*.service
	rm -f init/uzbl-session-save@*.service
	rm -f init/uzbl-session@*.timer
