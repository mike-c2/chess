# frozen_string_literal: true

require_relative 'position'
require_relative 'universal_default_board'

##
# This represents a move in Chess.
#
# It consists of a start position and an end position.
# The static factory method must be used to create new
# objects (constructor is private); this ensures that
# the move is valid.  A valid move at this level means
# that the start and end are not the same.
#
# Instantiated objects of this class are immutable.
class Move
  attr_reader :positions, :board

  extend UniversalDefaultBoard

  def initialize(positions, board)
    @positions = positions
    @board = board
  end

  def ==(other)
    positions == other.positions
  end

  private_class_method :new

  class << self
    def create(positions, board = default_board)
      return nil unless positions in [Position, Position]

      return nil if positions.first == positions.last

      new(positions, board)
    end
  end
end
