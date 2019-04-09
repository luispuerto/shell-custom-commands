# Bash Custom Commands :desktop_computer:

This is a small repo with some bash custom commands I use. Mainly to update software in a easier way. 

## How to use install

Pretty easy. Just clone this repo: 

```shell
$ git clone git@github.com:luispuerto/bash-custom-commands.git
$ git clone https://github.com/luispuerto/bash-custom-commands.git # if you prefer http protocol
```

Then in bash or zsh you have to source `updating-software.sh` in your shell config file. More info [here](https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e) but basically: 

```shell
$ open ~/.zshrc # for zsh
$ open ~/.bash_profile #for bash
```

And paste something like: 

```
source ~/path/to/bash-custom-commands-repo/updating-software.sh
```

Open and close the terminal —or whatever you are using— and that's it. 

## Dependencies

- [Homebrew](https://brew.sh) :beer:.
- [mas](https://github.com/mas-cli/mas): `brew install mas`. 
- [trash](https://hasseg.org/trash/): `brew install trash`. 
- [homebrew cask upgrade](https://github.com/buo/homebrew-cask-upgrade): `brew tap buo/cask-upgrade`. 
- Of course, R, Ruby, Python :smiley: too​. 

## Update & Upgrade Commands

### Update Homebrew

This command will perform a general update of all the Homebrew packages. 

```shell
$ up-brew
```

It executes a brew update, upgrade cask upgrade and a cleanup. 

### Update R packages

This command updates R packages

```shell
$ up-r-pacakges
```

It upgrades all R packages in your machine. 

### Update Python packages

This update Python Packages through pip and pip3. 

```shell
$ up-py-packages
```

### Update all

This updates brew packages, r packages, gems, App Mac Store Apps and macOS system. 

```shell
$ up-all
```

## Reinstall Commands

These commands uninstall and reinstall apps via Homebrew

### Reinstall R

This reinstall R from [sethrfore/r-srf](https://github.com/sethrfore/homebrew-r-srf) of reset `-r` the R install uninstalling Cairo and R (from core and [sethrfore/r-srf](https://github.com/sethrfore/homebrew-r-srf)) and reinstall it again from [sethrfore/r-srf](https://github.com/sethrfore/homebrew-r-srf) with openblas, java, libtiff and cairo.

```shell
$ reinstall-r -r
```

### Reinstall QGIS

This command just reinstall QGIS or reset `-r` uninstalling QGIS and reinstalling it again with with gpsbabel, grass, haf5, saga, r, orfeo, pdal, qspatialite, lastools, liblas, szip, taudem, whitebox and mssql. If `-f` is apply it will fix dependencies. 

```shell
$ reinstall-qgis -r -f 
```

#### Fixing QGIS dependencies

This command tries to fix the QGIS dependencies reinstalling them and overwriting the links. This command is executed also when you run `reinstall-qgis`. 

```shell
$ fix-qgis-dependencies
```

## Alias QGIS 

This is a command to just create —reinstall— an alias to the QGIS installation. It's useful in case QGIS is updated. 

```shell
$ alias-qgis
```
