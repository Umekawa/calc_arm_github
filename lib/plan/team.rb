# frozen_string_literal: true

require_relative 'base'

module Plan
  class Team < Base
    def free_action_minutes
      3000
    end

    def free_storage_megabytes
      2000
    end
  end
end
