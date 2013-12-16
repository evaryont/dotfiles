# Tell cw programs not to send ANSI color codes to piped outputs
export NOCOLOR_PIPE=1

# Personal preferences. XDG uses these, among other applications
export EDITOR="vim"
export BROWSER="elinks"
export PAGER="less"

# CLI default parameters
export GREP_DEFAULTS="-E -i -I -n --color=auto"
export LESS="-RSMwi"
export VI_OPTIONS="--servername VIM -p"

# Enviornment variables that affect Zsh
export HISTSIZE=2000
export SAVEHIST=20000

# Identification
export UID="$(id -u)"
export USERID="${UID}"
export ME="${UID}"

# Application settings
export SUDO_PROMPT="Your Password:"
export GDK_USE_XFT=1
export QT_XFT=true

# Generic Environment stuff
if [ -e /usr/lib/libtrash.so ] ; then
    export LD_PRELOAD="/usr/lib/libtrash.so ${LD_PRELOAD}"
fi

[ -z "$HOSTNAME" ] && export HOSTNAME="$(hostname)"

export TMOUT=3600

## XDG-related stuff# {{{
export XDG_CACHE_HOME="${HOME}/.local/cache"
#if [ ! -d $XDG_CACHE_HOME/zsh ] ; then
#    mkdir -p $XDG_CACHE_HOME/zsh
#fi
#
#export XDG_CONFIG_HOME="${HOME}/.local/config"
#if [ ! -d $XDG_CONFIG_HOME/zsh ] ; then
#    mkdir -p $XDG_CONFIG_HOME/zsh
#fi
#
#export XDG_DATA_HOME="${HOME}/.local/share"
#if [ ! -d $XDG_DATA_HOME/zsh ] ; then
#    mkdir -p $XDG_DATA_HOME/zsh
#fi
#
## Arch doesn't set XDG_DATA_DIRS or XDG_CONFIG_DIRS by default any more, so
## assume the default directories for both.
#if [ -z "${XDG_DATA_DIRS}" ]; then
#    export XDG_DATA_DIRS="${HOME}/.local/share:/usr/local/share:/usr/share"
#else
#    export XDG_DATA_DIRS="${HOME}/.local/share:${XDG_DATA_DIRS}"
#fi
#if [ -z $XDG_CONFIG_DIRS ]; then
#    export XDG_CONFIG_DIRS="${HOME}/.local/config:/etc/xdg"
#else
#	export XDG_CONFIG_DIRS="${HOME}/.local/config:${XDG_CONFIG_DIRS}"
#fi
## }}}

# MAILDIR & new mail alerts
test -e $HOME/mail && export MAILDIR=$HOME/mail && for i in $(echo $MAILDIR/**/cur(:h)); do mailpath[$#mailpath+1]="${i}?You have new mail in ${i:t}."; done

# Every single locale-related variable I could think of
export            LOCALE="en_US.utf8"
export              LANG="en_US.utf8"
export          LC_CTYPE="en_US.utf8"
export        LC_NUMERIC="en_US.utf8"
export           LC_TIME="en_US.utf8"
export        LC_COLLATE="C"
export       LC_MONETARY="en_US.utf8"
export       LC_MESSAGES="en_US.utf8"
export          LC_PAPER="en_US.utf8"
export           LC_NAME="en_US.utf8"
export        LC_ADDRESS="en_US.utf8"
export      LC_TELEPHONE="en_US.utf8"
export    LC_MEASUREMENT="en_US.utf8"
export LC_IDENTIFICATION="en_US.utf8"
export     HARDWARECLOCK="UTC"
export          TIMEZONE="America/New_York"
# History location.
export          HISTFILE="${XDG_CACHE_HOME}/zsh/history"
export          HISTSIZE="5000000" # Save a *lot* of history. Space is cheap
export          SAVEHIST="${HISTSIZE}"

# Various configuration files can be pointed to different places via environment
# variables, so take advantage of that to add 'XDG support'
export WINEARCH="win32"
export WINEPREFIX="${XDG_DATA_HOME}/wine/"
export ACKRC="${XDG_CONFIG_HOME}/ackrc"

# Pretty colors! Used by zstyle & ls (and probably others)
eval $(dircolors -b ${DOTSDIR}/config/dircolors)
export INPUTRC="${DOTSDIR}/inputrc"
export MPLAYER_HOME="${XDG_CONFIG_HOME}/mplayer"
#export GIT_CONFIG="${DOTSDIR}/config/git/config"
export RVC_READLINE='/usr/lib/ruby/1.8/x86_64-linux/readline.so'

export GEM_HOME="${HOME}/.rubygems"
export UZBL_UTIL_DIR="${XDG_DATA_HOME}/uzbl/scripts/util"

# A few applications (like osc) still expect GNOME_DESKTOP_SESSION_ID to exist,
# so define a value if it hasn't already.
[ -z "$GNOME_DESKTOP_SESSION_ID" ] && GNOME_DESKTOP_SESSION_ID='this-is-deprecated'

export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

if [ "$COLORTERM" = "gnome-terminal" ]; then
    export TERM="xterm-256color"
fi

# Development environment stuff.
export MYDRIVEADVISOR_DB_PWD="mysqlroot"
export MYSQL_LOCAL_SOCKET="/run/mysqld/mysqld.sock"

export LESSHISTFILE="${XDG_CACHE_HOME}/lesshist"
export LESSHISTSIZE=2000
