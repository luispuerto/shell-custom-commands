#!/usr/bin/env bash

# These are some additional commands I've create for my system. 

# Easy use of sublimerge3 tool as a wide system diff tool

# function subldiff () {
# 	# subl -n $1 $2 --command "sublimerge_diff_views"
# }

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

function fix-mail-app () {

  FILE=${HOME}"/Library/Application Support/Mail/Plug-ins/Bundles"
  FILE+="/Library/Mail/Bundles/"
  FILE+="Properties.plist"

  pkill -x Mail
  rm -f ${FILE}
  open -a Mail 
}

function fix-share-services () {
  pkill -KILL -x TelegramShare Messages\ Share\ Extension
}

function fix-ios-sync () {
  pkill -KILL -x AMPDevicesAgent
}


function fix-gdrive-icon () {
  ## Copy the icon to the Google Drive folder
  sudo cp ~/Documents/Library/Big\ Sur\ Icons/Folders/Google\ Drive\ Folder.icns \
  /Applications/Google\ Drive.app/Contents/Resources/drive_fs.icns
  ## Kill Google Drive app
  pkill -KILL -x Google\ Drive
  ## Open Google Drive app
  open -a Google\ Drive
  ## Kill dock and finder
  killall Dock Finder
}