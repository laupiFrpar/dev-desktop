typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # =========================[ Line #1 ]=========================
  os_icon                 # os identifier
  dir                     # current directory
  vcs                     # git status
  # =========================[ Line #2 ]=========================
  newline
  docker_status
  swift_version           # swift version
  pyenv                   # python environment (https://github.com/pyenv/pyenv)
  node_version            # node.js version
  php_version             # php version (https://www.php.net/)
  symfony_version
  kubecontext             # current kubernetes context (https://kubernetes.io/)
  # =========================[ Line #3 ]=========================
  newline                 # \n
  prompt_char             # prompt symbol
)

# The list of segments shown on the right. Fill it with less important segments.
# Right prompt on the last prompt line (where you are typing your commands) gets
# automatically hidden when the input line reaches it. Right prompt above the
# last prompt line gets hidden if it would overlap with left prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # =========================[ Line #1 ]=========================
  status                  # exit code of the last command
  command_execution_time  # duration of the last command
  background_jobs         # presence of background jobs
  # direnv                  # direnv status (https://direnv.net/)
  # asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
  # virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
  # anaconda                # conda environment (https://conda.io/)
  # goenv                   # go environment (https://github.com/syndbg/goenv)
  # nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
  # nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
  # nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
  # node_version          # node.js version
  # go_version            # go version (https://golang.org)
  # rust_version          # rustc version (https://www.rust-lang.org)
  # dotnet_version        # .NET version (https://dotnet.microsoft.com)
  # php_version           # php version (https://www.php.net/)
  # laravel_version       # laravel php framework version (https://laravel.com/)
  # java_version          # java version (https://www.java.com/)
  # package               # name@version from package.json (https://docs.npmjs.com/files/package.json)
  # rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
  # rvm                     # ruby version from rvm (https://rvm.io)
  # fvm                     # flutter version management (https://github.com/leoafarias/fvm)
  # luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
  # jenv                    # java version from jenv (https://github.com/jenv/jenv)
  # plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
  # perlbrew                # perl version from perlbrew (https://github.com/gugod/App-perlbrew)
  # phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
  # scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
  # haskell_stack           # haskell version from stack (https://haskellstack.org/)
  # kubecontext             # current kubernetes context (https://kubernetes.io/)
  # terraform               # terraform workspace (https://www.terraform.io)
  # terraform_version     # terraform version (https://www.terraform.io)
  # aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
  # aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
  # azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
  # gcloud                  # google cloud cli account and project (https://cloud.google.com/)
  # google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
  # toolbox                 # toolbox name (https://github.com/containers/toolbox)
  # context                 # user@hostname
  # nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
  # ranger                  # ranger shell (https://github.com/ranger/ranger)
  # nnn                     # nnn shell (https://github.com/jarun/nnn)
  # xplr                    # xplr shell (https://github.com/sayanarijit/xplr)
  # vim_shell               # vim shell indicator (:sh)
  # midnight_commander      # midnight commander shell (https://midnight-commander.org/)
  # nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
  # vi_mode               # vi mode (you don't need this if you've enabled prompt_char)
  # vpn_ip                # virtual private network indicator
  # load                  # CPU load
  # disk_usage            # disk usage
  # ram                   # free RAM
  # swap                  # used swap
  # todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
  # timewarrior             # timewarrior tracking status (https://timewarrior.net/)
  # taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
  time                    # current time
  # =========================[ Line #2 ]=========================
  newline                 # \n
  # ip                    # ip address and bandwidth usage for a specified network interface
  # public_ip             # public IP address
  # proxy                 # system-wide http/https/ftp proxy
  battery               # internal battery
  wifi                  # wifi speed
  # example               # example user-defined segment (see prompt_example function below)
  # =========================[ Line #3 ]=========================
  newline                 # \n
)

# DOCKER
# Show Docker status
prompt_docker_status() {
  # if docker daemon isn't running you'll get an error saying it can't connect
  local launched=$(docker info 2>&1 | grep "Cannot connect")

  if [[ -n ${launched} ]]; then
    p10k segment -i '' -f blue -t 'Not launched'
  else
    p10k segment -i '' -f blue -t 'Launched'
  fi
}

# Symfony
# Show Symfony version
prompt_symfony_version() {
  if [ -f app/bootstrap.php.cache ] || [ -f var/bootstrap.php.cache ]; then
    local consoleCommand='symfony console --version'
    local symfony_version='searching'

    eval $consoleCommand >/dev/null

    if [ "$?" -ne 0 ]; then
      if [ -f app/console ]; then
        consoleCommand='app/console --version'
      elif [ -f bin/console ]; then
        consoleCommand='bin/console --version'
      fi
    fi

    eval $consoleCommand >/dev/null

    if [ "$?" -ne 0 ]; then
      symfony_version='error'
    else
      symfony_version=$(eval ${consoleCommand} | egrep -o '([0-9]+\.?){3,}')
    fi

    p10k segment -i '' -f white -t ${symfony_version}
  fi
}

# Swift version
prompt_swift_version() {
  p10k segment -i '' -f 216 -t $(swift -version | awk '{print $4}')
}
