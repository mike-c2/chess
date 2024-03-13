# frozen_string_literal: true

require 'json'

require_relative 'controls/black_control'
require_relative 'controls/white_control'
require_relative 'controls/ai_controls/computer_black_control'
require_relative 'controls/ai_controls/computer_white_control'
require_relative 'game_info'

##
# Runs the chess game
class Chess
  attr_reader :board, :white_control, :black_control, :active_control

  def initialize(board)
    @board = board
    @human_white = WhiteControl.new(@board)
    @human_black = BlackControl.new(@board)
    @computer_white = ComputerWhiteControl.new(@board)
    @computer_black = ComputerBlackControl.new(@board)

    @white_control = @human_white
    @black_control = @human_black

    @active_control = @white_control
  end

  def play_game
    GameInfo.display

    loop do
      break unless move_made?
    end

    end_game
  end

  def end_game
    no_white_moves = @white_control.valid_moves.empty?
    no_black_moves = @black_control.valid_moves.empty?
    white_in_check = @white_control.in_check?
    black_in_check = @black_control.in_check?

    if no_white_moves && white_in_check then puts 'Checkmate! Black won the game'
    elsif no_black_moves && black_in_check then puts 'Checkmate! White won the game'
    elsif no_white_moves || no_black_moves then puts 'The game ended in a stalemate'
    end
  end

  def move_made?
    board.display
    move_made = @active_control.play?
    puts 'Check!' if @active_control.opponent_in_check?

    return false unless move_made

    next_turn

    true
  end

  def blacks_turn
    @active_control = @black_control
  end

  def whites_turn
    @active_control = @white_control
  end

  def next_turn
    if @active_control.white?
      blacks_turn
      return
    end

    whites_turn
  end

  def turn(color)
    color = color.chomp.strip.downcase

    whites_turn if color == 'white'
    blacks_turn if color == 'black'
  end

  def human_vs_human
    game_mode(@human_white, @human_black)
  end

  def human_vs_computer_white
    game_mode(@computer_white, @human_black)
  end

  def human_vs_computer_black
    game_mode(@human_white, @computer_black)
  end

  def to_json(*_args)
    pieces = board.to_h

    { 'turn' => @active_control.color,
      'pieces' => pieces }.to_json
  end

  private

  def game_mode(white_control, black_control)
    @white_control = white_control
    @black_control = black_control

    # Double next_turn will fix a stale active_control
    next_turn
    next_turn
  end
end
