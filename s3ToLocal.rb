# s3ToLocal
# Is a ruby script to copy the ActiveStorage files in an s3 bucket into the local folder structure
# with which you can restore the DB and Storage in a local setup,
# you can also use this to if you are moving away from the AWS s3 service
#
# do not need to change anything on the Database to link the resources
#
# get a dump of your DB and restore it in your local machine
# get a copy of the content of the s3 bucket and when asked type in the path where it is contained
#
# Author: Sujeev Vidanapathirana
#
#
# Required libraries
require 'fileutils'

# Get source and destination folders
puts "Where does the S3 bucket resides?"
source_folder = gets.chomp
puts "Where do you want to restore the local storage:?"
dest_folder = gets.chomp
puts "S3 bucket located at: #{source_folder}"
puts "Local Storage at: #{dest_folder}"
puts "if incorrect Ctrl+C to exit, or press Enter/Return"
key_input = gets.chomp
# Create destination folder
Dir.mkdir dest_folder unless Dir.exist? dest_folder

# Itarete through only the files in the source folder and create the appropiate first level and second level folders
# and copy the file inside the folder structure
files = Dir.entries(source_folder)
files.each do |file|
  if File.file?(source_folder + '/' + file)
    primary_folder = file[0] + file[1]
    secondary_folder = file[2] + file[3]
    Dir.mkdir dest_folder + '/' + primary_folder unless Dir.exist? dest_folder + '/' + primary_folder
    Dir.mkdir dest_folder + '/' + primary_folder + '/' + secondary_folder unless Dir.exist? dest_folder + '/' + primary_folder + '/' + secondary_folder
    FileUtils.cp( source_folder + '/' + file, dest_folder + '/' + primary_folder + '/' + secondary_folder) unless File.exist? dest_folder + '/' + primary_folder + '/' + secondary_folder + '/' + file
    puts "Copied: #{dest_folder}/#{primary_folder}/#{secondary_folder}/#{file}"
  end
end
