# frozen_string_literal: true

##
# This provides a way for classes to set one
# default board that will be shared across all
# of its child classes.
#
# If this is included or extended to more than
# once class, then they all will share the same
# default value, i.e. if this default changes
# in one place, then it changes everywhere.
module UniversalDefaultBoard
  @@default_board = nil

  def default_board
    @@default_board
  end

  def default_board=(new_default)
    @@default_board = new_default
  end
end
