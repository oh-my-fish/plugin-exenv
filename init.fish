# SYNOPSIS
#   exenv [options]
#
if not type --quiet "exenv"
  echo "WARNING: you loaded the fish-shell plugin for exenv, but exenv is not installed."
end

if status --is-interactive
  if exenv init - | grep --quiet "function"
    source (exenv init - | psub)
  else

    if not set -q EXENV_ROOT
      set -x EXENV_ROOT "$HOME/.exenv"
    end

    set PATH "$EXENV_ROOT/shims" $PATH

    function ndenv -d "Elixir version manager"
      set command $argv[1]
      set -e argv[1]
      switch "$command"
        case shell
          eval (ndenv "sh-$command" $argv)
        case '*'
          command ndenv "$command" $argv
      end
    end
  end
end
