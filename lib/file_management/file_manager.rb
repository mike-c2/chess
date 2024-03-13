# frozen_string_literal: true

##
# Provides common functionality for
# saving and loading Chess games
class FileManager
  def initialize(chess)
    @chess = chess
    @save_directory = File.join(__dir__, '../../saved_games')
  end

  def list_save_files
    create_save_directory
    puts "\nHere are the files currently in the Game Save Directory:\n\n"
    puts Dir.entries(@save_directory)
    puts "\n\n"
  end

  private

  def create_save_directory
    FileUtils.mkdir_p(@save_directory)
  end

  def file_naming_info
    puts 'Any directory paths or extensions you enter will be ignored,'
    puts "i.e. entering /somepath/my_file.xml' is the same as entering 'my_file'."
    puts "Extension '.json' will automatically be appended to the file name.\n\n"
  end
end
