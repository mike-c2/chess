# frozen_string_literal: true

require 'fileutils'
require_relative 'file_manager'

##
# Allows the saving of Chess games
class FileSaver < FileManager
  def save_game
    puts "\nYou can save your current game.\n\n"
    list_save_files

    puts "Enter the name of the game save file, or enter blank to exit without saving.\n\n"
    file_naming_info

    file_name = gets.chomp.strip

    puts "Save was cancelled.\n\n" if file_name == ''
    save_file(file_name) unless file_name == ''
  end

  private

  def save_file(file_name)
    file = File.join(@save_directory, "#{File.basename(file_name, '.*')}.json")

    return if cancel_if_file_exists?(file)

    begin
      File.write(file, @chess.to_json)
      puts "\n#{File.basename(file)} was saved successfully.\n\n"
    rescue SystemCallError => e
      puts "Failed to save file #{file}:\n\n#{e}\n\n"
    end
  end

  def cancel_if_file_exists?(file)
    return false unless File.exist?(file)

    puts "\nThe file, '#{File.basename(file)}', already exists."
    puts "Would you like to overwrite this file?\nEnter Y to overwrite, N to cancel:\n\n"

    loop do
      choice = gets.chomp.strip.upcase
      puts "\n\nFile save was cancelled.\n\n" if choice == 'N'
      return true if choice == 'N'

      return false if choice == 'Y'

      puts "\nWhat you entered is not valid, try again.\n\n"
    end
  end
end
