# Makefile for Modular i3wm configuration

config-include = $(wildcard include/*)
config-desktop = desktop.conf
config-laptop  = laptop.conf

desktop: $(config-include) $(config-desktop)
	cat desktop.conf $(config-include)  > config-desktop.i3

laptop: $(config-include) $(config-laptop)
	cat laptop.conf $(config-include) > config-laptop.i3

clean:
	rm -f config-laptop.i3
	rm -f config-desktop.i3


.phony: clean
