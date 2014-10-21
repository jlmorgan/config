require 'colorize'
require 'fileutils'
require_relative '../lib/os.rb'
require_relative '../lib/dest.rb'
require_relative '../lib/source.rb'

class Installer
  class << self
    include Source
    @@dryRun = false
    @@verbose = true

    BASH_PROFILE_NOT_SUPPORTED = 'Bash profile currently not supported for this environment.'
    CONFIGURE_APACHE_HOST = 'Edit %{path} to configure this apache host'
    GIT_NOT_INSTALLED = 'Git not found.'
    INSTALL_APACHE_CONFIG = 'Installing apache config...'
    INSTALL_BASH_PROFILE = 'Installing bash profile...'
    INSTALL_GIT_PROFILE = 'Installing git profile...'
    INSTALL_NEOBUNDLE = 'Installing NeoBundle for vim...'
    INSTALL_POWERLINE_FONTS = 'Installing powerline fonts...'
    INSTALL_VIM_PROFILE = 'Installing vim profile...'
    PLATFORM_NOT_SUPPORTED = 'Platform not supported.'
    POWERLINE_MESSAGE = ' *** Suggest installing powerline fonts: rake powerline_fonts'
    VIM_PROFILE_NOT_SUPPORTED = 'Vim profile currently not supported for this environment.'

    def dry_run?
      @@dryRun
    end

    def dry_run=(value)
      @@dryRun = value
    end

    def verbose?
      @@verbose
    end

    def verbose=(value)
      @@verbose = value
    end

    def clone_repo(source, dest)
      `git clone -q #{source} #{dest}` if !dry_run?
    end

    def install_apache_config
      if OS.mac?
        info(INSTALL_APACHE_CONFIG)

        link_absolute(source_path(Apache::OSX), Dest::Apache::OS_CONFIG)
        copy_absolute(source_path(Apache::HOST), Dest::Apache::HOST_CONFIG)

        info(CONFIGURE_APACHE_HOST % { :path => Dest::Apache::HOST_CONFIG })
      else
        warning(PLATFORM_NOT_SUPPORTED)
      end
    end

    def install_bash_profile
      info(INSTALL_BASH_PROFILE)
      if OS.mac?
        link(Bash::OSX::PROFILE, Dest::Bash::PROFILE)
        link(Bash::OSX::ALIASES, Dest::Bash::ALIASES)
      elsif OS.linux?
        warning(BASH_PROFILE_NOT_SUPPORTED)
      elsif OS.win?
        warning(BASH_PROFILE_NOT_SUPPORTED)
      end
    end

    def install_git_profile
      info(INSTALL_GIT_PROFILE)
      ignores = [Git::Ignore::ARCHIVES]

      if OS.mac?
        link(Git::ALIASES, Dest::Git::ALIASES)
        link(Git::OSX, Dest::Git::OS)
        link(Git::BASE, Dest::Git::CONFIG)
        ignores.push(
          Git::Ignore::OSX,
          Git::Ignore::SUBLIMETEXT,
          Git::Ignore::TEXTMATE,
          Git::Ignore::VIM,
          Git::Ignore::XCODE
        )
        merge(ignores, Dest::Git::IGNORE)
      elsif OS.linux?
        link(Git::ALIASES, Dest::Git::ALIASES)
        link(Git::UNIX, Dest::Git::OS)
        link(Git::BASE, Dest::Git::CONFIG)
        ignores.push(
          Git::Ignore::LINUX,
          Git::Ignore::VIM
        )
        merge(ignores, Dest::Git::IGNORE)
      elsif OS.win?
        link(Git::ALIASES, Dest::Git::ALIASES)
        link(Git::WIN, Dest::Git::OS)
        link(Git::BASE, Dest::Git::CONFIG)
        ignores.push(
          Git::Ignore::NOTEPADPP,
          Git::Ignore::SUBLIMETEXT,
          Git::Ignore::VIM,
          Git::Ignore::VISUALSTUDIO,
          Git::Ignore::WIN
        )
        merge(ignores, Dest::Git::IGNORE)
      end
    end

    def install_neobundle
      info(INSTALL_NEOBUNDLE)
      if OS.mac? or OS.linux?
        FileUtils.mkdir_p dest_path(Dest::NeoBundle::BUNDLE_PATH)

        NeoBundle::BUNDLES.each do |bundle|
          link(NeoBundle::BUNDLE_PATH + bundle, Dest::NeoBundle::BUNDLE_PATH + bundle)
        end
        info(POWERLINE_MESSAGE)
      else
        warning(PLATFORM_NOT_SUPPORTED)
      end
    end

    def install_powerline_fonts
      info(INSTALL_POWERLINE_FONTS)
      if OS.mac?
        Powerline::FONTS.each do |font_dir|
          Powerline::FONT_EXTENSIONS.each do |ext|
            Dir.glob(source_path(Powerline::FONT_PATH + font_dir) + '/*' + ext).each do |sourcePath|
              copy_absolute(
                sourcePath,
                dest_path(Dest::Powerline::FONT_PATH + File.basename(sourcePath))
              )
            end
          end
        end
      else
        warning(PLATFORM_NOT_SUPPORTED)
      end
    end

    def install_vim_profile
      info(INSTALL_VIM_PROFILE)
      if OS.mac?
        link(Vim::OSX, Dest::Vim::PROFILE)
      elsif OS.linux?
        warning(VIM_PROFILE_NOT_SUPPORTED)
      elsif OS.win?
        warning(VIM_PROFILE_NOT_SUPPORTED)
      end
    end

    private
    def copy_absolute(sourcePath, destPath)
      if File.symlink? destPath
        notice("Unlink #{destPath}") if verbose?
        File.unlink(destPath) if !dry_run?
      elsif File.exists? destPath
        notice("#{destPath} " + '->'.yellow + " #{destPath}.bak") if verbose?
        File.rename(destPath, destPath + '.bak') if !dry_run?
      end

      info("#{sourcePath} " + '->'.green + " #{destPath}") if verbose?
      FileUtils.cp(sourcePath, destPath) if !dry_run?
    end

    def dest_path(name)
      Dir.home + '/' + name
    end

    def info(message)
      puts '[INFO] '.green + message
    end

    def link(source, dest)
      link_absolute(source_path(source), dest_path(dest))
    end

    def link_absolute(sourcePath, destPath)
      if File.symlink? destPath
        notice("Unlink #{destPath}") if verbose?
        File.unlink(destPath) if !dry_run?
      elsif File.exists? destPath
        notice("#{destPath} " + '->'.yellow + " #{destPath}.bak") if verbose?
        File.rename(destPath, destPath + '.bak') if !dry_run?
      end

      info("#{sourcePath} " + '->'.green + " #{destPath}") if verbose?
      File.symlink(sourcePath, destPath) if !dry_run?
    end

    def merge(sources, dest)
      destPath = dest_path(dest)

      if File.exists? destPath
        notice("#{destPath} " + '->'.yellow + " #{destPath}.bak") if verbose?
        File.rename(destPath, destPath + '.bak') if !dry_run?
      end

      info("#{destPath} from\n\t" + sources.join("\n\t")) if verbose?
      if !dry_run?
        File.open(destPath, 'w') do |custom|
          sources.each do |source|
            content = File.open(source_path(source), 'r').read
            content.each_line do |line|
              custom << line
            end
            custom << "\n\n"
          end
        end
      end
    end

    def notice(message)
      puts '[NOTICE] '.yellow + message
    end

    def source_path(name)
      File.realpath(File.realpath(File.dirname(__FILE__) + '/..') + name)
    end

    def warning(message)
      puts '[WARNING] '.red + message
    end
  end
end
