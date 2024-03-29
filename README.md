# Indeximal Dotfiles
Personal configuration and VM setup files

This repo is inspired by [this Blog post](https://arslan.io/2019/01/07/using-the-ipad-pro-as-my-development-machine/) by Fatih Arslan.
However, I decided to use Make for everything and not just the symlinks.

There are two Makefiles in this repo, the first one `Makefile` is dotfile functionality.
So symlinking config files and creating a common work enviroment.
The second one `Installers.make` is for installing different executables.
This might easly change in the future.

## Usage
Clone the repo and run
```
# Link dotfiles and set up environment. Run as unpriviledges sudoers user.
make all
# Install essential executables. Can be run as root (for essentials)
make -f Installers.make essentials
# Install facelapse prerequisites (as unprivildeged)
make -f Installers.make facelapse
```

When creating a new droplet on DigitalOcean use this code as user data.
```
#!/bin/bash
set -euo pipefail

USERNAME=cyrill

# Create user and immediately expire password to force a change on login
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
passwd --delete "${USERNAME}"
chage --lastday 0 "${USERNAME}"

# Create SSH directory for sudo user and move keys over
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"
cp /root/.ssh/authorized_keys "${home_directory}/.ssh"
chmod 0700 "${home_directory}/.ssh"
chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"

# Disable root SSH login with password
sed --in-place 's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
if sshd -t -q; then systemctl restart sshd; fi

# Set up dotfiles and install programs
git clone https://github.com/Indeximal/dotfiles.git ${home_directory}/dotfiles
chown -R cyrill:cyrill dotfiles/
cd ${home_directory}/dotfiles
apt install make
make -f Installers.make essentials
# make all  # only works for the current user, which is root in this script
```

## Todos
- [ ] Installers for Samba
- [ ] vim plugins (especially for fish scripts)

