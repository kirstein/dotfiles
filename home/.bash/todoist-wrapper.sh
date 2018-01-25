#!/bin/zsh -f

function trim(){
  # remove leading whitespace characters
  local var="${@#"${@%%[![:space:]]*}"}"
  # remove trailing whitespace characters
  local var="${var%"${var##*[![:space:]]}"}"
  echo $var
}

function sessions() {
  local projects=$(todoist projects)
  echo "NULL unset session"
  echo $projects
}

function prios() {
  cat <<EOT
  1 - important, urgent
  2 - important, not urgent
  3 - not important, but urgent
  4 - not important, not urgent
EOT
}

function logcreate() {
  cat <<EOT
  [CREATED ISSUE]: $1 | $2 | ${@:3}
EOT
}

function setsession() {
  echo $@ > $SESSION_FILE
}

function list() {
  todoist l | sort -k2,2 -k1,1
}

SESSION_FILE="$HOME/.todoist.session"
[ ! -f "$SESSION_FILE" ] && touch $SESSION_FILE
SESSION=$(cat $SESSION_FILE)

case "$1" in
  "l"|"list")
    todoist l | fzf
    ;;

  "c"|"close")
    local issue=$(list | fzf)
    if [[ -z $issue ]]; then
      return
    fi
    todoist c $(echo $issue | awk '{ print $1 }')
    echo "[CLOSED ISSUE]: $issue"
    ;;

  "d"|"del")
    local issue=$(list | fzf)
    if [[ -z $issue ]]; then
      return
    fi
    todoist d $(echo $issue | awk '{ print $1 }')
    echo "[DELETED ISSUE]: $issue"
    ;;

  "a"|"add")
    if [[ -z ${@:2} ]]; then
      echo "missing todoist item title"
      return
    fi
    local priority=$(prios | fzf)
    local project=$(todoist projects | fzf)
    if [[ -z $priority || -z $project ]]; then
      return
    fi
    shift
    todoist a --priority=$(echo $priority | awk '{print $1}') --project-id=$(echo $project | awk '{print $1}') "$(echo $@)"
    logcreate $project $priority "$@"
    ;;

  "p"|"prio")
    local issue=$(list | fzf)
    local priority=$(prios | fzf)
    if [[ -z $priority || -z $issue ]]; then
      return
    fi
    todoist modify --priority=$(echo $priority | awk '{print $1}') $(echo $issue | awk '{print $1}')
    echo "[CHANGED PRIORITY]: $(trim $(echo $issue | cut -d' ' -f5-)) | $priority"
    ;;

  "s"|"session")
    local project=$(sessions | fzf)
    if [[ -z $project ]]; then
      return
    fi
    local key=$(echo $project | awk '{print $1}')
    if [[ $key == 'NULL' ]]; then
      echo "[SESSION UNSET]"
      setsession ""
    else
      echo "[SESSION SWITCHED] $project"
      setsession $project
    fi
    ;;

  "show")
    local issue=$(list | fzf)
    if [[ -z $issue ]]; then
      return
    fi
    todoist show $(echo $issue | awk '{ print $1 }')
    ;;

  "active")
    if [ -z $SESSION ]; then
      return
    fi
    local project=${$(echo $SESSION | awk '{print $2}')#?}
    local active=$(trim $(list | grep $project | head -n1))
    echo $(echo $active | cut -d' ' -f4- | awk '{ print tolower($0) }')
    ;;

  *)
    todoist $@
    ;;
esac
