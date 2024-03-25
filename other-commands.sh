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
  pkill -KILL -x TelegramShare Messages\ Share\ Extension ShareExtension
}

function fix-ios-sync () {
  pkill -KILL -x AMPDevicesAgent
}


function fix-gdrive-icon () {
  ## Copy the icon to the Google Drive folder
  sudo cp ~/Documents/Library/Big\ Sur\ Icons/Folders/Google\ Drive\ Folder.icns \
  /Applications/Google\ Drive.app/Contents/Resources/drive_fs.icns
  ## Kill Google Drive app Mail and Thing3
  pkill -KILL -x Google\ Drive Mail Things3
  ## Open Google Drive app
  open -a Google\ Drive
  ## Kill dock and finder
  killall Dock Finder
  open -a Mail
  open -a Things3
}


function pcre2-libs-ln () {
  # Make the necessary symbolic links
  sudo ln -sfn /opt/homebrew/opt/pcre2/lib/libpcre2-8.dylib \
               /opt/homebrew/opt/pcre2/lib/libpcre2-16.dylib \
               /opt/homebrew/opt/pcre2/lib/libpcre2-32.dylib \
               /opt/homebrew/opt/pcre2/lib/libpcre2-posix.dylib \
   /opt/R/arm64/lib/
}


pdfcompress (){
  # This is coming from here: 
  # https://gist.github.com/ahmed-musallam/27de7d7c5ac68ecbd1ed65b6b48416f9
  gs \
 -q -dNOPAUSE -dBATCH -dSAFER \
 -sDEVICE=pdfwrite \
 -dCompatibilityLevel=1.4 \
 -dPDFSETTINGS=/screen \
 -dEmbedAllFonts=true -dSubsetFonts=true \
 -dColorImageDownsampleType=/Bicubic \
 -dColorImageResolution=144 \
 -dGrayImageDownsampleType=/Bicubic \
 -dGrayImageResolution=144 \
 -dMonoImageDownsampleType=/Subsample \
 -dMonoImageResolution=144 \
 -dNOTRANSPARENCY \
 -sOutputFile=${1%.*}.compressed.pdf \
 $1;
}

resume-upload (){
  # Upload my resume to Dropbox for publish on my site 
  rclone copy ~/Documents/Professional/Job\ Hunting/Resume/Luis\ Puerto\ resume.pdf \
  dropbox:Professional/Resume
}

function reset-desktop () {
  # This is a function to reset the desktop after you change icons. 
  # Close Mail and Things before you start. 
  osascript -e 'quit app "Mail"'
  osascript -e 'quit app "Things3"'
  # Killing Dock and Finder to the new icons load properly
  killall Dock Finder
  # Reopening Mail and Things
  sleep 1 # you need to wait a little bit to reopen
  open -a Mail
  open -a Things3
}

function reset-1pw (){
  # This is a function to close and open again 1Password 7. 
  osascript -e 'quit app "1Password 7"'
  open -a 1Password\ 7
}

function reset-dt (){
  # This is a function to close and open again DEVONthink 3. 
  osascript -e 'quit app "DEVONthink 3"'
  open -a DEVONthink\ 3
}


