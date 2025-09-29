# Activate Starship prompt
eval "$(starship init zsh)"

# Activate plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Useful alias
alias ll="ls -lh"
alias la="ls -lha"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# Dev tools
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dn="dotnet new"
alias dr="dotnet run"

# Better history
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups sharehistory

# Automatic commands corrections
setopt correct

