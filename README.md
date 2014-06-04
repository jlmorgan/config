# Config

All files by default are symlinked into position rather than copied to allow for easy updating through `git pull` with the exception of the `.gitignore` file which is a concatenation of several files based on your OS profile. There is limited support/expectations for Linux and Windows system profiles, but suggestions are welcome. If an existing file is found, a back up is created with the same name plus `.bak` extension. Existing symlinks are simply relinked to the installer's version.

## Install Options

```
$ rake
Tasks:
  apache          - Install basic apache config (requires root/sudo -E)
  bash            - Install the bash profile
  git             - Install the git profile
  install         - Install all the things
  neobundle       - Install neobundle for vim
  powerline_fonts - Install fonts for the vim plugin "powerline"
  vim             - Install the vim profile
```

### Apache Config

Provides symlinks for the following files:

* `/etc/apache2/other/os.conf`

ServerName and ServerAdmin are then set in:

* `/etc/apache2/other/host.conf`

### Bash Profile

While the bash profile caters more to my current environment, I am open to adding additional pathing and tools into the `PATH` and suggestions on a more optimal ordering.

Provides symlinks for the following files:

* `.bash_aliases`
* `.bash_profile`

The `.bash_profile` looks for the following files for custom settings:

* `.bash_aliases_local`
* `.bash_profile_local`

And checks for the following paths:

* Early execution paths
  * `$HOME/bin`
  * `/usr/local/bin`
  * `/usr/local/sbin`
* Late execution paths
  * `$HOME/.rvm/bin`
  * `/usr/local/sencha`
  * `/usr/local/rvm/bin`
  * `/usr/local/php5/bin`
  * `/usr/local/mysql/bin`
  * `/usr/local/git/bin`

Lastly, it checks for `rvm` in `$HOME/.rvm/scripts/rvm` or `/usr/local/rvm/scripts/rvm`.

### Git Profile

Provides symlinks for the following files:

* `.gitconfig`
* `.gitconfig_os`
* `.gitaliases`

The `.gitconfig` looks for the following files for custom settings:

* `.gitconfig_local`
* `.gitaliases_local`

The `.gitignore` file is a concatenation of various ignore files provided in the `git/ignore` submodule. For those in the Linux and Windows environments, if there are additional ignore files provided in `git/ignore`, let me know and I will add them into the list for your platform. Files added to the git ignore file should not be project/language specific, but more of editors and operating system specific.

* Linux
  * Linux
  * Vim
* Mac OS X
  * OS X
  * Sublime Text
  * Textmate
  * Vim
  * XCode
* Windows
  * Notepad++
  * Sublime Text
  * Vim
  * Visual Studio
  * Windows

### NeoBundle

Vim package manager provided by [Shougo](https://github.com/Shougo/).

Creates the following directory path(s):

* `.vim/bundle`

Provides symlinks for the following folders and bundles:

* `.vim/bundle/neobundle.vim` (See [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim))
* `.vim/bundle/sparkup` (See [rstacruz/sparkup](https://github.com/rstacruz/sparkup))
* `.vim/bundle/syntastic` (See [scrooloose/syntastic](https://github.com/scrooloose/syntastic))
* `.vim/bundle/vim-airline` (See [bling/vim-airline](https://github.com/bling/vim-airline))
* `.vim/bundle/vim-fugitive` (See [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive))
* `.vim/bundle/vim-gitgutter` (See [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter))
* `.vim/bundle/vimproc` (See [Shougo/vimproc](https://github.com/Shougo/vimproc))

### Powerline Fonts

These fonts provide the glyphs necessary to make the powerline/airline bundle for vim appear correctly.

Provides symlinks for the following (otf, ttf) files:

* AnonymousPro
* DejaVuSansMono
* DroidSansMono
* Inconsolata
* InconsolataDz
* LiberationMono
* Meslo
* SourceCodePro
* Terminus
* UbuntuMono

### Vim Profile

Provides symlinks for the following:

* `.vimrc`
