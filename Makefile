DEVDIR = ~/Dev/

all: devdir link

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

devdir: $(DEVDIR)
$(DEVDIR):
	mkdir -p $@

clean:
	rm -f ~/.gitconfig

.PHONY: all link devdir clean

