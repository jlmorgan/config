# Enable colors
export CLICOLOR=1

# a black
# b red
# c green
# d brown
# e blue
# f magenta
# g cyan
# h light grey
# A bold black, usually shows up as dark grey
# B bold red
# C bold green
# D bold brown, usually shows up as yellow
# E bold blue
# F bold magenta
# G bold cyan
# H bold light grey; looks like bright white
# x default foreground or background

#  1. directory
#  2. symbolic link
#  3. socket
#  4. pipe
#  5. executable
#  6. block special
#  7. character special
#  8. executable with setuid bit set
#  9. executable with setgid bit set
# 10. directory writable to others, with sticky bit
# 11. directory writable to others, without sticky bit

#                                 1 1
#               1 2 3 4 5 6 7 8 9 0 1
export LSCOLORS=ExFxBxCxexhxhxexexGeGe

# \[\e[;34m\]  -> start light blue
# \h           -> short hostname
# \[\e[0m\]    -> end light blue
# \[\e[1;34m\] -> start bold light blue
# \W           -> current directory
# \[\e[0m\]    -> end bold light blue
# \[\e[;30m\]  -> start gray
# \u           -> username
# \[\e[0m\]    -> end gray
export PS1="\[\e[34m\]\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\] \[\e[30m\]\u\[\e[0m\]\$ "
export PS2="\[\e[34m\] => \[\e[0m\]"

# Enable aliases
if [[ -f "$HOME/.bash_aliases" ]]; then
  source $HOME/.bash_aliases
fi

customProfile=( "$HOME/.bash_profile_local" "$HOME/.bash_aliases_local" )

for item in "${customProfile[@]}"; do
  if [[ -f "$item" ]]; then
    source $item
  fi
done

# Paths that take precidence
earlyPaths=( "/usr/local/sbin" "/usr/local/bin" "$HOME/bin" )

for item in "${earlyPaths[@]}"; do
  if [[ -d "$item" ]]; then
    export PATH="$item:$PATH"
  fi
done

# Paths that do not take precidence
latePaths=( "/usr/local/git/bin" "/usr/local/mysql/bin" "/usr/local/php5/bin" "/usr/local/rvm/bin" "/usr/local/sencha" "$HOME/.rvm/bin" )

for item in "${latePaths[@]}"; do
  if [[ -d "$item" ]]; then
    export PATH="$PATH:$item"
  fi
done

# Enable RVM
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  source "/usr/local/rvm/scripts/rvm"
fi
