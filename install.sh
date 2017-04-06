fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

append_to_file() {
  local file="$1"
  local text="$2"

  if ! grep -qs "^$text$" "$file"; then
    printf "\n%s\n" "$text" >> "$file"
  fi
}

brew_is_installed() {
  brew list -1 | grep -Fqx "$1"
}

tap_is_installed() {
  brew tap -1 | grep -Fqx "$1"
}

if ! test -e "$HOME/.bash_profile"; then
  touch "$HOME/.bash_profile"
fi

shell_file="$HOME/.bash_profile"

if ! test -d "$HOME/bin"; then
  mkdir "$HOME/bin"
fi

append_to_file "$shell_file" 'export PATH="$HOME/bin:$PATH"'

# Install brew
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
  append_to_file "$shell_file" 'export PATH="/usr/local/bin:$PATH"'
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

# Remove brew-cask since it is now installed as part of brew tap caskroom/cask.
# See https://github.com/caskroom/homebrew-cask/releases/tag/v0.60.0
if brew_is_installed 'brew-cask'; then
  brew uninstall --force 'brew-cask'
fi

if tap_is_installed 'caskroom/versions'; then
  brew untap caskroom/versions
fi

fancy_echo "Updating Homebrew ..."
cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update

fancy_echo "Verifying the Homebrew installation..."
if brew doctor; then
  fancy_echo "Your Homebrew installation is good to go."
else
  fancy_echo "Your Homebrew installation reported some errors or warnings."
  echo "Review the Homebrew messages to see if any action is needed."
fi

fancy_echo "Installing formulas and casks from the Brewfile ..."
if test -e "$HOME/Brewfile"; then
  if brew bundle --file="$HOME/Brewfile"; then
    fancy_echo "All formulas and casks were installed successfully."
  else
    fancy_echo "Some formulas or casks failed to install."
    echo "This is usually due to one of the Mac apps being already installed,"
    echo "in which case, you can ignore these errors."
  fi
fi

# Install Ruby
append_to_file "$HOME/.gemrc" 'gem: --no-document'

# if command -v rbenv >/dev/null || command -v rvm >/dev/null; then
#   fancy_echo 'We recommend chruby and ruby-install over RVM or rbenv'
# else
#   if ! brew_is_installed "chruby"; then
#     fancy_echo 'Installing chruby, ruby-install, and the latest Ruby...'
#
#     brew bundle --file=- <<EOF
#     brew 'chruby'
#     brew 'ruby-install'
# EOF
#
#     append_to_file "$shell_file" 'source /usr/local/share/chruby/chruby.sh'
#     append_to_file "$shell_file" 'source /usr/local/share/chruby/auto.sh'
#
#     ruby-install ruby
#
#     append_to_file "$shell_file" "chruby ruby-$(latest_installed_ruby)"
#
#     switch_to_latest_ruby
#   else
#     brew bundle --file=- <<EOF
#     brew 'chruby'
#     brew 'ruby-install'
# EOF
#     fancy_echo 'Checking if a newer version of Ruby is available...'
#     switch_to_latest_ruby
#
#     ruby-install --latest > /dev/null
#     latest_stable_ruby="$(cat < "$HOME/.cache/ruby-install/ruby/stable.txt" | tail -n1)"
#
#     if ! [ "$latest_stable_ruby" = "$(latest_installed_ruby)" ]; then
#       fancy_echo "Installing latest stable Ruby version: $latest_stable_ruby"
#       ruby-install ruby
#     else
#       fancy_echo 'You have the latest version of Ruby'
#     fi
#   fi
# fi
#
# fancy_echo 'Updating Rubygems...'
# gem update --system
#
# gem_install_or_update 'bundler'
#
# fancy_echo "Configuring Bundler ..."
# number_of_cores=$(sysctl -n hw.ncpu)
# bundle config --global jobs $((number_of_cores - 1))
#
# fancy_echo '...Finished Ruby installation checks.'
#
# no_prompt_customizations_in_shell_file() {
#   ! grep -qs -e "PS1=" -e "precmd" -e "PROMPT=" "$shell_file"
# }
#
# no_zsh_frameworks() {
#   [ ! -d "$HOME/.oh-my-zsh" ] && [ ! -d "$HOME/.zpresto" ] && [ ! -d "$HOME/.zim" ] && [ ! -d "$HOME/.zplug" ]
# }
#
# if [ -z "$CI" ] && no_zsh_frameworks && no_prompt_customizations_in_shell_file; then
#   echo -n "Would you like to customize your prompt to display the current directory and ruby version? [y/n]: "
#   read -r -n 1 response
#   if [ "$response" = "y" ]; then
#     if ! grep -qs "prompt_ruby_info()" "$shell_file"; then
#       cat <<EOT >> "$shell_file"
#
#   prompt_ruby_info() {
#     if [ -f ".ruby-version" ]; then
#       cat .ruby-version
#     fi
#   }
# EOT
#     fi
#     # shellcheck disable=SC2016
#     append_to_file "$shell_file" 'GREEN=$(tput setaf 65)'
#     # shellcheck disable=SC2016
#     append_to_file "$shell_file" 'ORANGE=$(tput setaf 166)'
#     # shellcheck disable=SC2016
#     append_to_file "$shell_file" 'NORMAL=$(tput sgr0)'
#     # display pwd in orange, current ruby version in green,
#     # and set prompt character to $
#     # shellcheck disable=SC2016
#     append_to_file "$shell_file" 'precmd () { PS1="${ORANGE}[%~] ${GREEN}$(prompt_ruby_info) ${NORMAL}$ " }'
#     # display directories and files in different colors when running ls
#     append_to_file "$shell_file" 'export CLICOLOR=1;'
#     append_to_file "$shell_file" 'export LSCOLORS=exfxcxdxbxegedabagacad;'
#   else
#     fancy_echo "Skipping prompt customization."
#   fi
# fi

# Generate ssh for github
# if app_is_installed 'GitHub'; then
#   fancy_echo "It looks like you've already configured your GitHub SSH keys."
#   fancy_echo "If not, you can do it by signing in to the GitHub app on your Mac."
# elif [ ! -f "$HOME/.ssh/github_rsa.pub" ]; then
#   open ~/Applications/GitHub\ Desktop.app
# fi

if [ -f "$HOME/.laptop.local" ]; then
  . "$HOME/.laptop.local"
fi

fancy_echo 'All done!'
# echo "Install RVM..."
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash -s stable
#
# brew_path=$(brew --prefix)
# brew install git git-extras
#
# read -p "Which PHP's version do you want to install ?"