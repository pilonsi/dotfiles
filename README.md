# My Dotfiles

These are the configuration files for my different environments.

## deploy.sh
The `deploy.sh` script automatically copies over or grabs te configuration files for a selected system.

Files under `common` are installed for all systems together with environment specific files stored in each
environment's folder.

`bin` is also copied whole to `$HOME/bin`

```
Usage: ./deploy.sh deploy | acquire <system>
Where system must be one of the following:
macos debian illumos freebsd msys 
```

