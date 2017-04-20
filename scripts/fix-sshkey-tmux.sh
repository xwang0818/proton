
eval $(tmux show-env |sed -n 's/^\(SSH_[^=]*\)=\(.*\)/export \1="\2"/p')

