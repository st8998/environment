eval "$(rbenv init -)"

# ruby GC limits expanded
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000

export HISTCONTROL=ignoreboth
export HISTSIZE=10000

# prompt
export PS1='\[`echo -n -e "\033]0;${PWD##*/}\007"`\]\W> '

export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/share/npm/bin:$PATH

# some aliases
alias ll="ls -l"
alias la="ls -la"

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

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

