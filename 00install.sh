#!/bin/sh

TO_INSTALL="[a-z]*"
[ $# -gt 0 ] && TO_INSTALL=$*

for file in $TO_INSTALL ; do
    if [ -f $file ] ; then
        ln -sf `pwd`/$file $HOME/.$file
    elif [ -d $file ] ; then
        for subfile in $file/* ; do
            [ ! -f $subfile ] && continue
            mkdir -p $HOME/.$file
            ln -sf `pwd`/$subfile $HOME/.$subfile
        done
    fi
done

