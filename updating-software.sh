#!/usr/bin/env bash

# These are my collection of custom commands for terminal. 
# They are mainly to update software I use. 

# Color Variables

RED='\033[0;31m'
NC='\033[0m' # No Color

# Update Homebrew
function up-brew () {
	echo "\U1F4CC ${RED}==>${NC} Updating Homebrew \U1F37A  with 'brew update' \U1F91E"
	brew update
	echo "\U1F4CC ${RED}==>${NC} Upgrading Homebrew \U1F37A  with 'brew upgrade' \U1F91E"
	brew upgrade
	echo "\U1F4CC ${RED}==>${NC} Cleaning \U1F9FD  with 'brew cleanup' \U1F91E"
	brew cleanup
}

# Update R Packages
function up-r-packages () {
	echo "\U1F4CC ${RED}==>${NC} Checking for new R packages \U1F4E6  \U1F91E"
	if [ ! "$(Rscript --vanilla -e "old.packages(repos = 'cloud.r-project.org')")" = NULL ]; then
		echo "\U1F4CC ${RED}==>${NC} The following R packages are outdated \U1F4DC"
    Rscript --vanilla -e "as.data.frame(old.packages(repos = 'cloud.r-project.org'))[,c(3,5,4)]"
		echo "\U1F4CC ${RED}==>${NC} Upgrading / building... \U1F3D7"
		Rscript --vanilla -e "update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)"

	else 
		echo "\U1F4CC ${RED}==>${NC} Nothing to update \U1F603"
	fi 
}

# Update all
function up-all () {
	up-brew
	up-r-packages
	echo "\U1F4CC ${RED}==>${NC} Updating Ruby \U1F48E  gems \U1F91E"
	gem update 
	# up-py-packages
	echo "\U1F4CC ${RED}==>${NC} updating macOS Apps in the App Mac Store \U1F5A5  \U1F91E"
	mas upgrade
	echo "\U1F4CC ${RED}==>${NC} updating macOS System \U1F5A5  \U1F91E"
	softwareupdate -i -a
}

# Link openBLAS to R binary
function r-openblas () {
  ln -sf \
    /usr/local/opt/openblas/lib/libopenblas.0.dylib \
    /Library/Frameworks/R.framework/Resources/lib/libRblas.dylib 
}

# Reinstall command line tools
function command-line-tools-reinstall {
  sudo rm -rf /Library/Developer/CommandLineTools
  xcode-select --install
}
