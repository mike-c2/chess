# frozen_string_literal: true

##
# This represents a position on the Chess board.
# The position is represented both in Chess Notation (A1)
# and Array Notation [0, 0].  The static factory methods
# must be used to create new objects; this ensures that
# the position is valid.
#
# Instantiated objects of this class are immutable.
class Position
  attr_reader :array_notation, :chess_notation

  def initialize(array_notation, chess_notation)
    @array_notation = array_notation
    @chess_notation = chess_notation
  end

  def ==(other)
    array_notation == other.array_notation
  end

  def delta(other)
    return nil unless other.is_a?(self.class)

    row_delta = array_notation.first - other.array_notation.first
    column_delta = array_notation.last - other.array_notation.last

    [row_delta, column_delta]
  end

  def add_offset(array_offset)
    return nil unless array_offset in [Integer, Integer]

    new_row = array_notation.first + array_offset.first
    new_column = array_notation.last + array_offset.last

    self.class.create_with_array_notation([new_row, new_column])
  end

  private_class_method :new

  class << self
    def create_with_array_notation(array_notation)
      return nil unless correct_array_notation?(array_notation)

      new(array_notation, convert_to_chess_notation(array_notation))
    end

    def create_with_chess_notation(chess_notation)
      array_notation = convert_to_array_notation(chess_notation)

      create_with_array_notation(array_notation)
    end

    private

    def convert_to_array_notation(chess_notation)
      chess_notation = chess_notation.to_s.chomp.strip.upcase

      return nil unless /^[A-H][1-8]$/.match(chess_notation)

      column_coordinate = chess_notation[0].ord - 'A'.ord
      row_coordinate = chess_notation[1].to_i - 1

      array_notation = [row_coordinate, column_coordinate]

      return nil unless correct_array_notation?(array_notation)

      array_notation
    end

    def convert_to_chess_notation(array_notation)
      return nil unless correct_array_notation?(array_notation)

      number = array_notation.first + 1
      letter = (array_notation.last + 'A'.ord).chr

      "#{letter}#{number}"
    end

    def correct_array_notation?(array_notation)
      return false unless array_notation in [Integer, Integer]

      array_notation.all? { |coordinate| (0..7).include?(coordinate) }
    end
  end
end
