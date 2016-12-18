#!/bin/bash

__isNice=0
__set_nice=-10
__filename="scrap_attack_info"

printf "[ $(date '+%F %T') ]\tStarting, Convert from Base64\n"
base64 --decode "${__filename}.csv.base64" >> "${__filename}.mdata"





