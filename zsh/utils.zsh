# password
alias pswd='ruby -rsecurerandom -e "puts SecureRandom.alphanumeric"|xargs echo -n|pbcopy'

# jira
function _openJiraFromCurrentBranch() {
  # KWS-[0-9]+
  ticket=$(git rev-parse --abbrev-ref HEAD | grep -o 'KWS-[0-9]\+')

  open "https://knowledgework.atlassian.net/browse/$ticket"
}
alias oj=_openJiraFromCurrentBranch
