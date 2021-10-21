export PATH=${PATH}:/usr/local/bin/:/Users/kboucher/Development/apache-maven-3.6.0/bin:/Users/kboucher/Development/repos/idauto/rapididentity-ui/node_modules/phantomjs-prebuilt/lib/phantom/bin
export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
export NODE_OPTIONS=--max_old_space_size=4096

############
# Set limits
############
# sudo launchctl limit maxfiles 65536 200000

############
# Functions
############

# Creates a BitBucket PR for the currrent repo
# Must pass the branch to merge
# Branch to merge into is optional (defaults to develop)
# Examples:
#   `pr issues/RID-1234` (creates PR to merge issues/RID-1234 into develop)
#   `pr issues/RID-1234 master` (creates PR to merge issues/RID-1234 into master)
pr() {
    title="$(git log -1 --pretty=%B | head -n 1)"
    description="$(git log -1 --pretty=%B | tail -n+3)"
    stash pull-request "$1" ${2:-develop} --title="$title" --description="$description " @KHerod @WChandler @ZOakes @dbrown
}

sq() {
    git rebase -i HEAD~"$1"
}

############
# Aliases
############

# Development
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"
alias es="ember serve"
alias ets="ember test -s"
alias exs="ember exam --split=8 --parallel --test-port=0 --silent --server"
alias nombom="rm -rf node_modules bower_components && npm i && bower i"
alias ep="nombom && rm -rf dist tmp"
alias glc="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias awsrid2="ssh -i '~/.ssh/engineering.pem' ec2-user@10.100.1.50"
alias awsrid="ssh -i '~/.ssh/engineering.pem' ec2-user@10.100.1.213"
alias awsbhodge="ssh -i '~/.ssh/engineering.pem' ec2-user@10.100.110.249"
alias awscicd="ssh -i '~/.ssh/gitlab_runners' ec2-user@172.21.8.241"
alias awsnx="ssh -i '~/.ssh/aws-idauto-prod.pem' centos@10.0.201.98"
alias awsdocker="ssh -i '~/.ssh/engineering.pem' ec2-user@10.100.1.133"
alias newember="sh ~/Development/repos/kboucher/ember-setup-project/ember-project-bootstrapper.sh"

# Locations
alias kbcom="cd ~/Development/repos/kbcom"
alias repos="cd ~/Development/repos"
alias ridui="cd ~/Development/repos/idauto/rapididentity-ui"
alias rid="cd ~/Development/repos/idauto"

# Terminal
alias ls="colorls -h --group-directories-first -1"
alias l="colorls --group-directories-first --almost-all"
alias ll="colorls -h --group-directories-first --almost-all --long"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Library/Ruby/Gems/2.6.0/gems/colorls-1.4.1/lib/tab_complete.sh
