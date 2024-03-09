# frozen_string_literal: true

require_relative 'color'

##
# This will add the color White to an object.
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
    other.black?
  end

  def black?
    false
  end

  def white?
    true
  end
end
