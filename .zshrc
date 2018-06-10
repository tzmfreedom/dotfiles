# ulimit -n 65536
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias pass="lpass ls | peco | sed -E 's/(.+)\[id\:(.*)$/\1/g' | sed -e 's/(none)\///g' | xargs lpass show --password | pbcopy"
alias decode_uri='nkf -w --url-input'
alias encode_uri='nkf -WwMQ | tr = %'
alias history_all='history 1'
alias gist_cat='gist -r $(gist -l tzmfreedom | peco | awk "{ print \$1 }" | sed -e "s@https://gist.github.com/@@g")'
alias gist_copy='gist -P $(gist -l tzmfreedom | peco | awk "{ print \$1 }" | sed -e "s@https://gist.github.com/@@g")'
alias gco='git checkout $(git branch | peco | sed -e "s/*//g")'
alias templ='find ~/templates -type f | peco | xargs cat'
alias gd='git diff HEAD~1..HEAD'
alias edit_zshrc='vim ~/.zshrc'
alias source_zshrc='source ~/.zshrc'
alias untargz='tar zxf'
alias targz='tar zcf'
alias migrate_down='version=$(ls db/migrate | peco | cut -d "_" -f1); bin/rake db:migrate:down VERSION=$version'
alias migrate_up='version=$(ls db/migrate | peco | cut -d "_" -f1); bin/rake db:migrate:up VERSION=$version'
alias migrate_apply='version=$(ls db/migrate | peco | cut -d "_" -f1); bin/rake db:migrate:down VERSION=$version; bin/rake db:migrate:up VERSION=$version'
alias be='bundle exec'
alias hb='hub browse'
alias lli='/usr/local/opt/llvm/bin/lli'
# for macOS
if type "gdate" > /dev/null 2>&1; then
  alias date='gdate'
fi

if type "trash-put" > /dev/null 2>&1; then
  alias rm='trash-put'
fi

if type "gsed" > /dev/null 2>&1; then
  alias sed='gsed'
fi

function login_sf() {
  username=$(lpass show --username $1)
  password=$(lpass show --password $1)
  url=$(lpass show --url $1)
  /usr/bin/open -a "/Applications/Google Chrome.app" "${url}/?un=${username}&pw=${password}"
}

function diff_stdin() {
  echo "input file1: if you want to end your input, press Ctrl+D"
  diff1=$(cat)
  echo "input file2: if you want to end your input, press Ctrl+D"
  diff2=$(cat)
  diff -w =(echo $diff1) =(echo $diff2)
}

function gcd() {
  cd $(ghq root)/$(ghq list | peco --query "$1")
}

function search() {
  BUFFER=$(history -n 1 | peco --query ${1:-${LBUFFER}})
  CUSOR=${#BUFFER}
}

function speco() {
  file=$(find spec -type f | grep spec.rb | peco --query "${1:-$LBUFFER}")
  echo "bundle exec rspec ${file}"
  bundle exec rspec ${file}
  zle reset-prompt
}

function respeco() {
  echo "bundle exec rspec ${file}"
  bundle exec rspec ${file}
}


# zle -N fuga
# bindkey '^Z' fuga

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

function row2col() {
  echo "please input row data and Ctrl+D to end your input"
  str=""
  while read line
  do
    str=$(printf ${str}"${1:-,}"${line})
  done
  print ${str:1}
}

alias row2col="cat | tr '\n' ',' | sed -e 's/.$//g'"
alias row2col_dq='echo \"$(cat | perl -pe "s/\n/\",\"/g" | sed -e "s/..$//g")\"'

alias tmux_new='tmux new-session \; source-file ~/.tmux/new-session'
alias sha1='openssl dgst -sha1'
alias sha256='openssl dgst -sha256'
alias md5='openssl dgst -md5'

alias csv2redmine='tr "," "|" | sed -e "s/^/|/g" -e "s/$/|/g"'
alias csv2redmine_tab='tr "\t" "|" | sed -e "s/^/|/g" -e "s/$/|/g"'

function killer() {
  pid=$(ps aux | grep "$1" | peco | awk '{ print $2 }')
  kill -9 ${pid}
}

if [ -d "${HOME}/.zsh" ]; then
  for file in $(ls ~/.zsh)
  do
    source ${HOME}/.zsh/${file}
  done
fi

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

reload_completion() {
  local f
  f=(/usr/local/share/zsh/site-functions/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

if type go > /dev/null 2>&1; then
  export GOPATH="$HOME/dev"
  export PATH="$GOPATH/bin:$PATH"
fi

function server() {
  op http://localhost:8000
  port=${1:-"8000"}
  if type ruby > /dev/null; then
    ruby -rwebrick -e "WEBrick::HTTPServer.new(:DocumentRoot => './', :Port => $port).start"
    # ruby -run -e httpd . -p 5000
  elif type python > /dev/null; then
    version=$(python -V 2>&1)
    if [[ $version =~ "^Python 2." ]]; then
      python -m SimpleHTTPServer $port
    elif [[ $version =~ "^Python 3." ]]; then
      python -m http.server $port
    fi
  elif type php > /dev/null; then
    php -S 0.0.0.0:$port
  elif type http-server > /dev/null; then
    http-server -p $port
  fi
}

function peco-select-history() {
    BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function git_push() {
  current_branch=$(git branch | grep "*" | awk '{ print $2 }')
  BUFFER="git push origin ${current_branch}"
  CURSOR=$#BUFFER
}

zle -N git_push git_push
bindkey '^G^P' git_push

export PATH=/usr/local/opt/openssl/bin:$PATH

autoload -Uz colors
colors

PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%{${fg[cyan]}%}${_prompt_sorin_pwd}%(!. %B%F{1}#%f%b.)%{${fg[magenta]}%} [%T]%{${reset_color}%}${editor_info[keymap]} '
export LSCOLORS=cxfxcxdxbxegedabagacad
eval "$(direnv hook zsh)"

# added by travis gem
[ -f /Users/m-tajitsu/.travis/travis.sh ] && source /Users/m-tajitsu/.travis/travis.sh

alias op='/usr/bin/open -a "/Applications/Google Chrome.app"'

function convert_uploadable_keynote_pdf() {
  extension=${1##*.}

  if [ $extension != "pdf" ]; then
    echo 'Suffix needs to "pdf"' 1>&2

    return 1
  fi

  if [ $# -eq 1 ]; then
    bash -c "LANG=C LC_ALL=C sed -i 's|/Registry (Adobe) /Ordering (Japan1) /Supplement [0-9]|/Registry(Adobe) /Ordering(Identity) /Supplement 0|g' $1"
  else
    echo "usage: convert_uploadable_keynote_pdf pdf_path" 1>&2

    return 1
  fi
}
