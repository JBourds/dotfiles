# TMUX

Install using `pacman -S tmux`.

TMUS requires the [TMUX Plugin Manager](https://github.com/tmux-plugins/tpm)
to work correctly. This involves a single command:

- git clone <https://github.com/tmux-plugins/tpm> ~/.tmux/plugins.tpm

NOTE: If TMUX doesn't work immediately after cloning the `dotfiles` repo
resursively, try deleting the `~/.tmux/plugins/tpm` directory and cloning it again.

Then, TMUX needs to be either restarted or sourced with:

`tmux source ~/.tmux.conf`

Once the TMUX Plugin Manager is installed, all the plugins can be installed
with `<prefix> I`. This should be it!
