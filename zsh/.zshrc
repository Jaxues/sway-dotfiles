# Enviorment Variables
export EDITOR="nvim"
export VISUAL=$EDITOR
export BROWSER="firefox"
export TERM="alacritty"

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


# Program aliases
alias nv="nvim"


# Prompt
eval "$(starship init zsh)"
