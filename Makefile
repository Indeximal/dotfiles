DEVDIR = ~/Dev/

all: clean devdir link

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	mkdir -p ~/.gdfuse/default
	[ -f ~/.gdfuse/default/config/default/config ] || ln -s $(PWD)/gdriveconfig ~/.gdfuse/default/config

devdir: $(DEVDIR)
$(DEVDIR):
	mkdir -p $@

clean:
	rm -f ~/.gitconfig
	rm -f ~/.gdfuse/default/config

.PHONY: all link devdir clean

