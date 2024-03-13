# frozen_string_literal: true

require 'json'

require_relative 'file_manager'
require_relative '../board/piece_maker'

##
# Allows loading saved Chess games from files
class FileLoader < FileManager
  def initialize(chess)
    super(chess)

    @board = @chess.board
    @piece_maker = PieceMaker.new(@board)
  end

  def load_game
    list_save_files

    puts "Enter the name of the file you want to load from, or enter blank to exit without loading.\n\n"
    file_naming_info

    file_name = gets.chomp.strip

    puts "Load was cancelled.\n\n" if file_name == ''
    load_file(file_name) unless file_name == ''
  end

  private

  def load_file(file_name)
    file = File.join(@save_directory, "#{File.basename(file_name, '.*')}.json")

    begin
      game_hash = JSON.parse(File.read(file))
      board_setup(game_hash)
      puts "\n#{File.basename(file)} was loaded successfully.\n\n"
    rescue SystemCallError, JSON::ParserError, NoMethodError => e
      puts "Failed to load file #{file}:\n\n#{e}\n\n"
    end
  end

  def board_setup(game_hash)
    turn_color = game_hash['turn']
    pieces = game_hash['pieces']

    @board.clear

    pieces.each do |piece_hash|
      converted_hash = convert_hash(piece_hash)
      piece_created = @piece_maker.created?(**converted_hash)

      puts "WARNING: Failed to create piece:\n  #{piece_hash}\n\n" unless piece_created
    end

    @chess.turn(turn_color)
  end

  def convert_hash(piece_hash)
    new_hash = { color: piece_hash['color'],
                 type: piece_hash['piece_type'],
                 location: piece_hash['position'],
                 move_count: piece_hash['move_count'],
                 passant_vulnerable: piece_hash['passant_vulnerable'] }

    new_hash.delete(:passant_vulnerable) if new_hash[:passant_vulnerable].nil?
    new_hash
  end
end
