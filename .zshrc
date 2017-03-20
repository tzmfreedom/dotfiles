ulimit -n 65536

alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias pass="lpass ls | peco | sed -E 's/(.+)\[id\:(.*)$/\1/g' | sed -e 's/(none)\///g' | xargs lpass show --password | pbcopy"
alias decode_uri='nkf -w --url-input'
alias encode_uri='nkf -WwMQ | tr = %'
alias history_all='history 1'
alias gist_cat='gist -r $(gist -l tzmfreedom | peco | awk "{ print \$1 }" | sed -e "s@https://gist.github.com/@@g")'
alias gist_copy='gist -P $(gist -l tzmfreedom | peco | awk "{ print \$1 }" | sed -e "s@https://gist.github.com/@@g")'
alias gco='git checkout $(git branch | peco | sed -e "s/*//g")'
alias templ='find ~/templates -type f | peco | xargs cat'

# for macOS
if type "gdate" > /dev/null 2>&1; then
  alias date='gdate'
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
  diff =(echo $diff1) =(echo $diff2)
}

function gcd() {
  cd $(ghq root)/$(ghq list | peco --query $1)
}

function search() {
  BUFFER=$(history -n 1 | peco --query ${1:-${LBUFFER}})
  CUSOR=${#BUFFER}
}

function speco() {
  file=$(find spec/ -type f | grep spec.rb | peco --query ${1:-$LBUFFER})
  echo "bundle exec rspec ${file}"
  bin/rspec ${file}
  zle reset-prompt
}

# zle -N fuga
# bindkey '^Z' fuga

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

function row2col_func() {
  echo "please input row data and Ctrl+D to end your input"
  str=""
  while read line
  do
    str=$(printf ${str}","${line})
  done
  print ${str:1}
}

alias row2col="cat | tr '\n' ',' | sed -e 's/.$//g'"
alias tmux_new='tmux new-session \; source-file ~/.tmux/new-session'

if [ -d "${HOME}/.zsh" ]; then
  for file in $(ls ~/.zsh)
  do
    source ${HOME}/.zsh/${file}
  done
fi
