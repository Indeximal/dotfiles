DEVDIR = ~/Dev/
VENVDIR = ~/venvdir/

all: clean devdir venvdir link

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	mkdir -p ~/.gdfuse/default
	[ -f ~/.gdfuse/default/config ] || ln -s $(PWD)/gdriveconfig ~/.gdfuse/default/config
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish_functions ~/.config/fish/functions


$(DEVDIR) $(VENVDIR):
	mkdir -p $@
devdir: $(DEVDIR)
venvdir: $(VENVDIR)

clean:
	rm -f ~/.gitconfig
	rm -f ~/.gdfuse/default/config
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions

.PHONY: all link devdir clean

