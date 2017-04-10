# Install a web development machine

This repo contains scripts to set up an OS X or Linux computer for web 
development, and to keep it up to date.

It can be run multiple times on the same machine safely. It installs,
upgrades, or skips packages based on what is already installed on the machine.

You can easily [customize](#customize-in-laptoplocal) the script to install 
additional tools.

## Install

In your Terminal window, copy and execute the command below.

```sh
bash <(curl -s https://raw.githubusercontent.com/laupiFrpar/web-development-environment/master/web-development-environment)
```

**Once the script is done, quit and relaunch Terminal.**

It is highly recommended to run the script regularly to keep your computer up
to date. Once the script has been installed, you'll be able to run it at your
convenience by typing `install` and pressing `return` in your Terminal.

## Debugging

Your last Laptop run will be saved to a file called `mac-dev.log` in your home
folder. Read through it to see if you can debug the issue yourself. If not,
copy the entire contents of `web-development-environment.log` into a
[new GitHub Issue](https://github.com/laupiFrpar/web-development-environment/issues/new) for me.
Or, attach the whole log file as an attachment.

## What it sets up

* [chruby] for managing [Ruby] versions
* [Homebrew] for managing operating system libraries
* [Homebrew Cask] for quickly installing Mac apps from the command line
* [Homebrew Services] so you can easily stop, start, and restart services
* [ruby-install] for installing different versions of Ruby
* [Sublime Text 3] for coding all the things

[chruby]: https://github.com/postmodern/chruby
[Homebrew]: http://brew.sh/
[Homebrew Cask]: http://caskroom.io/
[Homebrew Services]: https://github.com/Homebrew/homebrew-services
[ruby-install]: https://github.com/postmodern/ruby-install
[Sublime Text 3]: http://www.sublimetext.com/3

It should take less than 15 minutes to install (depends on your machine and
internet connection).

```bash
cd ~

curl --remote-name https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Dark.terminal

curl --remote-name https://raw.githubusercontent.com/tomislav/osx-terminal.app-colors-solarized/master/Solarized%20Light.terminal

open Solarized%20Dark.terminal

open Solarized%20Light.terminal
```

This will add the Solarized themes to your Terminal's Profiles, and if you want to set one of them as the default, go to your Terminal's Preferences,
click on the Settings tab, scroll down to the Solarized Profile, click on it,
then click the Default button. When you open a new window or tab (or if you quit and relaunch Terminal), it will use the Solarized theme.

## Customize in `~/.web-development-environment.local` and `~/Brewfile.local`
```sh
# Go to your OS X user's root directory
cd ~

# Download the sample files to your computer
curl --remote-name https://raw.githubusercontent.com/monfresh/laptop/master/.web-development-environment.local
curl --remote-name https://raw.githubusercontent.com/monfresh/laptop/master/Brewfile.local

# open the files in Sublime Text
subl .web-development-environment.local
subl Brewfile.local
```

Your `~/.web-development-environment.local` is run at the end of the `mac` script.
Put your customizations there. If you want to install additional
tools or Mac apps with Homebrew, add them to your `~/Brewfile.local`.
You can use the `.web-development-environment.local` and `Brewfile.local` you downloaded
above to get started. It lets you install the following tools and Mac apps:

* [Firefox] for testing your Rails app on a browser other than Chrome or Safari
* [iTerm2] - an awesome replacement for the OS X Terminal

[Firefox]: https://www.mozilla.org/en-US/firefox/new/
[iTerm2]: http://iterm2.com/

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Laptop functions such as `fancy_echo`, and `gem_install_or_update` can be used
in your `~/.web-development-environment.local`.

## Credits

This laptop script is inspired by
[monfresh's laptop](https://github.com/monfresh/laptop) script.

## Todo

- Install Composer
- Add some features in `.bash_profile` 
- Customize installation
    - Customize PS1
    - Install oh-my-git (customize installation)
    - Install PHP
        - For creads, pin the imagemagick and php-imagick version (into the file `machine.local` or `creads.local`)
    - Install mysql
    - Install `thefuck` for Creads
    - Install `node@5` for Creads
    - Install `symfony-console-complete`
    - Add the configuration for Gitlab Creads
    - Install MailCatcher
- Install on Linux