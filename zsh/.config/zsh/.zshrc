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
export GOPATH="$XDG_DATA_HOME"/go
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export AIRPLANE_MODE="False"
export PATH="$HOME/.local/bin:$PATH"
export YSU_HARDCORE=1

# Vi keys
bindkey -v 
export KEYTIMEOUT=1
function vi-yank-wlcopy {
    zle vi-yank
   echo "$CUTBUFFER" | wl-copy -n
}

zle -N vi-yank-wlcopy
bindkey -M vicmd 'y' vi-yank-wlcopy
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
				rm $HOME/.config/zsh/plugins/zsh-syntax-highlighting/*.md
				source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Dracula theme zsh-syntax-highlighting
if [[ -f "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh" ]]
then
				source "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh"
else
				git clone "https://github.com/dracula/zsh-syntax-highlighting.git" "$HOME/.config/zsh/plugins/dracula_syntax"
				rm $HOME/.config/zsh/plugins/dracula_syntax/*.md
				rm  $HOME/.config/zsh/plugins/dracula_syntax/LICENSE
				rm  $HOME/.config/zsh/plugins/dracula_syntax/screenshot.png
				source "$HOME/.config/zsh/plugins/dracula_syntax/zsh-syntax-highlighting.sh"
fi


if [[ -f "$HOME/.config/zsh/plugins/you-should-use/zsh-you-should-use.plugin.zsh" ]]
then
				source "$HOME/.config/zsh/plugins/you-should-use/zsh-you-should-use.plugin.zsh"
else
				git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$HOME/.config/zsh/plugins/you-should-use/"
				source "$HOME/.config/zsh/plugins/you-should-use/zsh-you-should-use.plugin.zsh"
fi


# Arch aliases
alias pacin="sudo pacman -S"
alias pacupd="sudo pacman -Syu"
alias pacrm="sudo pacman -R"
alias pacrma="sudo pacman -Rns"
alias pacln="sudo pacman -Sc"
alias paclr="sudo pacman -Scc"
alias pacorph="sudo pacman -Rs $(pacman -Qtdq)"
alias paclist="pacman -Qte > $HOME/.dotfiles/pkglist.txt"
alias pacmir="sudo pacman -Sy"

# Yay aliases
alias yayin="yay -S"
alias yayupd="yay -Syu"
alias yayrm="yay -R"
alias yayrma="yay -Rns"
alias yacln="yay -Sc"
alias yaclr="yay -Scc"
alias yaylist="pacman -Qtem > $HOME/.dotfiles/foreign-pkglist.txt"


# Git aliaswa
alias ga="git add"
alias gah="git add ."
alias gaa="git add --all"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias glr="git pull -r=true"
alias gd="git diff"
alias guf="git ls-files --other"
alias gf="git ls-files"

# Command Aliases
alias c="clear"
alias sd="shutdown now"
alias rb="reboot"
alias ls="ls --color=auto"
alias prv="cd .."

# Program aliases
alias nv="nvim"
alias sc="sc-im"
alias nb="newsboat"
alias hf="hyfetch"
alias vw="cd $XDG_DOCUMENTS_DIR/vimwiki && nvim index.md"

alias temp="curl wttr.in"

# Python venv function 
function vrun { 
				if [[ -f "$PWD/$1/bin/activate" ]] then 
								source "$PWD/$1/bin/activate" 
				else 
								echo "No virtual enviorment named $1" 
				fi}
alias py="python"
alias mkv="python -m venv"

# Install python packages from textfile

# List all packages in requirements.txt

# Upgrade all packages
# Remove package

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
		eval "$(starship init zsh)"
  }
