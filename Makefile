DEVDIR = ~/Dev/
VENVDIR = ~/venvdir/

all: clean devdir venvdir link

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	mkdir -p ~/.gdfuse/default
	[ -f ~/.gdfuse/default/config/default/config ] || ln -s $(PWD)/gdriveconfig ~/.gdfuse/default/config

$(DEVDIR) $(VENVDIR):
	mkdir -p $@
devdir: $(DEVDIR)
venvdir: $(VENVDIR)

clean:
	rm -f ~/.gitconfig
	rm -f ~/.gdfuse/default/config

.PHONY: all link devdir clean

