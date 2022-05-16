alias c='clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias k='kubectl'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

# How to create alias - temporary
alias shortName="your custom command here"
alias wr=”cd /var/www/html”

# permanently create alias
 vi ~/.bashrc
#My custom aliases
alias home=”ssh -i ~/.ssh/mykep.pem tecmint@192.168.0.100”
alias ll="ls -alF"
source ~/.bashrc

unalias alias_name
unalias -a [remove all alias]


