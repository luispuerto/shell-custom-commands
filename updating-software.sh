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
		
		# First try to update with binary packages
		echo "\U1F4CC ${RED}==>${NC} Attempting binary package updates..."
		Rscript --vanilla -e "
		tryCatch({
			update.packages(ask = FALSE, repos = 'https://cloud.r-project.org', checkBuild = TRUE, type = 'binary')
		}, error = function(e) {
			cat('Binary update failed, will try source compilation\n')
		})"
		
		# Check if there are still outdated packages and build from source
		if [ ! "$(Rscript --vanilla -e "old.packages(repos = 'cloud.r-project.org')")" = NULL ]; then
			echo "\U1F4CC ${RED}==>${NC} Some packages failed binary update, building from source... \U2699\UFE0F"
			Rscript --vanilla -e "
			old_pkgs <- old.packages(repos = 'https://cloud.r-project.org')
			if (!is.null(old_pkgs)) {
				for (pkg in rownames(old_pkgs)) {
					cat('Building', pkg, 'from source...\n')
					tryCatch({
						install.packages(pkg, repos = 'https://cloud.r-project.org', type = 'source')
					}, error = function(e) {
						cat('Failed to build', pkg, 'from source:', e\$message, '\n')
					})
				}
			}"
		fi
	else 
		echo "\U1F4CC ${RED}==>${NC} Nothing to update \U1F603"
	fi 
}

# Update all
function up-all () {
	echo "\U1F4CC ${RED}==>${NC} Updating oh-my-zsh \U1F643  \U1F91E"
  $ZSH/tools/upgrade.sh
  up-brew
	up-r-packages
	echo "\U1F4CC ${RED}==>${NC} Updating Ruby \U1F48E  gems \U1F91E"
	gem update 
	# echo "\U1F4CC ${RED}==>${NC} updating macOS Apps in the App Mac Store \U1F5A5  \U1F91E"
	# mas upgrade
	# echo "\U1F4CC ${RED}==>${NC} updating macOS System \U1F5A5  \U1F91E"
	# softwareupdate -i -a
}

# Link openBLAS to R binary
function r-openblas () {

  # Figuring out the kind of machine
  UNAME_MACHINE="$(/usr/bin/uname -m)"
  if [[ "${UNAME_MACHINE}" == "arm64" ]]
  then
    # On ARM macOS, library is on /opt/homebrew 
    ln -sf \
      /opt/homebrew/opt/openblas/lib/libopenblas.dylib \
      /Library/Frameworks/R.framework/Resources/lib/libRblas.dylib 
  else
    # On Intel macOS, library is on /usr/local
    ln -sf \
      /usr/local/opt/openblas/lib/libopenblas.dylib \
      /Library/Frameworks/R.framework/Resources/lib/libRblas.dylib 
  fi
}

# Reinstall command line tools
function command-line-tools-reinstall {
  sudo rm -rf /Library/Developer/CommandLineTools
  xcode-select --install
}
