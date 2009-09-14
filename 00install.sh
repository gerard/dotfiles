#!/bin/sh

TO_INSTALL="[a-z]*"
[ $# -gt 0 ] && TO_INSTALL=$*

for file in $TO_INSTALL
do
	[ ! -e $file ] && continue
	dest=$HOME/.$file

    # If the files are the same, don't bother the user
    diff $file $dest > /dev/null && continue

	if [ -e $dest ]; then
		echo -n "$dest already exists. Overwrite? (y/n) "
		read answer
		[ x$answer != "xy" ] && continue
		rm -rf $dest
	fi
	echo "Installing new .$file"
	cp -a $file $HOME/.$file
done
