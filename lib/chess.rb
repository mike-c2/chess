# frozen_string_literal: true

require_relative 'controls/black_control'
require_relative 'controls/white_control'
require_relative 'board/board_layout'
require_relative 'game_info'

##
# Runs the chess game
class Chess
  attr_reader :board, :white_control, :black_control, :active_control

  def initialize(board)
    @board = board
    @white_control = WhiteControl.new(@board)
    @black_control = BlackControl.new(@board)

    @active_control = @white_control
  end

  def play_game
    GameInfo.display

    loop do
      board.display
      active_control.play
      next_turn
    end
  end

  def blacks_turn
    @active_control = black_control
  end

  def whites_turn
    @active_control = white_control
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
end
