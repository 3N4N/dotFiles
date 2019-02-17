#
#  ██████╗  █████╗ ███████╗██╗  ██╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║
#  ██████╔╝███████║███████╗███████║
#  ██╔══██╗██╔══██║╚════██║██╔══██║
#  ██████╔╝██║  ██║███████║██║  ██║
#  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

# -- bash specific settings ----------------------------------------------------

# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export PAGER="/usr/bin/less -S"

# HIST* are bash-only variables, not environmental variables, so do not 'export'
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd'
HISTTIMEFORMAT='%F %T '
shopt -s histappend             # don't overwrite previous history
shopt -s cmdhist                # store one command per line in history
PROMPT_COMMAND='history -a'     # append history file after each command
PROMPT_DIRTRIM=4                # truncate long paths to ".../foo/bar/baz"

shopt -s checkwinsize           # update $LINES and $COLUMNS after each command
shopt -s globstar &> /dev/null  # (bash 4+) enable recursive glob
shopt -s extglob                # enable extended globbing

bind 'set show-all-if-unmodified'
bind 'set completion-ignore-case on'
bind 'set mark-symlinked-directories on'

# bind c-p and c-n keys for history navigation
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# -- aliases -------------------------------------------------------------------

# useful ls aliases
alias l='ls -vhF1 --group-directories-first'
alias la='l -A'
alias lh='la -d .[^.]*'
alias ld='la -d --indicator-style=none */ .[^.]*/'
alias ll='l -l --time-style=+'
alias lal='la -l --time-style=+'
alias lhl='lh -l --time-style=+'
alias ldl='ld -l --time-style=+'

# show colors in grep and ag
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ag='ag --color-match "31"'

# shorthand for python executables
alias py2='python2'
alias py3='python3'

# miscellaneous
alias i3lock='sh ~/projects/dotFiles/i3/lock.sh'
alias reload='source ~/.bashrc'
alias r='ranger'
alias tree='tree -nF --dirsfirst'
alias t='sh ~/projects/dotFiles/tmux.sh'
alias vimdiff='nvim -d'
alias vi='nvim'

# -- functions -----------------------------------------------------------------

# elaborate digital clock
now() {
	echo -n 'date : '
	date "+%A, %B %d"
	echo -n 'time : '
	date "+%H:%M"
	curl wttr.in/dhaka?0
}

# -- fzf -----------------------------------------------------------------------

if [[ ! -d "$HOME/.fzf" ]]; then
	git clone https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf
	./install --all --no-completion
	cd -
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

if type "ag" >/dev/null ; then
	export FZF_DEFAULT_COMMAND='ag -g ""'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# -- bash autocompletion -------------------------------------------------------

# using fzf messes with bash completion files
# needs to manually source them again
# might need to add more checks if used on more systems
# or could use ~/.fzf/install --all --no-completion
# this will make fzf leave bash completion alone

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# -- title string --------------------------------------------------------------

case "$TERM" in
	st*)
		PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/"~"}"'
		;;
esac

# -- bash prompt ---------------------------------------------------------------

turquoise=$(tput setaf 5)
magenta=$(tput setaf 5)
blue=$(tput setaf 4)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
red=$(tput setaf 1)
reset=$(tput sgr0)
PS1='\[$blue\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$yellow\]\w\[$reset\]\$ '
