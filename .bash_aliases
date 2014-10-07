## COLORS ######################################################################


   RESET='\e[0;00m'   # reset
   BRESET='\e[0;01m'  # bold reset
   GREY='\e[0;30m'    # grey
   YELLOW='\e[0;33m'  # yellow
   RED='\e[0;31m'     # red
   GREEN='\e[0;32m'   # red
   PURPLE='\e[0;35m'  # prurple
   BWHITE='\e[1;37m'  # bold white
   BGREY='\e[1;30m'   # bold grey
   BYELLOW='\e[1;33m' # bold yellow
   BGREEN='\e[1;32m'  # bold green
   BRED='\e[1;31m'    # bold red
   BBLUE='\e[1;34m'   # bold blue
   BPURPLE='\e[1;35m' # bold prurple
   REDB='\e[41m'      # red background
   YELLOWB='\e[43m'   # yellow background
   
   
## CUSTOM ALIASES ##############################################################


   myla() {
     ls -1 -halp --color=auto $@ ;
     echo "total $(ls -1 -a $@ | wc -l) elements" ;
   }
   alias la='myla'
   myll() {
     ls -1 -hlp --color=auto $@ ;
     echo "total $(ls -1 $@ | wc -l) elements" ;
   }
   alias ll='myll'
   alias l='ll'    # lazy ll
   alias lll='ll'  # swift ll
   myld() {
     ls -1 -hlp -d --color=auto */$@ ;
     echo "total $(ls -1 -d */ $@ | wc -l) elements" ;
   }
   alias ld='myld'
   alias ..='cd ..'
   alias server='ssh -X server.cimr.cam.ac.uk'
   alias server='ssh server.cscr.cam.ac.uk'


## PS1 #########################################################################


   if [[ $STY == "" ]] ; then
     export PS1="\u\[$BWHITE\]@\[$RESET\]\h\[$BWHITE\]:\[$BBLUE\]\w\[$BWHITE\]\$\[$RESET\] "
   else
     SCREENID=$(echo $STY | awk 'BEGIN{FS="."}{print $1}')
     export PS1="\u\[$BWHITE\]@\[$RESET\]\h\[$BGREY\].$SCREENID\[$BWHITE\]:\[$BBLUE\]\w\[$BWHITE\]\$\[$RESET\] "
   fi
   
  
## SCREEN ######################################################################


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


################################################################################
