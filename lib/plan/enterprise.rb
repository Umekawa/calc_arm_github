# frozen_string_literal: true

require_relative 'base'

module Plan
  class Enterprise < Base
    def free_action_minutes
      50_000
    end

    def free_storage_megabytes
      50_000
    end
  end
end
