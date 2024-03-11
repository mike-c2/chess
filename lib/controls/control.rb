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

  def play
    possible_moves = all_possible_moves

    loop do
      move_choice = player_move

      if possible_moves.include?(move_choice)
        move_choice.move
        break
      end

      puts 'Your move is not possible, try again.'
    end

    promote_eligible_pieces
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

  def all_possible_moves
    pieces = same_side_pieces
    possible_moves = []

    pieces.each do |piece|
      piece_moves = piece.generate_possible_moves
      possible_moves.concat(piece_moves)
    end

    possible_moves
  end

  def promote_eligible_pieces
    same_side_pieces.each(&:promote)
  end
end
