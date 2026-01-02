# My Dotfiles

These are the configuration files for my different environments.

## `config` script
The `config` script creates symbolic links from the source directories to the correct
location for the files in the home directory. It will back up any dotfiles it replaces
to `$HOME/.dotfiles.old-$(date)`

Files under `common` are installed for all systems together with environment specific
files stored in each environment's folder.

```
Usage: ./config <system> [-d]
Where system must be one of the following:
macos linux illumos freebsd msys 

  -d: Dry-run. Only lists changes to be made.
```
