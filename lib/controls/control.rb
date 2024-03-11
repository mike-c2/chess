# frozen_string_literal: true

require_relative '../board/board'
require_relative '../colors/color'
require_relative '../positionals/move'

##
# Manages a player's turn
# This is an abstract class.
class Control
  include Color

  def initialize(board)
    @board = board
  end

  def play?
    possible_moves = valid_moves
    return false if possible_moves.empty?

    loop do
      move_choice = player_move

      next_move = possible_moves.find { |move| move == move_choice }

      next_move&.move
      break if next_move

      puts 'Your move is not possible, try again.'
    end

    promote_eligible_pieces

    true
  end

  def valid_moves
    all_possible_moves.reject(&:move_own_check?)
  end

  private

  def player_move
    puts "It is now #{color.capitalize}'s turn, make a move:"

    loop do
      first, second = gets.chomp.strip.split
      first_position = Position.create_with_chess_notation(first)
      second_position = Position.create_with_chess_notation(second)

      move = Move.create(first_position, second_position, @board)

      return move if move

      puts 'Move entered is not valid, try again.  An example of a valid move: E2 E4'
    end
  end

  def promote_eligible_pieces
    same_side_pieces.each(&:promote)
  end
end
