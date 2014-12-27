
SERVICE_PATH=/etc/systemd/user

all:

@PHONY: install
install:
	cp uzbl-session $(DESTDIR)/usr/local/bin
	cp uzbl-manager $(DESTDIR)/usr/local/bin
	cp init/uzbl-manager.service $(SERVICE_PATH)
	cp init/uzbl-session-save.service $(SERVICE_PATH)
	cp init/uzbl-session-save.timer $(SERVICE_PATH)

@PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)/usr/local/bin/uzbl-manager
	rm -f $(DESTDIR)/usr/local/bin/uzbl-session
	rm -f $(SERVICE_PATH)/uzbl-manager.service
	rm -f $(SERVICE_PATH)/uzbl-session-save.service
	rm -f $(SERVICE_PATH)/init/uzbl-session.timer

clean:
