# frozen_string_literal: true

require_relative 'base'

module Plan
  class Pro < Base
    def free_action_minutes
      3000
    end

    def free_storage_megabytes
      1000
    end
  end
end
