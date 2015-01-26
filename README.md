bash
====

Scripts for customizing the bash and others terminal tools. Settings for the current user may be included in `~/.bash_profile` and `~/.bash_profile`, that should be sourced from the `~/.bashrc`.

```bash
cat <<EOF >> ~/.bashrc
if [ -f ~/.bash_aliases ] ; then
 . ~/.bash_aliases ;
if [ -f ~/.bash_profile ] ; then
 . ~/.bash_profile ;
 fi
 EOF
```

Alternatively, use `/etc/profile` and `/etc/bashrc` to customize general user's settings.


# `.bash_aliases` [:octocat:](https://github.com/mscastillo/bash/blob/master/.bash_aliases)

This scripts add aliases and defines a color palette that is use in subsequently scripts.


# `.bash_profile` [:octocat:](https://github.com/mscastillo/bash/blob/master/.bash_profile)

This scripts modifies general bash's settings and customizes the terminal interface.


# `.screenrc` [:octocat:](https://github.com/mscastillo/bash/blob/master/.screenrc)

This script will modify the configuration for GNU's [`screen`](http://www.gnu.org/software/screen/).
