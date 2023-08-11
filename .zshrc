# ulimit -n 65536
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias gpr='gh pr view -w $(git branch --show-current)'
alias decode_uri='nkf -w --url-input'
alias encode_uri='nkf -WwMQ | tr = %'
alias gco='git checkout $(git branch | peco | sed -e "s/*//g")'
alias gd='git diff HEAD~1..HEAD'
alias untargz='tar zxf'
alias targz='tar zcf'
alias mvim=/Applications/MacVim.app/Contents/bin/mvim "$@"

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

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

alias tmux_new='tmux new-session \; source-file ~/.tmux/new-session'
alias sha1='openssl dgst -sha1'
alias sha256='openssl dgst -sha256'
alias md5='openssl dgst -md5'

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

if type colordiff > /dev/null 2>&1; then
  alias diff="colordiff"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# For PHP Build
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/bzip2/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/krb5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"

export PHP_RPATHS="/usr/local/opt/zlib/lib /usr/local/opt/bzip2/lib /usr/local/opt/curl/lib /usr/local/opt/libiconv/lib /usr/local/opt/libedit/lib"
export PHP_BUILD_CONFIGURE_OPTS="--with-zlib-dir=/usr/local/opt/zlib --with-bz2=/usr/local/opt/bzip2 --with-curl=/usr/local/opt/curl --with-iconv=/usr/local/opt/libiconv --with-libedit=/usr/local/opt/libedit"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

export PATH="$HOME/.cargo/bin:$PATH"

color-ssh() {
    trap _color-ssh INT EXIT
    if [[ "$*" =~ "prod" ]]; then
        _color-ssh prod
    elif [[ "$*" =~ "dev" ]]; then
        _color-ssh dev
    else
        _color-ssh other
    fi
    echo "$*"
    command ssh $*
}

_color-ssh() {
  if [[ "$TERM" == "screen"* ]] && [[ -n "$TMUX" ]]; then
    if [[ "$1" == "prod" ]]; then
      tmux select-pane -P 'bg=#331C1F'
    elif [[ "$1" == "dev" ]]; then
      tmux select-pane -P 'bg=#192436'
    elif [[ "$1" == "other" ]]; then
      tmux select-pane -P 'bg=#253320'
    else
      tmux select-pane -P 'bg=#000000'
    fi;
  else
    if [[ "$1" == "prod" ]]; then
      printf '\033]11;#331C1F\007'
    elif [[ "$1" == "dev" ]]; then
      printf '\033]11;#192436\007'
    elif [[ "$1" == "other" ]]; then
      printf '\033]11;#253320\007'
    else
      printf '\033]11;#000000\007'
    fi
  fi
}

compdef _ssh color-ssh=ssh
alias ssh=color-ssh
