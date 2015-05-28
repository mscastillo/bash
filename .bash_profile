## PS1 #########################################################################
#  It depends on colors as defined in ~/.bash_aliases

   if [[ $STY == "" ]] ; then
     export PS1="\u\[$BWHITE\]@\[$RESET\]\h\[$BWHITE\]:\[$BBLUE\]\w\[$BWHITE\]\$\[$RESET\] "
   else
     SCREENID=$(echo $STY | awk 'BEGIN{FS="."}{print $1}')
     export PS1="\u\[$BWHITE\]@\[$RESET\]\h\[$BGREY\].$SCREENID\[$BWHITE\]:\[$BBLUE\]\w\[$BWHITE\]\$\[$RESET\] "
   fi

  
## DISK USAGE ##################################################################

 # The following notifications will be shown only on non screened sessions
 if [[ $STY == "" ]] ; then
 # blank line before notifications
   echo
 # monitor disks file system
   df -h &> ~/.df.report
   DISK=($(cat ~/.df.report | grep -v "denied" | awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $1}'))
   SIZE=($(cat ~/.df.report | grep -v "denied" | awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $2}'))
   USED=($(cat ~/.df.report | grep -v "denied"| awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $3}'))
   AVAILABLE=($(cat ~/.df.report | grep -v "denied" | awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $4}'))
   PERCENT=($(cat ~/.df.report | grep -v "denied" | awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $5}' | tr "%" " "))
   MOUNTED=($(cat ~/.df.report | grep -v "denied" | awk 'NF==1{s=$0;getline;$1=$1;print s,$0;next}1' | column -t | awk '{print $6}'))
   echo -e $BWHITE "Disk"$'\t'"Mount"$'\t'"Used/Size"$'\t' "Free"$RESET > ~/.df.report
   SWITCH=OFF
   for k in $( seq 1 $((${#PERCENT[@]} - 1)) ) ; do
     if [[ ${PERCENT[$k]} -gt 85 ]] ; then
        echo -e $RED ${DISK[$k]}$'\t'${MOUNTED[$k]}$'\t'${USED[$k]}"/"${SIZE[$k]}$'\t'$BRED $((100-${PERCENT[$k]}))"%"$RED "("${AVAILABLE[$k]}")" $RESET >> ~/.df.report
        SWITCH=ON
      elif [[ ${PERCENT[$k]} -lt 75 ]] ; then	
        echo -e $RESET ${DISK[$k]}$'\t'${MOUNTED[$k]}$'\t'${USED[$k]}"/"${SIZE[$k]}$'\t'$RESET $((100-${PERCENT[$k]}))"%"$RESET "("${AVAILABLE[$k]}")" $RESET  >> ~/.df.report
      else
       echo -e $YELLOW ${DISK[$k]}$'\t'${MOUNTED[$k]}$'\t'${USED[$k]}"/"${SIZE[$k]}$'\t'$BYELLOW $((100-${PERCENT[$k]}))"%"$YELLOW "("${AVAILABLE[$k]}")" $RESET  >> ~/.df.report
       SWITCH=ON
     fi
   done
   if [[ $SWITCH == "ON" ]] ; then
     echo -e $BRESET$REDB "WARNING"! $RESET$BRED "any of your disk is running out of space"$RESET
     cat ~/.df.report | awk -F"," '!_[$1]++' | column -t -s $'\t'
     echo
   fi
   rm -f ~/.df.report
 # notify detached screens
   if [[ $( screen -ls | grep -e "Detached" | wc -l ) > 0 ]] ; then
     echo -e $BRESET$YELLOWB "NOTICE"! $RESET$BYELLOW "you have detached screens"$RESET
     screen -ls | grep -e "Detached" | column -t | awk '{print "  ",$0}'
     echo
   fi
 fi

## RSS WIDGET ####################################################################################

source ~/.bash_rssreader
