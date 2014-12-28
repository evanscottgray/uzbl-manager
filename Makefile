
SERVICE_PATH=/etc/systemd/user

all:

$(SERVICE_PATH)/uzbl-session-save.service: init/uzbl-session-save.service
	cp $< $@

$(SERVICE_PATH)/uzbl-session-save.timer: init/uzbl-session-save.timer
	cp $< $@

$(SERVICE_PATH)/uzbl-manager.service: init/uzbl-manager.service
	cp $< $@

$(DESTDIR)/usr/local/bin/uzbl-manager: uzbl-manager
	cp $< $@

$(DESTDIR)/usr/local/bin/uzbl-session: uzbl-session
	cp $< $@

@PHONY: install
install: \
	$(SERVICE_PATH)/uzbl-session-save.service \
	$(SERVICE_PATH)/uzbl-session-save.timer \
	$(SERVICE_PATH)/uzbl-manager.service \
	$(DESTDIR)/usr/local/bin/uzbl-manager \
	$(DESTDIR)/usr/local/bin/uzbl-session

@PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)/usr/local/bin/uzbl-manager
	rm -f $(DESTDIR)/usr/local/bin/uzbl-session
	rm -f $(SERVICE_PATH)/uzbl-manager.service
	rm -f $(SERVICE_PATH)/uzbl-session-save.service
	rm -f $(SERVICE_PATH)/uzbl-session-save.timer

clean:
