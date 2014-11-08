if [[ `uname` == 'Darwin' ]]; then
    # MacOS
    font_dir="$HOME/Library/Fonts"
else
    # Linux
    font_dir="$HOME/.fonts"
fi

[[ ! -d "$font_dir" || -z "$(ls $font_dir | grep -i powerline)" ]] && \
  echo "Installing Powerline Font" && ~/.dotfiles/powerline-fonts/install.sh

vundle="$HOME/.vim/bundle/Vundle.vim"
[[ ! -d $vundle ]] && echo "download vundle" && \
  git clone https://github.com/gmarik/Vundle.vim.git $vundle

oh_my_zsh="$HOME/.oh-my-zsh"
[[ ! -d $oh_my_zsh ]] && echo "download oh-my-zsh" && \
  (curl -L http://install.ohmyz.sh | sh)

ln -nfs ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -nfs ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -nfs ~/.dotfiles/vimrc ~/.vimrc
ln -nfs ~/.dotfiles/wakatime.cfg ~/.wakatime.cfg
