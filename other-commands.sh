#!/usr/bin/env bash

# These are some additional commands I've create for my system. 

# Easy use of sublimerge3 tool as a wide system diff tool

function subldiff () {
	subl -n $1 $2 --command "sublimerge_diff_views"
}

function reset-bluetooth () {
	blueutil -p 0
	sleep 1
	blueutil -p 1
}

function reset-sound () {
  local coreaudiod=/System/Library/LaunchDaemons/com.apple.audio.coreaudiod.plist
  sudo launchctl unload $coreaudiod
  sudo launchctl load $coreaudiod
}

# function fix-mail-app () {

#   FILE="/Users/lpuerto/Library/Containers/com.apple.mail/Data/DataVaults"
#   FILE+="/MailBundles/Library/Mail/Bundles/Properties.plist"

#   rm -fr $FILE
# }
