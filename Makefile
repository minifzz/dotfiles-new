all: powerline git tmux vim zsh

DOTFILES := $(shell pwd)

ifeq ($(shell uname),Darwin)
	FONTDIR := $(HOME)/Library/Fonts
else
	FONTDIR := $(HOME)/.fonts
endif

# one of the powerline files
POWER := $(FONTDIR)/PowerlineSymbols.otf

$(POWER):
	$(DOTFILES)/powerline-fonts/install.sh

powerline: $(POWER)

git:
	ln -nfs $(DOTFILES)/git/gitconfig ~/.gitconfig
	ln -nfs $(DOTFILES)/git/gitignore_global ~/.gitconfig_global

tmux:
	ln -nfs $(DOTFILES)/tmux.conf ~/.tmux.conf

VUNDLE := $(HOME)/.vim/bundle/Vundle.vim

$(VUNDLE):
	git clone https://github.com/gmarik/Vundle.vim.git $@

vundle: $(VUNDLE)

wakatime:
	ln -nfs $(DOTFILES)/wakatime.cfg ~/.wakatime.cfg

vimrc: vundle
	ln -nfs $(DOTFILES)/vimrc ~/.vimrc

vim: wakatime vimrc

OMZ := $(HOME)/.oh-my-zsh

$(OMZ):
	sh $(DOTFILES)/zsh/oh-my-zsh.sh

oh-my-zsh: $(OMZ)

zsh: oh-my-zsh
	ln -nfs $(DOTFILES)/zsh/oh-my-zsh.zshrc ~/.zshrc

