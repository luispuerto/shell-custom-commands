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
	# echo "\U1F4CC ${RED}==>${NC} Upgrading Casks \U1F373  with 'brew cu -ya' \U1F91E"
	# brew cu -y
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

# Update Python Packages
function up-py-packages () {
	echo "\U1F4CC ${RED}==>${NC} Updating Python \U1F40D Packages \U1F4E6 \U1F91E"
	# pip install --upgrade pip setuptools wheel
	# pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
	pip3 install --upgrade pip setuptools wheel
	pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
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

}
