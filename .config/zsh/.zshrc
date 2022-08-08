# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%F{blue}%n%F{cyan}@%F{blue}%m %F{magenta}[%f%3~%F{magenta}] %(?.%F{green}.%F{red})»%f%b "
RPS1="%(?..%F{red}%?)"
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY BANG_HIST interactive_comments autocd

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    fid="$(mktemp)"
    lf -command '$printf $id > '"$fid"'' -last-dir-path="$tmp" "$@"
    id="$(cat "$fid")"
    archivemount_dir="/tmp/__lf_archivemount_$id"
    if [ -f "$archivemount_dir" ]; then
        cat "$archivemount_dir" | \
            while read -r line; do
                sudo umount "$line"
                rmdir "$line"
            done
        command rm -f "$archivemount_dir"
    fi
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        command rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
    tput cuu1;tput el
}

_lfcd () {
  BUFFER="lfcd"
  zle accept-line
}
zle -N _lfcd
bindkey '^o' _lfcd

# bind lazygit to ctrl-g
lg () {
  lazygit
  tput cuu1;tput el
}

_lazygit () {
  BUFFER="lg"
  zle accept-line
}

zle -N _lazygit
bindkey '^g' _lazygit

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# other keybinds
bindkey -v '^?' backward-delete-char
bindkey '^[[P' delete-char
bindkey "^[[H" beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word 



PLUGINS_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
[ -f "$PLUGINS_HOME/fzf/key-bindings.zsh" ]                                         && source "$PLUGINS_HOME/fzf/key-bindings.zsh"
[ -f "$PLUGINS_HOME/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && source "$PLUGINS_HOME/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[ -f "$PLUGINS_HOME/autopyenv/autopyenv.plugin.zsh" ]                               && source "$PLUGINS_HOME/autopyenv/autopyenv.plugin.zsh"

