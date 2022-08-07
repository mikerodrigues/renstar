# frozen_string_literal: true

require_relative '../api_object'

module Renstar
  module APIClient
    # Represents a day of "runtime"
    # Breaks down how much time the system spent in various states
    # like heating or cooling.
    class Runtime < APIObject
      def pp
        puts human_readable('runtimes')
      end
    end
  end
end
