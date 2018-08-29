POWERLEVEL9K_DOCKER_VERSION_BACKGROUND=39
POWERLEVEL9K_DOCKER_VERSION_FOREGROUND=white


# Check if command exists in $PATH
# USAGE:
#   _exists <command>
_exists() {
  command -v $1 > /dev/null 2>&1
}

# DOCKER
# Show current Docker version and connected machine
prompt_docker_version() {
  # if docker daemon isn't running you'll get an error saying it can't connect
  docker info 2>&1 | grep -q "Cannot connect" && return

  local docker_version
  # php_version=$(php -v 2>&1 | grep -oe "^PHP\s*[0-9.]*")
  docker_version=$(docker version -f "{{.Server.Version}}")

  if [[ -n "$php_version" ]]; then
    "$1_prompt_segment" "$0" "$2" "fuchsia" "grey93" "$php_version"
  fi

  local bg_color="${POWERLEVEL9K_DOCKER_BACKGROUND}"
  local fg_color="${POWERLEVEL9K_DOCKER_FOREGROUND}"
  local content="\uf308 v${docker_version} "
  "$1_prompt_segment" "$0" "$2" "${bg_color}" "${fg_color}" "${content}"
}