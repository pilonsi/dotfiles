# Pilonsi's project source file

set sourced=($_)

if ("$sourced" == "") then
	echo "Script must be sourced, not run"
	exit 1
endif

set fullpath=`readlink -f $sourced[2]`
set basepath=`dirname $fullpath`

setenv PATH "${basepath}/bin:${PATH}"

set prompt="(*name*) $prompt"
