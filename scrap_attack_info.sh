#!/bin/bash
#
#
#

__option=$1

__logfiles=(`find * -type f | grep "log"`)
csvfile='scrap_attack_info.csv'

scrap_attack(){
	__counter=0
	case $_type in
		-c) printf '' > $csvfile
		printf "id,username,ipaddr\n"
		;;
	esac
	for logfile in ${__logfiles[@]}
	do
		for i in `grep 'Invalid' $logfile | awk '{ print $8, $10}' | tr ' ' ','`
		do
			__counter=$((__counter+1)) && echo "$__counter,$i";
		done
	done
	}

get_metadata(){
	for __file in 'scrap_attack_info.csv';
	do
		stat $__file;
		wc $__file;
	done
	}

help_menu(){
	printf "\033[35mScapy Authlogs\033[0m\n"
	printf "\033[33mCreate New Dataset\033[0m\t\033[32m[ -c, --c, -create, --create ]\033[0m\n"
	printf "\033[33mAppend To Dataset\033[0m\t\033[32m[ -a, --a, -append, --append ]\033[0m\n"
	printf "\033[33mGet Metadata\033[0m\t\t\033[32m[ -m, --m, -metadata, --metadata ]\033[0m\n"
	printf "\033[33mHelp Menu\033[0m\t\t\033[32m[ -h, --h, -help, --help ]\033[0m\n"
	}

case $__option in
	-c|--c|-create|--create)
	scrap_attack -c >> $csvfile
	get_metadata
	;;
	-a|--a|-append|--append)
	scrap_attack -a >> $csvfile
	get_metadata
	;;
	-m|--m|-metata|--metadata)
	get_metadata
	;;
	-h|--h|-help|--help)
	help_menu
	;;
	*) printf "\033[33mError:\033[0m \033[31mMissing or invalid parameter was entered!\033[0m\n";;
esac
