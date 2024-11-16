#/bin/bash

# create symlink
# @param $1 source relative to $HOME
mklink () {
	# use the second argument, if it exists
	target=$HOME/${2-$1}
	if [[ -L $target ]]; then
		echo "Found existing symlink at" $target
	# else
		if [[ -e $target.bak ]]; then
			mv -vi $target.bak.bak $target
		fi
		ln -svi $HOME/.dotfiles/$1 $target
	fi
}

setup_symlinks() {
    echo "Creating symlinks..."
    mklink .config/alacritty
    mklink .config/awesome
    mklink .config/nvim
    mklink .config/tmux
    mklink .config/i3
    mklink .config/picom
    mklink .config/ranger
    mklink .config/rofi
    mklink .config/xkb
    mklink .clang-format
    mklink .bashrc
}

install_packages() {
    echo "Updating & Installing tools..."
    sudo pacman -Syu --needed feh fzf go alacritty awesome nvim tmux i3 picom ranger rofi curl

    echo "Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}


layout() {
    echo "Setting up custom keyboard layout..."
    XKB_DIR=/usr/share/X11/xkb/symbols

    if [[ -d $HOME/.config/xkb ]]; then
        for file in $HOME/.config/xkb/*; do
            filename=$(basename "$file")
            target="$XKB_DIR/$filename"

            if [[ -L $target ]]; then
                echo "Found existing symlink at $target"
            else
                if [[ -e $target ]]; then
                    sudo mv -vi "$target" "$target.bak"
                fi
                sudo ln -svi "$file" "$target"
            fi
        done
    else
        echo "No custom keyboard layouts found in ~/.config/xkb."
    fi
}

setup_symlinks
install_packages
layout
echo "Done!"
