#!/bin/sh

for file in [a-z]*
do
	dest=$HOME/.$file
	if [ -e $dest ]; then
		echo -n "$dest already exists. Overwrite? (y/n) "
		read answer
		[ x$answer != "xy" ] && continue
		rm -rf $dest
	fi
	echo "Installing new .$file"
	cp -a $file $HOME/.$file
done
