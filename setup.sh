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
    mklink .Xresources
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

setup_nas_share () {
    echo "setting up /etc/fstab"
    echo "//10.0.0.110/share /media/share cifs credentials=/etc/samba/smbcredentials,uid=smbuser,gid=smbuser,file_mode=0770,dir_mode=0770,noperm 0 0" \
        >> /etc/fstab

    echo "setting up mount point"
    sudo mkdir /etc/samba
    sudo mkdir /mount

    sudo pacman -S cifs-utils

    echo "username=justin" > /etc/samba/smbcredentials
    echo "password=JxmMR467" >> /etc/samba/smbcredentials

    echo "mounting"
    sudo mount -a
}

setup_lightdm() {
    echo "Installing lightdm slick greeter..."
    yay -S lightdm-slick-greeter

    # sudo cp ./.config/rofi/images/h.jpg /usr/share/pixmaps/greeter-user-bg.jpg
    sudo cp ./.config/rofi/images/g.png /usr/share/pixmaps/greeter-bg.png

    # set lightdm greeter to slick-greeter
    sudo sed -ri "s/^#(greeter-session=).*$/\\1lightdm-slick-greeter/" /etc/lightdm/lightdm.conf

    # set lightdm.conf to setup the proper monitor
    sudo sed -ri "s/(\[SeatDefaults\])/\\1\ndisplay-setup-script=\/home\/justin\/.dotfiles\/screenlayout\/layout.sh\nsession-setup-script=\/home\/justin\/.dotfiles\/screenlayout\/layout.sh/" /etc/lightdm/lightdm.conf

    sudo echo "[Greeter]" > /etc/lightdm/slick-greeter.conf
    sudo echo "background=/usr/share/pixmaps/greeter-bg.png" > /etc/lightdm/slick-greeter.conf
}

# setup_symlinks
# install_packages
# setup_nas_share 
# layout
setup_lightdm
echo "Done!"
