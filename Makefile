user:
	./create_user.sh
	
essentials:
	./install_essentials.sh
	
	
all: essentials

.PHONY: user essentials all