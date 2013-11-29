eval "$(rbenv init -)"

# ruby GC limits expanded
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000

export HISTCONTROL=ignoreboth
export HISTSIZE=10000

# prompt
# all prompt should be placed inside \[ \] brackets
export PS1='\[\e[1;32m\]`echo -n -e "\[\033]0;${PWD##*/}\007\]"`\W\[\e[m\]> '

export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/share/npm/bin:$PATH

# some aliases
alias ll="ls -l"
alias la="ls -la"

# Extract an archive of any type
extract(){
   if [ $# -lt 1 ]
   then
       echo Usage: extract file
       return 1
   fi
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.war|*.jar) unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# Creates an archive
roll(){
  if [ "$#" -ne 0 ] ; then
    FILE="$1"
    case "$FILE" in
      *.tar.bz2|*.tbz2) shift && tar cvjf "$FILE" $* ;;
      *.tar.gz|*.tgz)   shift && tar cvzf "$FILE" $* ;;
      *.tar)            shift && tar cvf "$FILE" $* ;;
      *.zip)            shift && zip "$FILE" $* ;;
      *.rar)            shift && rar "$FILE" $* ;;
      *.7z)             shift && 7zr a "$FILE" $* ;;
      *)                echo "'$1' cannot be rolled via roll()" ;;
    esac
  else
    echo "usage: roll [file] [contents]"
  fi
}

# Shortcut for `bundle exec rails` and `bundle exec rake`.
# If script/rails and script/rake are available, use them instead as they are much
# faster to execute than `bundle exec`.
function r() {
  if [[ "g|generate|c|console|s|server|db|dbconsole|new" =~ $1 ]]; then
    if [ -x script/rails ]; then
      script/rails $@
    else
      bundle exec rails $@
    fi
  else
    if [ -x script/rake ]; then
      script/rake $@
    else
      bundle exec rake $@
    fi
  fi
}

# auto switch on/off python virtualenv
function cd {
  if [ -d "env" ]; then
    deactivate
  fi
  builtin cd "$@"
  if [ -d "env" ]; then
    source env/bin/activate
  fi
}

# bundle exec alias
alias be="bundle exec"

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# export ssl certificates
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
