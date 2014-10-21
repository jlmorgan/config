module Source
  module Apache
    HOST = '/apache/host.conf'
    OSX = '/apache/osx.conf'
  end

  module Bash
    module OSX
      ALIASES = '/bash/osx/aliases.sh'
      PROFILE = '/bash/osx/profile.sh'
    end
  end

  module Git
    BASE = '/git/base.gitconfig'
    ALIASES = '/git/default.gitaliases'
    OSX = '/git/osx.gitconfig'
    TEMPLATE = '/git/default.gittemplate'
    UNIX = '/git/unix.gitconfig'
    WIN = '/git/win.gitconfig'

    module Ignore
      ARCHIVES = '/git/ignore/Global/Archives.gitignore'
      LINUX = '/git/ignore/Global/Linux.gitignore'
      NOTEPADPP = '/git/ignore/Global/NotepadPP.gitignore'
      OSX = '/git/ignore/Global/OSX.gitignore'
      SUBLIMETEXT = '/git/ignore/Global/SublimeText.gitignore'
      TEXTMATE = '/git/ignore/Global/TextMate.gitignore'
      VIM = '/git/ignore/Global/VIM.gitignore'
      VISUALSTUDIO = '/git/ignore/Global/VisualStudio.gitignore'
      WIN = '/git/ignore/Global/Windows.gitignore'
      XCODE = '/git/ignore/Global/Xcode.gitignore'
    end
  end

  module NeoBundle
    BUNDLE_PATH = '/vim/bundle/'
    BUNDLES = [
      'neobundle.vim',
      'sparkup',       # HTML expansion using CSS syntax
      'syntastic',     # syntax checker
      'vim-airline',   # vim status and tabline
      'vim-fugitive',  # git wrapper
      'vim-gitgutter', # git diff in the gutter (left side numbering area)
      'vimproc'
    ]
  end

  module Powerline
    FONT_EXTENSIONS = ['.otf', '.ttf']
    FONTS = [
      'AnonymousPro',
      'DejaVuSansMono',
      'DroidSansMono',
      'Inconsolata',
      'InconsolataDz',
      'LiberationMono',
      'Meslo',
      'SourceCodePro',
      'Terminus',
      'UbuntuMono'
    ]
    FONT_PATH = '/vim/fonts/powerline-fonts/'
  end

  module Vim
    OSX = '/vim/osx.vimrc'
  end
end
