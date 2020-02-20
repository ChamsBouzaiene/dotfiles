# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chames/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/chames/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/chames/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/chames/.fzf/shell/key-bindings.zsh"
