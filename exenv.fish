# SYNOPSIS
#   exenv [options]
#
function init --on-event init_exenv
  if not available exenv
    echo "Please install 'exenv' first!"; return 1
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
end

function uninstall --on-event uninstall_exenv

end
