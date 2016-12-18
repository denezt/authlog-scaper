#!/bin/bash

__isNice=0
__set_nice=-10
__filename="scrap_attack_info"

rm "${__filename}.csv.base64" && printf "\033[31mRemoved,\033[0m \033[33molder Base64 instance.\033[0m\n"
printf "[ $(date '+%F %T')]\tStarting, Convert to Base64\n"
time for a in `cat ${__filename}.csv | sed 's/\,/ /g' | awk '{ print $2,$3 }' | sed 's/ /|/g'`; do
	case ${__isNice} in
		0) #Renice first.
		renice --priority ${__set_nice} --pid `pgrep $0`
		 __isNice=1
		;;
		*) echo "$a" | base64 >> "${__filename}.csv.base64";;
	esac
done

__uniquity=($(cat  "${__filename}.csv.base64" | sort -u))
rm "${__filename}.csv.base64" && printf "\033[35mStarting to refactor for uniquity\033[0m\n"
for __refactor in ${__uniquity[@]}
do
	printf "$__refactor\n" | tee -a "${__filename}.csv.base64"
done

printf "Results: `cat ${__filename}.csv | sed 's/\,/ /g' | awk '{ print $2,$3 }' | sed 's/ /|/g'  | wc`\n"





