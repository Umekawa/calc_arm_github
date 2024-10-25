# frozen_string_literal: true

require_relative 'base'

module Plan
  class Free < Base
    def free_action_minutes
      2000
    end

    def free_storage_megabytes
      500
    end
  end
end
