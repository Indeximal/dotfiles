link:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

clean:
	rm -f ~/.gitconfig
	
essentials: link
	./install_essentials.sh
	
	
all: essentials

.PHONY: essentials all link clean