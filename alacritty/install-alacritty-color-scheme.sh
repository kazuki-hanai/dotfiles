#!bin/bash 

# Install plugin
pip install --user alacritty-colorscheme

# Install themes

REPO=https://github.com/eendroroy/alacritty-theme.git
DEST="$HOME/.eendroroy-colorschemes"

if [ ! -d $DEST ]; then 
    # Get colorschemes
    git clone $REPO $DEST
fi
# Create symlink at default colors location (optional)
mkdir -p $HOME/.config/alacritty
ln -s "$DEST/themes" "$HOME/.config/alacritty/colors"
