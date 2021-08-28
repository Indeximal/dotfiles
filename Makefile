DEVDIR = ~/Dev/
VENVDIR = ~/venvdir/

all: clean devdir venvdir link chshell

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	mkdir -p ~/.gdfuse/default
	[ -f ~/.gdfuse/default/config ] || ln -s $(PWD)/gdriveconfig ~/.gdfuse/default/config
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish_functions ~/.config/fish/functions


$(DEVDIR) $(VENVDIR):
	mkdir -p $@
devdir: $(DEVDIR)
venvdir: $(VENVDIR)

chshell:
	chsh -s /usr/bin/fish

clean:
	rm -f ~/.gitconfig
	rm -f ~/.vimrc
	rm -f ~/.gdfuse/default/config
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions

.PHONY: all link devdir clean

