# Makefile for Modular i3wm configuration

config-include = $(wildcard include/*)
config-desktop = desktop.conf

desktop: $(config-include) $(config-desktop)
	cat desktop.conf include/general.conf \
		include/startup-basic.conf include/keybinds-basic.conf \
		> config-desktop.i3
	mv config-desktop.i3 ~/.i3/config

