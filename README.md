# My Dotfiles

These are the configuration files for my different environments.

## `config` script
The `config` script automatically copies over or grabs the configuration files for a selected system.

Files under `common` are installed for all systems together with environment specific files stored in each
environment's folder.

`bin` is also copied whole to `$HOME/bin`

```
Usage: ./config deploy | acquire <system> [-d]
Where system must be one of the following:
macos debian illumos freebsd msys 

  -d: Dry-run. Only lists changes to be made.
```

