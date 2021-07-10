# Appify UI

Create Mac apps.  
Use HTML5 for the UI.  
Script it with anything.  
Can not possibly be simpler.


## What is this?
A Mac app is essentially just an executable file in a folder along with a config file.
That's all that is required.

An Appify UI app is

1. A folder structure
    * That conforms to the Cocoa Application Bundle standard
2. A config file
3. A shell script
4. A compiled binary  
    * To load the interface
5. An interface  
    * A compiled nib file with a single WebKit WebView
6. A url


## Appify UI.app
The application `Appify UI.app` is a
* shell script that accepts arguments from an HTML form.
* It creates a new Appify UI app on your Desktop with the configuration you provide.
* If you improve `Appify UI.app` please fork from the original repository and create pull requests for the source repository so that the source repository gets the improvements. eagerly accepted.

## Appify for Shell [`appify4sh.sh`](https://github.com/niebert/Appify4Node/blob/master/appify4sh.sh)
The script [appify4sh.sh - added to repository](https://github.com/niebert/Appify4Node/blob/master/appify4sh.sh) is a script that creates a MacOSX application from a given shell script. The `appify4sh.sh` takes a shell script as input parameter e.g. `start_my_editor.sh` and creates a MacOSX application from the shell script. The steps in detail are
* Check if the script `appify4sh.sh` has got a parameter e.g. `sh appify4sh.sh start_my_editor.sh` 
* then it checks if the an application with that name already exists, to avoid that you overwrite existing MacOSX applicaations
* finally it creates a package file for you that defines which application should be started when you click on the generated MacOSX icon is the operating system.

### Possible Improvements of [`appify4sh.sh`](https://github.com/niebert/Appify4Node/blob/master/appify4sh.sh)
* provide a second parameter that provides an optional name of the App e.g. 
    sh appify4sh.sh -s start_my_editor.sh -n "My new Editor"
* provide a third parameter to the script that could define the icon of the App (e.g. a [Creative Commons icon](https://github.com/niebert/icons4menu) and you select e.g. an [editor icon `edit.svg`](https://github.com/niebert/icons4menu#miscellaneous-icons) )
    sh appify4sh.sh -s start_my_editor.sh -i "/icons4menu/img/icons-svg/edit.svg"

### Handle arguments with a dash parameter
If you look at the following code you will learn how to handle shell script parameters with a leading dash - e.g. `-i my_icon.svg`
```shell
#! /bin/sh -
PROGNAME=$0

usage() {
  cat << EOF >&2
Usage: $PROGNAME -s <script> [-n <name>] [-i <icon>] [-v]
 e.g. script could by "bin/my_editor_script.sh"
 -s <script>:    script that is started if you want to execute the application 
 -n <appname>:   (optional) set the name of the application 
                 otherwise script name will be used
 -i <path2icon>: provide the path to icon otherwise
                 default will be used
       -v: ...
EOF
  exit 1
}

appname=" file=default_file verbose_level=0
while getopts s:n:i o; do
  case $o in
    (n) appname=$OPTARG;;
    (s) script=$OPTARG;;
    (i) path2icon=$OPTARG;;
    (v) verbose_level=$((verbose_level + 1));;
    (*) usage
  esac
done
shift "$((OPTIND - 1))"

echo "Now perform the appify process or terminate the script if errors occur"
# The appify could will be added below this line
```


### Acknowledgements [`appify4sh.sh`](https://github.com/niebert/Appify4Node/blob/master/appify4sh.sh)
* the GIST Shell Script Source of the script is https://gist.github.com/mathiasbynens/674099
* GIST Source Author:  [Matthias Bynens](http://mathiasbynens.be/) https://gist.github.com/mathiasbynens
* [Matthias Bynens](http://mathiasbynens.be/) version is based on development by [Thomas Aylott](http://subtlegradient.com/) - Copyright (c) - <http://subtlegradient.com/> see also <https://github.com/subtleGradient/Appify-UI>
* Source of Thomas Aylott's work was modified by [Matthias Bynens](http://mathiasbynens.be/)

Appify UI Node Demo.app
-----------------------
Instead of just a bash script, this uses node.js.  
If `node` is not found, it quits and opens the node.js download page in your default web browser.  
Before launching the webview, it starts up an http server.  
When the app is closed, it closes the http server.

To create your own node.js based Mac app...

1. Duplicate `Appify UI Node Demo.app` and give it whatever name you like
    * e.g. `My Awesome App.app`
2. Edit `My Awesome App.app/Contents/Info.plist`
    * Each app needs a unique `CFBundleIdentifier` or else *Bad Things* may happen
3. Replace the folder `My Awesome App.app/Contents/Resources/app` with your own node.js app
4. Make sure that `My Awesome App.app/Contents/Resources/app/server.js` exports something with a `listen` method


### How to package a Node.js Mac app for distribution

You could send it around as-is. By default it'll open their web browser and prompt them to install node.js if it's not already installed.

You could probly also package the `node` binary in the app. I haven't tried this, so please update this README once you do.



How to modify the `nib` and cocoa binary
----------------------------------------
The current version uses a heavily modified version of Apache Callback Mac (formerly PhoneGap-mac / MacGap).
It's about as simple as you can get.

I may update this section later.




Similar Projects
----------------

https://github.com/maccman/macgap is probably what you should be using.

https://github.com/rogerwang/node-webkit is awesome, but large.

https://github.com/sveinbjornt/Platypus makes an app from terminal script, wraps it's output in the GUI window, handles `CMD`+`Q` etc
