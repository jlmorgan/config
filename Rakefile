# Rakefile for config

require 'rake'
require 'rake/clean'
require_relative 'lib/installer.rb'

desc ''
task :default do
  puts 'Tasks:'
  puts '  apache          - Install basic apache config (requires root/sudo -E)'
  puts '  bash            - Install the bash profile'
  puts '  git             - Install the git profile'
  puts '  install         - Install all the things'
  puts '  neobundle       - Install neobundle for vim'
  puts '  powerline_fonts - Install fonts for the vim plugin "powerline"'
  puts '  vim             - Install the vim profile'
end

desc 'Install basic apache config'
task :apache do
  if Process.uid == 0
    Installer.install_apache_config
  else
    puts 'Installing apache config require root/sudo access. Use:'
    puts '  $ sudo -E rake apache'
  end
end

desc 'Install the bash profile'
task :bash do
  Installer.install_bash_profile
end

desc 'Install git profile'
task :git do
  Installer.install_git_profile
end

desc 'Install all'
task :install => [:bash, :git, :neobundle, :powerline_fonts, :vim]

desc 'Install neobundle for vim'
task :neobundle do
  Installer.install_neobundle
end

desc 'Install fonts for the vim plugin "powerline"'
task :powerline_fonts do
  Installer.install_powerline_fonts
end

desc 'Install the vim profile'
task :vim do
  Installer.install_vim_profile
end
