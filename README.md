# Terminal Commands :desktop_computer:

This is a small shell script that produce some command for update apps or reinstall it from scratch. 

## How to use install

Pretty easy. Just clone this repo: 

```shell
$ git clone git@github.com:luispuerto/terminal-commands.git
$ git clone https://github.com/luispuerto/terminal-commands.git # if you prefer http protocol
```

Then in bash or zsh you have to source `custom-commans.sh` in your shell config file. More info [here](https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e) but basically: 

```shell
$ open ~/.zshrc # for zsh
$ open ~/.bash_profile #for bash
```

And paste something like: 

```
source ~/path/to/terminal-commands-repo/custom-commands.sh
```

Open and close the terminal —or whatever you are using— and that's it. 

## Dependencies

- [Homebrew](https://brew.sh) :beer:.
- [mas](https://github.com/mas-cli/mas) `brew install mas`. 
- Of course, R, Ruby, Python :smiley: too​. 

## Update & Upgrade Commands

### Update Homebrew

This command will perform a general update of all the Homebrew packages. 

```shell
$ up-brew
```

It executes:

```sh
echo "\U1F4CC ${RED}==>${NC} brew update \U1F91E"
brew update
echo "\U1F4CC ${RED}==>${NC} brew upgrade \U1F91E"
brew upgrade
echo "\U1F4CC ${RED}==>${NC} brew cu -ya \U1F91E"
brew cu -ya
echo "\U1F4CC ${RED}==>${NC} brew cleanup \U1F91E"
brew cleanup
```

### Update R packages

This command updates R packages

```shell
$ up-r-pacakges
```

It executes: 

```sh
echo "\U1F4CC ${RED}==>${NC} Rscript --vanilla -e \"update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)\" \U1F91E"
echo "\U1F4CC ${RED}==>${NC} Building... \U1F3D7"
Rscript --vanilla -e "update.packages(ask = F, repos = 'cloud.r-project.org', checkBuild = T)"
```

### Update Ruby Gems

This updates the Ruby Gems

```shell
$ up-gems
```

It executes: 

```sh
echo "\U1F4CC ${RED}==>${NC} Updating Ruby gems \U1F91E"
gem update
```

### Update Python packages

This update Python Packages through pip. 

```shell
$ up-py-packages
```

This executes: 

```sh
echo "\U1F4CC ${RED}==>${NC} Updating Python Packages \U1F91E"
pip install --upgrade pip setuptools wheel
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
pip3 install --upgrade pip setuptools wheel
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
```

### Update all 

This updates all the previous one plus the app store and system. 

```shell
$ up-all
```

This executes: 

```sh
up-brew
up-r-packages
up-gems
up-py-packages
echo "\U1F4CC ${RED}==>${NC} updating macOS Apps in the App Mac Store \U1F91E"
mas upgrade
echo "\U1F4CC ${RED}==>${NC} updating macOS System \U1F91E"
softwareupdate -i -a
```

## Reinstall Commands

These commands uninstall and reinstall apps via Homebrew

### Reinstall R

This uninstall Cairo and R (from core and [sethrfore/r-srf](https://github.com/sethrfore/homebrew-r-srf)) and reinstall it again from [sethrfore/r-srf](https://github.com/sethrfore/homebrew-r-srf) with openblas, java, libtiff and cairo.

```shell
$ reinstall-r
```

The command executes: 

```sh
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
```

### Reinstall QGIS

This command just reinstall QGIS with with gpsbabel, grass, haf5, saga, r, orfeo, pdal, qspatialite, lastools, liblas, szip, taudem, whitebox and mssql. 

```shell
$ reinstall-qgis
```

These are commands that executes: 

```sh
# Uninstall previous QGIS
echo "\U1F4CC ${RED}==>${NC} Uninstalling QGIS \U1F91E"
brew uninstall qgis

# Fixing QGIS Homebrew dependencies
fix-qgis-dependencies

# Installing QGIS 
echo "\U1F4CC ${RED}==>${NC} Installing QGIS with gpsbabel, grass, haf5, saga, r, orfeo, pdal,"
echo "qspatialite, lastools, liblas, szip, taudem, whitebox and mssql"
echo "\U1F91E\U1F91E\U1F91E\U1F91E\U1F91E\U1F340\U1F340\U1F340\U1F340\U1F340"
echo "\e[3mMay the force be with you!\e[0m"
echo "psss! Building time around 20' to 40'. You better get a coffee \U2615 or beer \U1F37A, and relax \U1F6CB"
echo "\U1F4CC ${RED}==>${NC} Building... \U1F3D7"
brew install qgis \
	--with-gpsbabel \
	--with-grass \
	--with-hdf5 \
	--with-saga \
	--with-r \
	--with-orfeo \
	--with-pdal \
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
osascript \
	-e 'tell application "Finder"' \
	-e 'make new alias to file (posix file "'$qgis_location'") at (posix file "/Applications/")' \
	-e 'set name of result to "QGIS.app"' \
	-e 'end tell'
```

#### Fixing QGIS dependencies

This command tries to fix the QGIS dependencies reinstalling them and overwriting the links. This command is executed also when you run `reinstall-qgis`. 

```shell
$ fix-qgis-dependencies
```

The command executes:

```sh
echo "\U1F4CC ${RED}==>${NC} Fixing QGIS Homebrew dependencies \U1F91E"

echo "\U1F4CC ${RED}==>${NC} Removing cache \U1F91E"
rm -rf $(brew --cache)

echo "\U1F4CC ${RED}==>${NC} Reinstall ninja gsl python qt sip-qt5 pyqt-qt5 pyqt5-webkit qscintilla2-qt5 six bison flex pkg-config \U1F91E"
brew reinstall ninja gsl python qt sip-qt5 pyqt-qt5 pyqt5-webkit qscintilla2-qt5 six bison flex pkg-config

echo "\U1F4CC ${RED}==>${NC} Link (overwrite)  sip-qt5 pyqt-qt5 pyqt5-webkit qscintilla2-qt5 six \U1F91E"
brew link --overwrite qt python sip-qt5 pyqt-qt5 pyqt5-webkit qscintilla2-qt5 six

echo "\U1F4CC ${RED}==>${NC} Unlink and link gettext \U1F91E"
brew unlink gettext 
brew link --force gettext
```

## Alias QGIS 

This is a command to just create —reinstall— an alias to the QGIS installation. It's useful in case QGIS is updated. 

```shell
$ alias-qgis
```

The script executes: 

```sh
# Creating an alias to /Applications 
echo "\U1F4CC ${RED}==>${NC} Creating a link in /Applications \U1F91E"
trash /Applications/QGIS.app
qgis_location=$(find $(brew --prefix)/Cellar/qgis/ -name "3.*" -print -quit)/QGIS.app
osascript \
	-e 'tell application "Finder"' \
	-e 'make new alias to file (posix file "'$qgis_location'") at (posix file "/Applications/")' \
	-e 'set name of result to "QGIS.app"' \
	-e 'end tell'
```





