# My Dotfiles

These are the configuration files and tools for my different environments.
They are intended to replicate only my preferred shell environment, so they only
include approximately the minimum common denominator for all my systems. 
More complex configuration files, regarding GUI programs or shell utilities I use only
in my personal computers will be stored in other repo and possibly managed by
`home-manager`.

Some of these utilites that were previously managed by this repo but are no longer
include:

 - `irssi`
 - `mutt`
 - `beets`

## `deploy` script
The `deploy` script creates symbolic links from the source directories to the correct
location for the files in the home directory. It will back up any dotfiles it replaces
to `$HOME/.dotfiles.old-$(date)`

Files under `common` are installed for all systems together with environment specific
files stored in each environment's folder.

```
Usage: ./deploy <system> [-d]
Where system must be one of the following:
macos linux illumos freebsd msys 

  -d: Dry-run. Only lists changes to be made.
```
