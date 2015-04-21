alias l="ls -lah"
alias vbox="VBoxManage"
alias gl='git log --pretty=online --abbrev-commit'
alias s='/usr/local/bin/subl'
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

alias curldn='curl -v -o /dev/null'
alias st='git status'

set -Ux EDITOR "/usr/local/bin/subl -w"

set -Ux LC_ALL 'en_US.UTF-8'

# set colored ls output to be readable on dark terminal
set -Ux CLICOLOR '1'
set -Ux LSCOLORS 'ExFxBxDxCxegedabagacad'

set -g -x PATH /opt/chefdk/embedded/bin $HOME/.chefdk/gem/ruby/2.1.0/bin /usr/local/bin /usr/local/sbin $PATH

set fish_greeting ''

fortune; and echo;

# # Fish git prompt
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showupstream 'yes'
# set __fish_git_prompt_color_branch normal


# # Status Chars
# set __fish_git_prompt_char_dirtystate '✗'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '↑'
# set __fish_git_prompt_char_upstream_behind '↓'

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

#set -g __fish_git_prompt_color_branch red bold

set -g __fish_git_prompt_showupstream "yes"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix " "

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles ""
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_stateseparator ' '

set -g __fish_git_prompt_color_dirtystate red bold
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold

# load rvm

function rvm_load --description 'Load Ruby enVironment Manager'

  set --local env_file (mktemp -t rvm.fish.XXXXXXXXXX)
  bash -c 'source ~/.rvm/scripts/rvm; env > "$0";' $env_file

  # apply rvm_* and *PATH variables from the captured environment
  and eval (grep '^rvm\|^[^=]*PATH\|^GEM_HOME' $env_file | grep -v '_clr=' | sed '/^[^=]*PATH/s/:/" "/g; s/^/set -xg /; s/=/ "/; s/$/" ;/; s/(//; s/)//')
  # clean up
  rm -f $env_file
end

rvm_load

# Alt + .
# Ctrl + w
function fish_user_key_bindings
   bind \e. 'history-token-search-backward'
   bind \cw 'backward-kill-path-component'
   bind \cH 'backward-kill-word'
   bind \ch 'backward-delete-char'
end

function selfsigned
  if [ "X$argv" = "X" -o "X$argv[1]" = "X" ]
    echo -e "Self-signed certificate generation.\nYou must specify filename prefix. Exiting..."
    return 1
  end
  openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -keyout $argv[1]-(date +%F).key -out $argv[1]-(date +%F).crt
end