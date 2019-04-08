function gitpc -d "Git pull-commit"
  # Package entry-point

  # Read the arguments
  set -l opts 'h/help' 'r/remote=' 's/stash='
  argparse $opts -- $argv
    
    # Print help
    if set -q _flag_help
      __gitpc_help
      return 0
    end 
  
  # By default, remote name will given as origin
  set -lq _flag_remote; or set -l _flag_remote 'origin'

  # There are 2 methods for stashing, pop & apply. By default stash used apply
  set -lq _flag_stash; or set -l _flag_stash 'apply'
  __gitpc_main $_flag_remote $_flag_stash
end
