# To make this function available as a Git alias, add the following
# to your .bashrc or .zshrc:

# Verifies that a branch can be safely deleted before deleting it.
# Even if the branch was squashed and merged on remote repo.
function git-delete-safe() {
  if [ $# -ne 1 ]; then
    echo "Usage: git-delete-safe <branch-name>"
    return 1
  fi

  # Replace 'main' with your default branch name if it's different.
  local branch_to_delete=$1
  local main_branch='main'

  # Check for differences between the branch and 'main'.
  local diff_output=$(git diff ${main_branch}...${branch_to_delete})
  if [ -n "$diff_output" ]; then
    echo "Error: There are differences between '${main_branch}' and '${branch_to_delete}'"
    return 1
  else
    # Force-delete the branch if there are no differences.
    git branch -D ${branch_to_delete}
    echo "Branch '${branch_to_delete}' has been deleted."
  fi
}

alias gitbds='git-delete-safe'
alias gitbn='git checkout -b'
alias gits='git status'
alias gitc='git commit -m'
alias gita='git add'
alias gitpoh='git push origin head'
