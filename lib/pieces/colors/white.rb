# frozen_string_literal: true

require_relative 'color'

##
# This will add the color White to a chess piece.
module White
  include Color

  def color
    WHITE
  end

  def font_color
    WHITE_FONT_COLOR
  end

  def same_side?(other)
    color == other.color
  end

  def opponents_side?(other)
    other.color == BLACK
  end
end
