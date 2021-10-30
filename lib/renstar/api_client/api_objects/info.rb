# frozen_string_literal: true

module Renstar
  module APIClient
    # An abstraction to the info hash that gets returned from the API
    # It defines getters and instance variables for each key/value pair in the
    # info response from the API for clean access.
    #
    class Info < APIObject
    end
  end
end
