function gitpc -d "Git pull-commit"
  # Package entry-point

  # Read the arguments
  set -l opts 'h/help' 'n/remote='
  argparse $opts -- $argv
    
    # Print help
    if set -q _flag_help
      __gitpc_help
      return 0
    end 
  
  # By default, remote name will given as origin
  set -lq _flag_remote; or set -l _flag_remote 'origin'
  __gitpc_main $_flag_remote
end
