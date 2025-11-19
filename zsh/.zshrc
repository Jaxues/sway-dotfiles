# Enviorment Variables
export EDITOR="nvim"
export VISUAL=$EDITOR
export BROWSER="firefox"
export TERM="alacritty"


# Installing plugins

# Example how to source plugin with git and conditionals
# if [[ -f "plugins/pluginname/pluginname.zsh" ]]
# then
#				source "plugins/pluginname/pluginname.zsh"
#else
#				git clone "https://github.com/plugin" "plugins/pluginnamehere"
#fi

setopt auto_menu
setopt menu_complete


# Syntax highlighting
if [[ -f "plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]
then
				source "plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
				git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "plugins/zsh-syntax-highlighting"
				source "plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Dracula theme zsh-syntax-highlighting
if [[ -f "plugins/dracula_syntax/zsh-syntax-highlighting.sh" ]]
then
				source "plugins/dracula_syntax/zsh-syntax-highlighting.sh"
else
				git clone "https://github.com/dracula/zsh-syntax-highlighting.git" "plugins/dracula_syntax"
				source "plugins/dracula_syntax/zsh-syntax-highlighting.sh"
fi

# zsh improve vim mode
if [[ -f "plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]
then
				source "plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
else
				git clone "https://github.com/jeffreytse/zsh-vi-mode.git" "plugins/zsh-vi-mode"
				source "plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi


# Arch aliases
alias pacin="sudo pacman -S"
alias pacupd="sudo pacman -Syu"
alias pacrm="sudo pacman -R"
alias pacrma="sudo pacman -Rns"
alias pacln="sudo pacman -Sc"
alias paclr="sudo pacman -Scc"
alias pacorph="sudo pacman -Rs $(pacman -Qtdq)"

# Yay aliases
alias yayin="yay -S"
alias yayupd="yay -Syu"
alias yayrm="yay -R"
alias yayrma="yay -Rns"
alias yacln="yay -Sc"
alias yaclr="yay -Scc"

# Command Aliases
alias c="clear"
alias sd="shutdown now"
alias rb="reboot"
alias df="cd .dotfiles"

# Program aliases
alias nv="nvim"
alias sc="sc-im"

# Prompt
eval "$(starship init zsh)"
