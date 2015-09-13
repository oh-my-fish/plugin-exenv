function __fish_exenv_using_command
  set cmd (commandline -opc)
  set subcommands $argv
  if [ (count $cmd) = (math (count $subcommands) + 1) ]
    for i in (seq (count $subcommands))
      if not test $subcommands[$i] = $cmd[(math $i + 1)]
        return 1
      end
    end
    return 0
  end
  return 1
end

# Find installed versions by looking in the file system
function __fish_exenv_installed_versions
  ls (exenv root)/versions | sort
end

# Find available versions to install. Requires the elixir-build plugin
function __fish_exenv_install_available_versions
  exenv install -l|grep "[0-9]" | sed 's/^\ *//g' | sort
end

# Base commands
complete -f -c exenv -a commands    -d "List all exenv commands"
complete -f -c exenv -a rehash      -d "Rehash exenv shims (run this after installing binaries)"
complete -f -c exenv -a global      -d "Set or show the global Elixir version"
complete -f -c exenv -n '__fish_exenv_using_command global' -a '(__fish_exenv_installed_versions)' -d "Set or show the global Elixir version"
complete -f -c exenv -a local       -d "Set or show the local directory-specific Elixir version"
complete -f -c exenv -n '__fish_exenv_using_command local' -a '(__fish_exenv_installed_versions)' -d "Set or show the local directory-specific Elixir version"
complete -f -c exenv -a shell       -d "Set or show the shell-specific Elixir version"
complete -f -c exenv -a version     -d "Show the current Elixir version"
complete -f -c exenv -a versions    -d "List all Elixir versions known by exenv"
complete -f -c exenv -a which       -d "Show the full path for the given Elixir command"

# Installer plugin
complete -f -c exenv -a install -d "Install an Elixir version"
complete -f -c exenv -n '__fish_exenv_using_command install' -s l -l list -d "List all available versions"
complete -f -c exenv -n '__fish_exenv_using_command install' -s k -l keep -d "Keep source tree in $EXENV_BUILD_ROOT after installation"
complete -f -c exenv -n '__fish_exenv_using_command install' -s v -l verbose -d "Verbose mode: print compilation status to stdout"
complete -f -c exenv -n '__fish_exenv_using_command install' -s a -l add -d "Adds version with given sha into list of available versions"
complete -f -c exenv -n '__fish_exenv_using_command install' -a '(__fish_exenv_install_available_versions)' -d "Install an Elixir version"
complete -f -c exenv -a uninstall -d "Uninstall an Elixir version"
complete -f -c exenv -n '__fish_exenv_using_command uninstall' -s f -d "Attempt to remove the specified version without prompting for confirmation."
complete -f -c exenv -n '__fish_exenv_using_command uninstall' -a '(__fish_exenv_installed_versions)' -d "Uninstall an Elixir version"
