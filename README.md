# Install a web development machine

This repo contains scripts to set up an OS X computer for web development, and to keep it up to date.

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

## Install


```sh
bash <(curl -s https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/boot)
```

**Once the script is done, quit and relaunch Terminal.**

It is highly recommended to run the script regularly to keep your computer up to
date. Once the script has been installed, you'll be able to run it at your
convenience by typing `dev-desktop`.

## What it sets up

* [Antigen] - A plugin manager for zsh
* [Composer] - a dependency manager for PHP
* [Homebrew] - for managing operating system libraries
* [Git] - a CVS tool
* [PHP with PHPBrew] - a popular scripting language
* [Symfony Console Autocomplete] - Shell autocompletion for Symfony Console based scripts
* [Vim configuration] - a highly configurable text editor
* [wget] - a tool to retrieves content from web servers
* [zsh] - as the default shell.

[Antigen]: http://antigen.sharats.me/
[Composer]: https://getcomposer.org/
[Homebrew]: http://brew.sh/
[Git]: https://git-scm.com/
[PHP with PHPBrew]: http://phpbrew.github.io/phpbrew/
[Symfony Console Autocomplete]: https://github.com/bamarni/symfony-console-autocomplete
[Vim configuration]: https://www.vim.org/
[wget]: https://www.gnu.org/software/wget/
[zsh]: http://www.zsh.org/

It should take less than 15 minutes to install (depends on your machine and internet connection).



## Credits

This laptop script is inspired by
[monfresh's laptop](https://github.com/monfresh/laptop) script.
