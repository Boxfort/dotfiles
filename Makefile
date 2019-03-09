.DEFAULT_GOAL:=install

PACKAGES=$(sort $(dir $(wildcard */)))

NO_COLOR=\033[0m
GREEN=\033[0;32m
RED=\033[0;31m
BLUE=\033[0;34m

.PHONY: install install-packages uninstall update pull test

.install-packages:
	@echo "Installing packages..."
	@sudo apt -y install curl wget zsh python3 python3-pip htop neofetch neovim build-essential cmake python3-dev rxvt-unicode

	@sudo update-alternatives --set x-terminal-emulator $(which urxvt)

	@pip3 install neovim
	@curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@echo "Installing oh-my-zsh"
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | true
	@echo "Changing default shell to zsh"
	@chsh -s $$(which zsh)
	@rm ~/.zshrc

	@echo "Installing Rust"
	@sudo curl https://sh.rustup.rs -sSf | sh

.uninstall-packages:
	@echo "Uninstalling oh-my-zsh"
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/uninstall.sh)" | true

	@echo "Uninstalling Rust"
	@rustup self uninstall

	@echo "Removing config"
	@pip3 uninstall neovim

	@echo "Removing unused packages..."
	@sudo apt -y autoremove

.pull:
	@echo "Updating..."
	@git pull

install:
	@echo "Applying config"
	# When zsh installs it creates .zshrc which will make stow unhappy. Delete it.
	@stow -t ~ $(PACKAGES)
	@xrdb ~/.Xresources
	@$(call cecho, $(GREEN),All Done! You may need to restart.)

install-full: .install-packages install
uninstall-full: .uninstall-packages uninstall

uninstall:
	@stow -Dt ~ $(PACAKGES)

update: .pull install

# colour echo, because i'm a sucker for aesthetics.
define cecho
	echo "$(1)$(2)$(NO_COLOR)"
endef
