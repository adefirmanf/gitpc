function __gitpc_main  
  # set -lx file_changed (git status -s  | grep -c M | cut -d ' ' -f2)
  # set -lx deleted_file (git status -s  | grep -c D | cut -d ' ' -f2)
  # set -lx untracked_file (git status -s  | grep -c U | cut -d ' ' -f2)
  
  set_color 198CFF
  set -l current_remote $argv[1]
  set -l stash_method $argv[2]
  
  # Get the current branch you works on
  set -lx current_branch (git branch | grep \* | cut -d ' ' -f2)
  
  # Check the project files has been modified, new file, or deleted
  if set -l need_stashed (git status | grep -c -E "modified|new|deleted") -ne 0;
  
  # Also check the project if there any commit not pushed yet to remote 
  or set -l total_commit (git cherry -v origin/$current_branch | grep -c +) -ne 0
			git stash
			set_color blue
			echo "Pull..."
			git pull --rebase --progress -q $current_remote $current_branch
			set_color yellow
			git stash $stash_method 1> /dev/null
		else
			echo "Pull..."
			git pull --rebase $current_remote $current_branch
  end  
	# if set -l file_changed (git status -s   | grep -c M | cut -d ' ' -f2) -ne 0; 
  # or set -l deleted_file (git status -s   | grep -c D | cut -d ' ' -f2) -ne 0;
  # or set -l untracked_file (git status -s | grep -c U | cut -d ' ' -f2) -ne 0;
  if set need_stashed
  	git status | grep -E "modified|new|deleted" | column -c -t -s ':' -x
    echo \n
    set_color 84DE02	
    read -l -s -P "Do you want add current files to commit list (If yes, all changes will staged) [y/N] ? > " aopt
      switch $aopt
        case Y y
          git add .
          read -l -s -P "Commit message > " msg
          git commit -m $msg
        case N n
          return 1
    	end
  end

  if set -l total_commit (git cherry -v origin/$current_branch | grep -c +) -ne 0
    set_color blue
    git cherry -v $current_remote/$current_branch
    echo "$total_commit commit need pushed to remote"
    set_color 198CFF
    git cherry -v $current_remote/$current_branch
    read -lsP "Do you want push $total_commit commit to remote branch ($current_remote/$current_branch) [y/N] ? > " opt
      switch $opt
        case Y y 
          git push $current_remote/$current_branch
          set_color 84DE02
          echo "✔ Done"
          return 1
        case N n
          return 1
      end
    end
end