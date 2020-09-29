# TODO: this make needs to be updated
all: powerline vim

DOTFILES := $(shell pwd)

ifeq ($(shell uname),Darwin)
	FONTDIR := $(HOME)/Library/Fonts
else
	FONTDIR := $(HOME)/.fonts
endif

brew: 
	$(DOTFILES)/brew.sh

# one of the powerline files
POWER := $(FONTDIR)/PowerlineSymbols.otf

$(POWER):
	$(DOTFILES)/powerline-fonts/install.sh

powerline: $(POWER)

VUNDLE := $(HOME)/.vim/bundle/Vundle.vim

$(VUNDLE):
	git clone https://github.com/gmarik/Vundle.vim.git $@

vundle: $(VUNDLE)

ifeq (,$(wildcard ~/.vimrc))
	VIMRC := mv ~/.vimrc ~/.vimrc.copy && touch ~/.vimrc && echo "source $(DOTFILES)/vimrc" >> ~/.vimrc
else:
	VIMRC := touch ~/.vimrc && echo "source $(DOTFILES)/vimrc" >> ~/.vimrc
endif

vimrc: $(VIMRC)

vim: vundle vimrc

$(OHMYZSH): /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ohmyzsh: $(OHMYZSH)

zsh: ohmyzsh
	cat $(DOTFILES)/my.zshrc >> ~/.zshrc
