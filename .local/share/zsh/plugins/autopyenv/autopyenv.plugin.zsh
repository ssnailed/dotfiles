PYENV_DIR="${PYENVS_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/virtualenv}"
function chpwd_activate(){
  [[ "$(pwd)" == "/" ]] && return 0
  envdir=$(pwd|sed -e s@/@_@g|cut -c2-)
  for pydir in $(ls $PYENV_DIR); do
    if [[ "$envdir" == "$pydir" ]]; then
      if [ "x$VIRTUAL_ENV" != "x$PYENV_DIR/$pydir" ]; then
        source "$PYENV_DIR/$pydir/bin/activate"
        return
      fi
    fi
  done
  [[ "x$VIRTUAL_ENV" != "x" ]] && deactivate
}

function venv-here(){
  [[ "$(pwd)" == "/" ]] && echo "Cannot create venv at root" && return 1
  [[ "$(pwd)" != "/" ]] && envdir=$(pwd|sed -e s@/@_@g|cut -c2-)
  if [ ! -e "$PYENV_DIR/${envdir}" ]; then
    echo "Creating python venv for ${envdir}.."
    mkdir "$PYENV_DIR" -p
    python3 -m venv "$PYENV_DIR/${envdir}"
    echo "Activating virtual env ${envdir}"
    source "$PYENV_DIR/${envdir}/bin/activate"
  else
    echo "A venv for this path already exists"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_activate
