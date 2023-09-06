#!/bin/sh
# Deploy dotfiles in a new system

systems=("macos" "debian" "illumos" "freebsd" "msys")

parse_error() {
  printf "Usage: ${0} deploy | acquire <system>\n" 
  printf "Where system must be one of the following:\n"
  for system in ${systems[@]}; do
    printf "$system "
  done
  printf "\n"
  exit 1
}

if [ $# -lt 2 ]; then
  parse_error
elif ! echo "deploy acquire" | grep -qw "$1"; then
  parse_error
elif ! echo "${systems[*]}" | grep -qw "$2"; then
  parse_error
fi

printf "This script will ${1} all files for ${2} and will overwrite any \
files in the destination folders. This action is irreversible\nDo you \
wish to proceed? (y/n)\c"
read proceed
if [ "$proceed" != "Y" ] && [ "$proceed" != "y" ]; then
  printf "Aborting\n"
  exit 0
fi

install_subdirs=("common" "$2")

cd $(dirname "$0")

for subdir in ${install_subdirs[@]}; do
  dir="./dotfiles/${subdir}"
  ls -1 $dir | while read -r item; do
    if [ "$1" = "deploy" ]; then
      if [ -d "${dir}/${item}" ]; then
        echo "${dir}/${item}/ -> ${HOME}/.${item}/"
        cp -r ${dir}/${item}/ ${HOME}/.${item}/
      else
        echo "${dir}/${item} -> ${HOME}/.${item}"
        cp ${dir}/${item} ${HOME}/.${item}
      fi
    else
      if [ -d "${HOME}/.${item}" ]; then
        echo "${HOME}/.${item}/ -> ${dir}/${item}/"
        cp -r ${HOME}/.${item}/ ${dir}/${item}/
      else
        echo "${HOME}/.${item} -> ${dir}/${item}"
        cp ${HOME}/.${item} ${dir}/${item}
      fi
    fi
  done
done

if [ "$1" = "deploy" ]; then
  echo "bin/ -> ${HOME}/bin/"
  cp -r bin/ ${HOME}/bin/
else
  echo "${HOME}/bin/ -> bin/"
  cp -r ${HOME}/bin/ bin/
fi

printf "\nCompleted ${1} for ${2}\n"
exit 0
