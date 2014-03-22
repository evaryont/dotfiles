# zshenv: Define environment variables

# Hard-coded path to the checkout of my dotfiles, derived from the zshenv
# symlink (this file).
local DOTSDIR="${${:-$HOME/.zshenv}:A:h}"

# Make sure the arrays only contain unique values
typeset -gU cdpath fpath mailpath manpath path
# And make sure these variables are exported to subcommands
typeset -x PATH MANPATH

unsetopt NO_MATCH # Don't error on failed matches

# And now, set them
path=(
  $HOME/bin             # My own scripts, programs, etc
  $HOME/.local/share/cabal/bin # User-installed haskell packages
  $HOME/.gem/ruby/*/bin # Binaries provided by user installed gems
  /usr/lib/cw           # Colorized versions of GNU coreutils
  /usr/{bin,sbin}       # Most programs & binaries
  /{bin,sbin}           # Lower-level, "basic" commands
  $path                 # System-provided paths
  /usr/local/{bin,sbin} # Local administrator installed/odd-ball commands
  /opt/java/bin         # Some java installations
  $HOME/.heroku/client/bin # Heroku toolbelt, as installed via `heroku update`
  /usr/local/heroku/bin # Heroku toolbelt, as installed from a package
  $DOTSDIR/share/rbenv/bin # rbenv install
)

fpath=(
  $DOTSDIR/config/zsh/plugins/users-completions/src/
  $DOTSDIR/share/zsh/
  $fpath
)

manpath=(
  #${${:-~/.rubygems/gems/*/man/*.[0-9]}:A:h} # Gem-installed man pages
  /usr/local/share/man
  /usr/share/man
  $manpath
)

# Given a list of arrays, delete any values from each that don't point to a
# real directory. It will also resolve any symlinks.
function _strip_fakes {
  local a
  for a in "$@"; do
    integer i
    for (( i=1; i<=${(P)#a}; i++ )); do
      if [[ ! -d ${(P)${a}[i]} ]]; then
        eval "${(q)a}[${i}]=()"
      elif [[ -h ${(P)${a}[i]} ]]; then
        eval "${(q)a}[${i}]=(${(P)${a}[i]:A})"
      fi
    done
  done
}
_strip_fakes path fpath manpath
unfunction _strip_fakes

# Make sure we have a language set
if ! (( $+LANG )) || [[ -z "$LANG" ]]; then
  export LC_ALL="en_US.UTF-8"
  emulate -R sh -c "$(locale)"
fi
