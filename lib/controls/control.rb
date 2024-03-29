# frozen_string_literal: true

require_relative '../colors/color'

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

      # Player has chosen to go back to the menu
      return false unless move_choice

      next_move = possible_moves.find { |move| move == move_choice }

      next_move&.move
      break if next_move

      puts 'Your move is not possible, try again.'
    end

    pawn_clean_up

    true
  end

  def valid_moves
    all_possible_moves.reject(&:move_own_check?)
  end

  private

  def player_move
    puts "It is now #{color.capitalize}'s turn, make a move:"

    loop do
      player_input = gets.chomp.strip
      return nil if player_input.downcase == 'menu'

      move = process_player_input(player_input)

      return move if move

      puts 'Move entered is not valid, try again.  An example of a valid move: E2 E4'
    end
  end

  def process_player_input(player_input)
    first, second = player_input.split
    first_position = Position.create_with_chess_notation(first)
    second_position = Position.create_with_chess_notation(second)

    Move.create(first_position, second_position, @board)
  end

  def pawn_clean_up
    same_side_pieces.each(&:promote)
    clear_en_passants
  end

  # En Passant must happen on the very next turn,
  # or the option is forfeited
  def clear_en_passants
    opponents_side_pieces.each(&:disable_passant_vulnerable)
  end
end
