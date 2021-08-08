DEVDIR = ~/dev/

link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

clean:
	rm -f ~/.gitconfig
	
essentials: devdir link
	./install_essentials.sh
	
devdir: $(DEVDIR)
$(DEVDIR):
	mkdir -p $@
	
	
	
all: essentials

.PHONY: essentials all link clean