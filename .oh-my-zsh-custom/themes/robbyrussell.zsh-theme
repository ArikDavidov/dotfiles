PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
PROMPT+='%{$fg[white]%}%T %{$fg_bold[blue]%}%~%{$reset_color%} $(git_super_status)%% '
