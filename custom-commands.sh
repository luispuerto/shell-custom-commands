#!/usr/bin/env bash

# These are my collection of custom commands for terminal. 
# They are mainly to update software I use. 

# Color Variables

RED='\033[0;31m'
NC='\033[0m' # No Color

# Update Homebrew
function up-brew () {
	echo "\U1F4CC ${RED}==>${NC} brew update \U1F91E"
	brew update
	echo "\U1F4CC ${RED}==>${NC} brew upgrade \U1F91E"
	brew upgrade
	echo "\U1F4CC ${RED}==>${NC} brew cu -ya \U1F91E"
	brew cu -ya
	echo "\U1F4CC ${RED}==>${NC} brew cleanup \U1F91E"
	brew cleanup
}

# Update R Packages
function up-r-packages () {
	echo "\U1F4CC ${RED}==>${NC} Rscript --vanilla -e \"update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)\" \U1F91E"
	Rscript --vanilla -e "update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)"
}

# Update gems
function up-gems () {
	echo "\U1F4CC ${RED}==>${NC} Updating Ruby gems \U1F91E"
	gem update
}

# Update Python Packages
function up-py-packages () {
	echo "\U1F4CC ${RED}==>${NC} Updating Python Packages \U1F91E"
	pip install --upgrade pip setuptools wheel
	pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
	pip3 install --upgrade pip setuptools wheel
	pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

# Update all
function up-all () {
	up-brew
	up-r-packages
	up-gems
	up-py-packages
	echo "\U1F4CC ${RED}==>${NC} updating macOS Apps in the App Mac Store \U1F91E"
	mas upgrade
	echo "\U1F4CC ${RED}==>${NC} updating macOS System \U1F91E"
	softwareupdate -i -a
}

# Reinstall R
function reinstall-r () {

	# Uninstalling R & Cairo
	echo "\U1F4CC ${RED}==>${NC}  Uninstalling R & Cairo \U1F91E"
	brew uninstall R cairo 
	brew uninstall sethrfore/r-srf/cairo
	brew uninstall sethrfore/r-srf/r
	
	# Installing Cairo
	echo "\U1F4CC ${RED}==>${NC} Installing Cairo \U1F91E"
	brew install sethrfore/r-srf/cairo
	
	# Installing R
	echo "\U1F4CC ${RED}==>${NC} Installing R with openblas, java, libtiff and cairo \U1F91E"
	echo "\U1F3D7 ${RED}==>${NC} Building... \U1F3D7"
	brew install sethrfore/r-srf/r --with-openblas --with-java --with-libtiff --with-cairo
}

# Reinstall QGIS 
function reinstall-qgis () {
	
	# Uninstall previous 
	echo "\U1F4CC ${RED}==>${NC} Uninstalling QGIS \U1F91E"
	brew uninstall qgis
	
	# Remove the cache 
	echo "\U1F4CC ${RED}==>${NC} Removing cache \U1F91E"
	rm -rf $(brew --cache)

	# Unlink and link Python
	echo "\U1F4CC ${RED}==>${NC} Unlink and link Python \U1F91E"
	brew unlink python
	brew link --force python

	# Installing QGIS 
	echo "\U1F4CC ${RED}==>${NC} Installing QGIS with grass, saga, r, orfeo, qspatialite, lastools, liblas, "
	echo "szip, taudem, whitebox and mssql"
	echo "\U1F91E\U1F91E\U1F91E\U1F91E\U1F91E\U1F340\U1F340\U1F340\U1F340\U1F340"
	echo "\e[3mMay the force be with you!\e[0m"
	echo "psss! Building time around 20' to 40'. You better get a coffee \U2615 or beer \U1F37A, and relax \U1F6CB"
	echo "\U1F4CC ${RED}==>${NC} Building... \U1F3D7"
	brew install qgis \
		--with-grass \
		--with-saga \
		--with-r \
		--with-orfeo \
		--with-qspatialite \
		--with-lastools \
		--with-liblas \
		--with-szip \
		--with-taudem \
		--with-whitebox \
		--with-mssql

	# Moving the app to Applications and creating a symbolic link in its place. 
	# mv -f 'find $(brew --prefix)/Cellar/qgis/ -name "QGIS.app"' /Applications/QGIS.app
	# ln -s /Applications/QGIS.app 'find $(brew --prefix)/Cellar/qgis/ -name "3.*" -print -quit'

	# Creating an alias to /Applications 
	echo "\U1F4CC ${RED}==>${NC} Creating a link in /Applications \U1F91E"
	trash /Applications/QGIS.app
	qgis_location=$(find $(brew --prefix)/Cellar/qgis/ -name "3.*" -print -quit)/QGIS.app
	osascript -e 'tell application "Finder"' -e 'make new alias to file (posix file "'$qgis_location'") at (posix file "/Applications")' -e 'end tell'
}