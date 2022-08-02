PYENV_DIR="${PYENVS_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/pyenvs}"
function chpwd_activate(){
  for pydir in $(ls $PYENV_DIR); do
    if [[ $(pwd|sed -e s@/@_@g) =~ "^$pydir" ]]; then
      if [ "x$VIRTUAL_ENV" != "x$PYENV_DIR/$pydir" ]; then
        echo "Activating virtual env $pydir"
        source "$PYENV_DIR/$pydir/bin/activate"
        return
      fi
    fi
  done
  if [ "x$VIRTUAL_ENV" != "x" ]; then
    echo "Deactivating virtual env $VIRTUAL_ENV"
    deactivate
  fi
}

function venv-here(){
  envdir=$(pwd|sed -e s@/@_@g)
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
