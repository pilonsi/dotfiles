#!/bin/sh
# Deploy dotfiles in a new system

systems=("macos" "debian" "illumos" "freebsd" "msys")

parse_error() {
  printf "Usage: ${0} deploy | acquire <system> [-d]\n" 
  printf "Where system must be one of the following:\n"
  for system in ${systems[@]}; do
    printf "$system "
  done
  printf "\n\n"
  printf "  -d: Dry-run. Only lists changes to be made.\n"
  exit 1
}

runcmd() {
  echo "$1"
  if ! [ $dry_run ]; then
    eval "$1"
  fi
}

if [ $# -lt 2 ]; then
  parse_error
elif ! echo "deploy acquire" | grep -qw "$1"; then
  parse_error
elif ! echo "${systems[*]}" | grep -qw "$2"; then
  parse_error
fi

if [ "$3" = "-d" ]; then
  dry_run=true
fi

if ! [ $dry_run ]; then
  printf "This script will ${1} all files for ${2} and will overwrite any \
files in the destination folders. This action is irreversible\nDo you \
wish to proceed? (y/n)\c"
  read proceed
  if [ "$proceed" != "Y" ] && [ "$proceed" != "y" ]; then
    printf "Aborting\n"
    exit 0
  fi
fi

install_subdirs=("common" "$2")

cd $(dirname "$0")

for subdir in ${install_subdirs[@]}; do
  dir="./dotfiles/${subdir}"
  ls -1 $dir | while read -r item; do
    if [ "$1" = "deploy" ]; then
      if [ -d "${dir}/${item}" ]; then
        runcmd "rm -r ${HOME}/.${item}/"
        runcmd "cp -r ${dir}/${item}/ ${HOME}/.${item}/"
      else
        runcmd "cp ${dir}/${item} ${HOME}/.${item}"
      fi
    else
      if [ -d "${HOME}/.${item}" ]; then
        runcmd "rm -r ${dir}/${item}/"
        runcmd "cp -r ${HOME}/.${item}/ ${dir}/${item}/"
      else
        runcmd "cp ${HOME}/.${item} ${dir}/${item}"
      fi
    fi
  done
done

if [ "$1" = "deploy" ]; then
  runcmd "rm -r ${HOME}/bin/"
  runcmd "cp -r bin/ ${HOME}/bin/"
else
  runcmd "rm -r bin/"
  runcmd "cp -r ${HOME}/bin/ bin/"
fi

printf "\nCompleted ${1} for ${2}\n"
if [ $dry_run ]; then
  printf "The -d option was used, so no changes have been made to the filesystem\n"
fi

