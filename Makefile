
SERVICE_FILE=/etc/systemd/user/uzbl-manager.service

all:
	@echo > /dev/null

$(SERVICE_FILE): uzbl-manager.service service
	cp $< $@

@PHONY: service
service: uzbl-manager
	cp $< $(DESTDIR)/usr/local/bin

@PHONY: client
client: uzbl-session
	cp $< $(DESTDIR)/usr/local/bin

install: service $(SERVICE_FILE) client

uninstall:
	rm -f $(DESTDIR)/usr/local/bin/uzbl-manager
	rm -f $(DESTDIR)/usr/local/bin/uzbl-session
	rm -f $(SERVICE_FILE)

clean:
	@echo > /dev/null
