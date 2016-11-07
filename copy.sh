 #!/bin/bash

DOT_FILES=(.zshrc .tmux.conf .emacs.d/init.el .emacs.d/conf/org.el)

for file in ${DOT_FILES[@]}
do
     ln -sf $HOME/util/dotfiles/$file $HOME/$file
done
