## COLORS ##############################################################

# RESET
  RESET='\e[0;00m' # reset
  BRESET='\e[0;01m' # bold reset
# COLORS
  GREY='\e[0;30m' # grey
  YELLOW='\e[0;33m' # yellow
  RED='\e[0;31m' # red
  GREEN='\e[0;32m' # green
  PURPLE='\e[0;35m' # prurple
# BOLD
  BWHITE='\e[1;37m' # bold white
  BGREY='\e[1;30m' # bold grey
  BYELLOW='\e[1;33m' # bold yellow
  BGREEN='\e[1;32m' # bold green
  BRED='\e[1;31m' # bold red
  BBLUE='\e[1;34m' # bold blue
  BPURPLE='\e[1;35m' # bold prurple
# BACKGROUND
  REDB='\e[41m' # red background
  YELLOWB='\e[43m' # yellow background

   
## CUSTOM ALIASES ##############################################################

   myla() {
     ls -1 -halp --color=auto $@ ;
     echo "total $(ls -1 -a $@ | wc -l) elements" ;
   }
   alias la='myla'
   
   mylt() {
     ls -1 -halpt --color=auto $@ ;
     echo "total $(ls -1 -a $@ | wc -l) elements" ;
   }
   alias lt='mylt'
   
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
   alias grep='grep --color'
   alias tree='tree -C'
