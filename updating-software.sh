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
		echo "\U1F4CC ${RED}==>${NC} There are outdated R packages \U1F4E6  \U1F91E"
		echo "\U1F4CC ${RED}==>${NC} Upgrading & building... \U1F3D7"
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

# Reinstall R
function reinstall-r () {

	# Capturing flags
	unset RESET
	while getopts "r" opts
	do 
		case $opts in 
			-r | --reset) RESET=true ;; 
		esac
	done

	if [ $RESET=true ]; then 
		# Uninstalling R & Cairo
		echo "\U1F4CC ${RED}==>${NC} Uninstalling R & Cairo \U1F91E"
		brew uninstall --ignore-dependencies R cairo 
		brew uninstall --ignore-dependencies sethrfore/r-srf/cairo
		brew uninstall --ignore-dependencies sethrfore/r-srf/r
		
		# Installing Cairo
		echo "\U1F4CC ${RED}==>${NC} Installing Cairo \U1F91E"
		brew install sethrfore/r-srf/cairo
		
		# Installing R
		echo "\U1F4CC ${RED}==>${NC} Installing R with openblas, java, libtiff and cairo \U1F91E"
		echo "\U1F4CC ${RED}==>${NC} Building... \U1F3D7"
		brew install sethrfore/r-srf/r --with-openblas --with-java --with-libtiff --with-cairo

	else
		brew reinstall sethrfore/r-srf/r
	fi 
}

function r-out () {

	# Renaming R to r-back in Cellar to avoid conflict with QGIS R install 
	echo -n "\U1F4CC ${RED}==>${NC} Renaming R to r-back in Cellar to avoid conflicts "
	echo "with QGIS R install \U1F91E"
	brew unlink r cairo
	mv /usr/local/Cellar/r /usr/local/Cellar/r-backup
	mv /usr/local/Cellar/cairo /usr/local/Cellar/cairo-backup
}

function r-in () {

	# Deleting the R installed by QGIS formula and recovering previous R install
	echo -n "\U1F4CC ${RED}==>${NC} Deleting the R installed by QGIS formula and "
	echo -e "recovering previous R install and linking it \U1F91E" 
	brew unlink r cairo
	trash /usr/local/Cellar/r /usr/local/Cellar/cairo
	mv /usr/local/Cellar/r-backup /usr/local/Cellar/r
	mv /usr/local/Cellar/cairo-backup /usr/local/Cellar/cairo
	brew link r cairo

}


# QGIS Alias
function alias-qgis () {
	echo "\U1F4CC ${RED}==>${NC} Creating a link in /Applications \U1F91E"
	trash /Applications/QGIS.app
	qgis_location=$(find $(brew --prefix)/Cellar/osgeo-qgis/ -name "3.*" -print -quit)/QGIS.app
	osascript \
		-e 'tell application "Finder"' \
		-e 'make new alias to file (posix file "'$qgis_location'") at (posix file "/Applications/")' \
		-e 'set name of result to "QGIS.app"' \
		-e 'end tell'
}

# Renaming git locale
function fix-git-locale () {
	find $(brew --prefix)/Cellar/git -type d -name "es" -print0 | xargs -I{} mv {} {}.back
}

# Fixing QGIS Homebrew dependencies
# This seems no longer necessary, buy if it's need to be adapted to the new osgeo names. 
# function fix-qgis-dependencies {
# 	echo "\U1F4CC ${RED}==>${NC} Fixing QGIS Homebrew dependencies \U1F91E"
	
# 	echo "\U1F4CC ${RED}==>${NC} Removing cache \U1F91E"
# 	rm -rf $(brew --cache)

# 	echo -n "\U1F4CC ${RED}==>${NC} Reinstall ninja gsl python qt sip-qt5 pyqt-qt5 "
# 	echo "pyqt5-webkit qscintilla2-qt5 six bison flex pkg-config \U1F91E"
# 	brew reinstall ninja gsl python qt sip-qt5 pyqt-qt5 pyqt5-webkit qscintilla2-qt5 \
# 		six bison flex pkg-config
	
# 	echo -n "\U1F4CC ${RED}==>${NC} Link (overwrite) python sip-qt5 "
# 	echo "pyqt-qt5 pyqt5-webkit qscintilla2-qt5 six \U1F91E"
# 	brew link --overwrite osgeo-sip

# 	echo "\U1F4CC ${RED}==>${NC} Unlink and link gettext \U1F91E"
# 	brew unlink gettext 
# 	brew link --force gettext
# }

# Reinstall QGIS 
function reinstall-qgis () {
	# Capturing flags
	unset DEPENDENCIES RESET
	while getopts "r" opts
	do 
		case $opts in 
			# -f ) DEPENDENCIES=true ;; 
			r) RESET="true" ;; 
		esac
	done
	
	# Uninstall previous QGIS
	if [ "$RESET" = "true" ]; then 
	echo "\U1F4CC ${RED}==>${NC} Uninstalling QGIS \U1F91E"
	brew uninstall osgeo-qgis
	fi 

	# Fixing QGIS Homebrew dependencies
	# if [ $DEPENDENCIES=true ]; then 
	# 	fix-qgis-dependencies
	# fi

	# Renaming R to r-back in Cellar to avoid conflict with QGIS R install 
	echo -n "\U1F4CC ${RED}==>${NC} Renaming R to r-back in Cellar to avoid conflicts "
	echo "with QGIS R install \U1F91E"
	brew unlink r cairo
	mv /usr/local/Cellar/r /usr/local/Cellar/r-backup
	mv /usr/local/Cellar/cairo /usr/local/Cellar/cairo-backup

	# Installing QGIS 
	if [ "$RESET" = "true" ]; then
	echo "\U1F4CC ${RED}==>${NC} Installing QGIS with gpsbabel, grass, saga, r, orfeo,"
	echo "qspatialite, lastools, taudem, whitebox and mssql"
	echo "\U1F91E\U1F91E\U1F91E\U1F91E\U1F91E\U1F340\U1F340\U1F340\U1F340\U1F340"
	echo "\e[3mMay the force be with you!\e[0m"
	# echo -n "psss! Building time around 20' to 40'. You better get a coffee \U2615 "
	# echo "or beer \U1F37A, and relax \U1F6CB"
	# echo "\U1F4CC ${RED}==>${NC} Building... \U1F3D7"
	brew install osgeo-qgis
	
	else 
		brew reinstall osgeo-qgis || brew install osgeo-qgis
	fi 

	# Moving the app to Applications and creating a symbolic link in its place. 
	# mv -f 'find $(brew --prefix)/Cellar/qgis/ -name "QGIS.app"' /Applications/QGIS.app
	# ln -s /Applications/QGIS.app 'find $(brew --prefix)/Cellar/qgis/ -name "3.*" -print -quit'

	# Deleting the R installed by QGIS formula and recovering previous R install
	echo -n "\U1F4CC ${RED}==>${NC} Deleting the R installed by QGIS formula and "
	echo -e "recovering previous R install and linking it \U1F91E" 
	trash /usr/local/Cellar/r /usr/local/Cellar/cairo
	mv /usr/local/Cellar/r-backup /usr/local/Cellar/r
	mv /usr/local/Cellar/cairo-backup /usr/local/Cellar/cairo
	brew link r cairo

	# Creating an alias to /Applications 
	alias-qgis
}
