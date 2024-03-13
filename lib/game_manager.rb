# frozen_string_literal: true

require_relative 'board/board'
require_relative 'board/board_layout'
require_relative 'positionals/move'
require_relative 'file_management/file_saver'
require_relative 'file_management/file_loader'
require_relative 'chess'

##
# Runs the Chess game
class GameManager
  MENU = <<~MENU

                    The Chess Game Main Menu

    Here are the options that you can select:

      P - Play the game in 2-player mode
      W - Play the game against computer (you play white)
      B - Play the game against the computer (you play black)
      R - Reset the game board
      S - Save the current game
      L - Load an existing saved game
      Q - Quit the game
      E - Exit the game

    Enter the letter of the option you that you would like.

    Input is not case sensitive and only the first letter of
    what you enter matters.

    The first 3 options will use the same board, reset he game
    first if you want to start fresh.

    Q and E do the samething

  MENU

  def initialize
    @board = Board.new
    @chess = Chess.new(@board)
    @board_layout = BoardLayout.new(@chess)
    @file_saver = FileSaver.new(@chess)
    @file_loader = FileLoader.new(@chess)

    Move.default_board = @board
  end

  def start
    @board_layout.setup

    selection = ''

    loop do
      # displaying the full menu after reset is a little annoying
      display_menu unless selection == 'R'

      selection = player_input

      break if %w[Q E].include?(selection)

      process_selection(selection)
    end
  end

  def process_selection(selection)
    game_mode_selection(selection) if %w[P W B].include?(selection)
    reset if selection == 'R'

    game_file_selection(selection) if %w[S L].include?(selection)
  end

  def game_mode_selection(selection)
    case selection
    when 'P' then @chess.human_vs_human
    when 'W' then @chess.human_vs_computer_black
    when 'B' then @chess.human_vs_computer_white
    end

    @chess.play_game
  end

  def reset
    @board.clear
    @board_layout.setup

    puts "\nThe game board has been reset\n\n"
  end

  def game_file_selection(selection)
    @file_saver.save_game if selection == 'S'
    @file_loader.load_game if selection == 'L'
  end

  def player_input
    valid_options = %w[P W B R S L Q E]

    loop do
      selection = gets.chomp.strip[0].upcase
      return selection if valid_options.include?(selection)

      puts 'What you entered is not valid, try again'
    end
  end

  def display_menu
    puts MENU
  end
end

manager = GameManager.new

manager.start
