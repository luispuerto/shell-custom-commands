#!/usr/bin/env bash 

# These are my collection of custom commands for terminal. 
# They are mainly to update software I use. 

# Update Homebrew
function up-brew () {
	echo "brew update"
	brew update
	echo "brew upgrade"
	brew upgrade
	echo "brew cu -ya"
	brew cu -ya
	echo "brew cleanup"
	brew cleanup
}

# Update R Packages
function up-r-packages () {
	echo "Rscript --vanilla -e \"update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)\""
	Rscript --vanilla -e "update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)"
}

# Update gems
function up-gems () {
	echo "Updating Ruby gems"
	gem update
}

# Update Python Packages
function up-py-packages () {
	echo "Updating Python Packages"
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
	echo "updating macOS Apps"
	mas upgrade
	ecoh "updating macSO"
	softwareupdate -i -a
}

# Reinstall R
function reinstall-r () {

	# Uninstalling R & Cairo
	echo "Uninstalling R & Cairo"
	brew uninstall R cairo sethrfore/r-srf/cairo sethrfore/r-srf/r
	
	# Installing Cairo
	echo "Installing Cairo"
	brew install sethrfore/r-srf/cairo
	
	# Installing R
	echo "Installing R"
	brew install sethrfore/r-srf/r --with-openblas --with-java --with-libtiff --with-cairo
}

# Reinstall QGIS 
function reinstall-qgis () {
	
	# Uninstall previous 
	echo "uninstalling QGIS"
	brew uninstall qgis
	
	# Remove the cache 
	echo "Removing cache"
	rm -rf $(brew --cache)

	# Installing QGIS 
	echo "Installing QGIS"
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
	echo "Creating a link in /Applications"
	trash /Applications/QGIS.app
	qgis_location=$(find $(brew --prefix)/Cellar/qgis/ -name "3.*" -print -quit)/QGIS.app
	osascript -e 'tell application "Finder"' -e 'make new alias to file (posix file "'$qgis_location'") at (posix file "/Applications")' -e 'end tell'
}