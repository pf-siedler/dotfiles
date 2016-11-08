 #!/bin/bash

DOT_FILES=(.zshrc .tmux.conf .emacs.d/init.el .emacs.d/conf/org.el .emacs.d/conf/interface.el)

for file in ${DOT_FILES[@]}
do
     ln -s $HOME/dotfiles/$file $HOME/$file
done
