# This file provides an easy way to install this irbrc

require 'ftools'

# variable setups
installed_irbrc = File.join(ENV['HOME'], '.irbrc')
new_irbrc = File.join(File.expand_path(File.dirname(__FILE__)), 'irbrc')
irbrc_backup = File.join(File.expand_path(File.dirname(__FILE__)), 'backup', 'irbrc.original')

# Exit installation if irbrc is already installed
if File.identical?(installed_irbrc, new_irbrc)
  puts "Joshaven's irbrc is already installed."
  exit
end

# ensure that the backup location exists
system("mkdir -p #{File.join(File.expand_path(File.dirname(__FILE__)), 'backup')}")

# backup file unless the backup is already there
if File.file?(installed_irbrc) && !File.file?(irbrc_backup)
  File.move(installed_irbrc, irbrc_backup)
elsif File.file?(installed_irbrc) # irbrc exists and there is already a backup
  # ask user if we should backup the current irbrc & loose the previous backup, loose the current irbrc or cancel
  puts "A prior backup file has been found.\nPlease enter the number of one of the options below."
  puts ' 1) Overwrite ~/.irbrc without making a backup.'
  puts ' 2) Remove the existing backup, then backup ~/.irbrc'
  puts ' 3) Cancel the installation of Joshaven\'s irbrc'
  print '> '
  begin
    answer = gets
  end until /^[123]$/ === answer

  case answer.to_i
  when 1
    File.delete(installed_irbrc)
  when 2
    File.delete(irbrc_backup)
    File.move(installed_irbrc, irbrc_backup)
  when 3
    exit
  end
end

# symlink the irbrc
File.symlink new_irbrc, installed_irbrc

# setup the default text editor unless already set
system("echo -e '\nexport EDITOR=mate\n' >> ~/.profile") if ENV['EDITOR'].nil?

puts "Joshaven's irbrc has been successfully installed."




