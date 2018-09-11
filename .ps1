# setup command prompt using __git_ps1 if available

if [[ $(type -t __git_ps1) == "function" ]]; then
  GITCMD="__git_ps1"
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUPSTREAM=verbose
else
  GITCMD=""
fi

function __prompt_command() {
  local EXIT="$?"
  local RCol='\[\e[0m\]'
  local Red='\[\e[0;31m\]'
  local Gre='\[\e[0;32m\]'
  [[ $EXIT != 0 ]] && Col=${Red} || Col=${Gre}
  PS1="${Col}\w${RCol}$($GITCMD) > "
}
export PROMPT_COMMAND=__prompt_command