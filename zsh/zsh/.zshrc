# XDG Configs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOADS_DIR="$HOME/Downloads"

# Enviorment Variables
export EDITOR="nvim"
export VISUAL=$EDITOR
export BROWSER="firefox"
export TERM="alacritty"


# Vi keys
bindkey -v 

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
if [[ -f "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]
then
				source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
				git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
				source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Dracula theme zsh-syntax-highlighting
if [[ -f "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh" ]]
then
				source "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh"
else
				git clone "https://github.com/dracula/zsh-syntax-highlighting.git" "$HOME/.config/zsh/plugins/dracula_syntax"
				source "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh"
fi

# Arch aliases
alias pacin="sudo pacman -S"
alias pacupd="sudo pacman -Syu"
alias pacrm="sudo pacman -R"
alias pacrma="sudo pacman -Rns"
alias pacln="sudo pacman -Sc"
alias paclr="sudo pacman -Scc"
alias pacorph="sudo pacman -Rs $(pacman -Qtdq)"
alias paclist="pacman -Qte"

# Yay aliases
alias yayin="yay -S"
alias yayupd="yay -Syu"
alias yayrm="yay -R"
alias yayrma="yay -Rns"
alias yacln="yay -Sc"
alias yaclr="yay -Scc"
alias yaylist="pacman -Qtem"

# Command Aliases
alias c="clear"
alias sd="shutdown now"
alias rb="reboot"
alias df="cd .dotfiles"
alias ls="ls --color=auto"

# Program aliases
alias nv="nvim"
alias sc="sc-im"
alias nb="newsboat"
alias hf="hyfetch"


# Prompt
eval "$(starship init zsh)"
