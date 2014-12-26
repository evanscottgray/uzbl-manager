uzbl-manager
============

For when you want to be able to shut down your computer without worrying about
your browser tabs.

uzbl-manager is a bash daemon which communicates with uzbl instances to save and
restore state contained in named sessions. It replaces uzbl-browser.

Why?
----

I don't know, I just wanted uzbl to remember my windows and wrote a quick script
to do it. It blew up into this.

Installation
------------

On systems with systemd, run `sudo make install`. Otherwise just configure
uzbl-manager to run as the user on boot. It's somewhat important that it runs as
the user, since the socket used to communicate is only writable by the user.

Usage
-----

Using the systemd services, enable/start `uzbl-manager@<username>`. To control
the process, use `uzbl-session` (see `uzbl-session --help`). Alternatively,
run uzbl-manager in the background.

To request a new browser window, run `uzbl-session spawn` (See the
`session_spawn` function). uzbl-manager replaces uzbl-browser (maintains its own
uzbl-event-manager) so we have to request it for a new window.

Sessions themselves can be controlled with `uzbl-session {save,restore,kill}
[-s SESSION]`. The last saved/restored session is remembered for the next
command. If no session is specified, a timestamped file is used.

Configuration
-------------

Edit the script. It's really simple, all the important stuff is up top.
