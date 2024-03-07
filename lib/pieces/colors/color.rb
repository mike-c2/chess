# frozen_string_literal: true

##
# This will implement color to an object.
# This module actually has no color, the
# child modules will define their own colors.
#
# Objects can be either white or black.
module Color
  BLACK = 'black'
  WHITE = 'white'
  NO_COLOR = 'none'
  WHITE_FONT_COLOR = "\e[37m"
  BLACK_FONT_COLOR = "\e[30m"

  def color
    NO_COLOR
  end

  def font_color
    ''
  end

  def same_side?(_other)
    false
  end

  def opponents_side?(_other)
    false
  end
end
