# Bash Custom Commands :desktop_computer:

This is a small repo with some bash custom commands I use. Mainly to update software in a easier way. 

<!-- MarkdownTOC -->

- [How to use install](#how-to-use-install)
- [Dependencies](#dependencies)
- [Update & Upgrade Commands](#update--upgrade-commands)
    - [Update Homebrew](#update-homebrew)
    - [Update R packages](#update-r-packages)
    - [Update all](#update-all)
    - [Link R to openBLAS](#link-r-to-openblas)
- [Other commands](#other-commands)
    - [diff files with sublimemerge](#diff-files-with-sublimemerge)
    - [Reset the bluetooth](#reset-the-bluetooth)
    - [Reset sound](#reset-sound)
    - [Fix mail app](#fix-mail-app)

<!-- /MarkdownTOC -->


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

It executes a brew update, upgrade and a cleanup. 

### Update R packages

This command updates R packages

```shell
$ up-r-pacakges
```

It upgrades all R packages in your machine. 

### Update all

This updates brew packages, r packages, gems, App Mac Store Apps and macOS system. 

```shell
$ up-all
```
### Link R to openBLAS 

If you want to use openBLAS on your R install from the binary you need to link it manually using a symbolic link. This command do it for you.

```shell 
$ r-openblas
```

You have to run it every time you updates or reinstall R. 

## Other commands 

### diff files with sublimemerge

```shell
$ subldiff <file1> <file2>
```

This is a command that uses [SublimeMerge3](https://www.sublimerge.com/sm3/) as a `diff tool`. You should have [Sublime Text](https://www.sublimetext.com) and this package installed to make it work properly. 

### Reset the bluetooth

```shell 
reset-bluetooth
```

This just resent the bluetooth device on your Mac. 

### Reset sound

```shell
reset-sound
```

This just resent the `coreudiod` service. 

### Fix mail app

The mail app sometimes it's a little slow opening. It seems that `/Users/lpuerto/Library/Containers/com.apple.mail/Data/DataVaults/MailBundles/Library/Mail/Bundles/Properties.plist` gets corrupted or something. This function just delete it and the next time mail opens the file gets recreated. 

```shell
fix-mail-app
```

