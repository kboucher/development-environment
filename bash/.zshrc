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

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Creates a BitBucket PR for the currrent repo
# Must pass the branch to merge
# Branch to merge into is optional (defaults to develop)
# Examples:
#   `pr issues/RID-1234` (creates PR to merge issues/RID-1234 into develop)
#   `pr issues/RID-1234 master` (creates PR to merge issues/RID-1234 into master)
pr() {
    title="$(git log -1 --pretty=%B | head -n 1)"
    description="$(git log -1 --pretty=%B | tail -n+3)"
    stash pull-request "$1" ${2:-develop} --title="$title" --description="$description" @KHerod @WChandler @ZOakes @dbrown
}

sq() {
    git rebase -i HEAD~"$1"
}

lintFixStaged() {
    STAGED_JS="$(find app config lib mirage tests -name '*.js' | xargs git diff --diff-filter=d --cached --name-only)"

    for FILE in $STAGED_JS
    do
        echo $FILE
        ./node_modules/.bin/eslint $FILE --fix
    done
}

############
# Aliases
############

# Development
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"
alias ember="./node_modules/.bin/ember"
alias eslint="./node_modules/.bin/eslint"
alias template-lint="./node_modules/.bin/ember-template-lint"
alias stylelint="./node_modules/.bin/stylelint"
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
alias link-components="npm link @identity-automation/rapididentity-ui-components"

# Locations
alias idh="cd ~/Development/repos/idauto/gitlab/idhub-ui"
alias kbcom="cd ~/Development/repos/kbcom"
alias repos="cd ~/Development/repos"
alias ridui="cd ~/Development/repos/idauto/rapididentity-ui"

# Terminal
alias ls="colorls -h --group-directories-first -1"
alias l="colorls --group-directories-first --almost-all"
alias ll="colorls -h --group-directories-first --almost-all --long"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_PROMPT_ORDER=(
#   time          # Time stamps section
#   user          # Username section
  dir           # Current directory section
#   host          # Hostname section
  git           # Git section (git_branch + git_status)
#   hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
#   gradle        # Gradle section
#   maven         # Maven section
  node          # Node.js section
#   ruby          # Ruby section
#   elixir        # Elixir section
#   xcode         # Xcode section
#   swift         # Swift section
#   golang        # Go section
#   php           # PHP section
#   rust          # Rust section
#   haskell       # Haskell Stack section
#   julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
#   gcloud        # Google Cloud Platform section
#   venv          # virtualenv section
#   conda         # conda virtualenv section
#   pyenv         # Pyenv section
#   dotnet        # .NET section
  ember         # Ember.js section
#   kubectl       # Kubectl context section
#   terraform     # Terraform workspace section
#   ibmcloud      # IBM Cloud section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Library/Ruby/Gems/2.6.0/gems/colorls-1.4.4/lib/tab_complete.sh
