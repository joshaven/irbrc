# Remove .irbrc if its a symlink to irbrc
# Restore irb from backup if it exists
# Ask if Joshaven's irbrc should be completely removed
# Remove ~/.sbin if it is empty

require 'ftools'

installed_irbrc = File.join(ENV['HOME'], '.irbrc')
new_irbrc = File.join(File.expand_path(File.dirname(__FILE__)), 'irbrc')
irbrc_backup = File.join(File.expand_path(File.dirname(__FILE__)), 'backup', 'irbrc.original')

puts "Joshaven's irbrc is not installed." unless File.identical?(installed_irbrc, new_irbrc)

if File.file? installed_irbrc
  # remove installed irbrc if it exits
  File.delete(installed_irbrc) 
  # restore from backup if it exists
  if File.file?(irbrc_backup)
    File.move(irbrc_backup, installed_irbrc) 
    puts "Your previous ~/.irbrc has been installed"
  end
end

puts "Joshaven's irbrc has been uninstalled."