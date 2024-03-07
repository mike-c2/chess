# frozen_string_literal: true

require_relative 'color'

##
# This will add the color Black to an object.
module Black
  include Color

  def color
    BLACK
  end

  def font_color
    BLACK_FONT_COLOR
  end

  def same_side?(other)
    color == other.color
  end

  def opponents_side?(other)
    other.white?
  end

  def black?
    true
  end

  def white?
    false
  end
end
