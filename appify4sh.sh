#!/bin/bash

# GIST Shell Script Source: <https://gist.github.com/mathiasbynens/674099>
# GIST Source Author: Matthias Bynens <https://gist.github.com/mathiasbynens>
# Matthias Bynens  <http://mathiasbynens.be/> version is based on development by
#    Thomas Aylott - Copyright (c) - <http://subtlegradient.com/>
#    see also <https://github.com/subtleGradient/Appify-UI>
#    Source of Thomas Aylott's work was modified by Mathias Bynens

if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]; then cat <<EOF
appify v3.0.1 for Mac OS X - http://mths.be/appify
Creates the simplest possible Mac app from a shell script.
Appify takes a shell script as its first argument:
    `basename "$0"` my-script.sh
Note that you cannot rename appified apps. If you want to give your app
a custom name, use the second argument:
    `basename "$0"` my-script.sh "My App"
Copyright (c) Thomas Aylott <http://subtlegradient.com/>
Modified by Mathias Bynens <http://mathiasbynens.be/>
EOF
exit; fi

APPNAME=${2:-$(basename "$1" ".sh")}
DIR="$APPNAME.app/Contents/MacOS"

if [ -a "$APPNAME.app" ]; then
	echo "$PWD/$APPNAME.app already exists :("
	exit 1
fi

mkdir -p "$DIR"
cp "$1" "$DIR/$APPNAME"
chmod +x "$DIR/$APPNAME"

echo "$PWD/$APPNAME.app"
