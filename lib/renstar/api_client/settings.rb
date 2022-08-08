# frozen_string_literal: true

module Renstar
  module APIClient
    # Interface to the "Settings" portion of the API
    # This allows you to set any settings like Home/Away, or enabling the
    # schedule
    #
    module Settings
      def settings(options = {})
        post('settings', options)
      end
    end
  end
end
