function __gitpc_help
  echo "USAGE" 
  echo "  gitpc [OPTION]"\n
  echo "DESCRIPTION"
  echo "  Git pull-commit manager"\n
  echo "OPTIONS"
  echo "  -r, --remote      Remote name (Default: origin)"
  echo "  -s, --stash       Stash method for stashing back (Default: apply)" 
  echo "  -h                Display this help and exit"\n
  echo "EXAMPLE"
  echo "  gitpc --remote=upstream --stash=pop"\n
  echo -e "  For more information visit \e[4mhttps://github.com/adefirmanf/gitpc/"
end