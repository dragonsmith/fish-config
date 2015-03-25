function fish_prompt --description 'Write out the prompt'
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_prompt_cwd
    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  end

  # Show colored branch name only if not "master"
  if __fish_git_prompt | grep -q master
    set -g __fish_git_prompt_color_branch normal bold
  else
    set -g __fish_git_prompt_color_branch red bold
  end

  set _host " Yukikaze: "
  set _pwd (prompt_pwd)
  set _git (__fish_git_prompt)

  echo -n "# "

  set_color 303030
  echo -n -s [(date)]
  set_color normal

  set_color $fish_color_host
  echo -n -s $_host

  set_color $fish_color_cwd
  echo -n -s $_pwd

  set_color normal
  echo -s $_git

  echo -n '➜ '

end

# function fish_right_prompt --description 'Date and time prompt'
#   set_color 303030
#   echo -n -s [(date)]
#   set_color normal
# end