#!/bin/bash

function format_host() {
  local len=${#1} 
  local target_len=30
  if [[ $len -gt $target_len ]]; then
    echo "${1:0:$target_len}..."
  fi
  echo $1
}

function parent_ssh() {
  if [[ ! $1 ]]; then
    return
  fi
  local cmd=$(ps -p $1 | tail -n +2 | awk '{print $4}')
  if [[ $cmd == 'ssh' ]]; then
    echo $1
  else
    echo $(parent_ssh `pgrep -P $1`)
  fi
}

function print_host() {
  local host=""
  if [[ $1 ]]; then
    host=$(ps -p $1 | tail -n +2 | awk '{print substr($0, index($0,$4))}') 
  else 
    host=$(pgrep -flP `tmux display-message -p "#{pane_pid}"`) 
  fi
  format_host $(echo $host | perl -ne '/.*\s.+@(.+)\s?\s/ && print "$1";')
}

function fetch_host() {
  local cmd=$(tmux display-message -p "#{pane_current_command}")
  # If the first command is ssh just display the result
  if [[ $cmd == 'ssh' ]]; then
    print_host
  else 
    local pid=$(parent_ssh `tmux display-message -p "#{pane_pid}"`)
    if [[ $pid ]]; then
      print_host $pid
    fi
  fi
}

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  fetch_host
fi
