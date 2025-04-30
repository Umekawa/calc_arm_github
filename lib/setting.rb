# frozen_string_literal: true

require 'dotenv'
require_relative 'plan/enterprise'
require_relative 'plan/free'
require_relative 'plan/free_organization'
require_relative 'plan/pro'
require_relative 'plan/team'

Dotenv.load

class Setting
  def initilized; end

  def armnizing_repositries
    ENV['ARMNIZING_REPOSITRIES'].split(',')
  end

  def armnizing_files
    ENV['ARMNIZING_FILES'].split(',').map do |file|
      ".github/workflows/#{file}"
    end
  end

  def target_month
    ENV.fetch('TARGET_MONTH', nil)
  end

  def already_armnized_repositries
    ENV['ALREADY_ARMNIZED_REPOSITRIES'].split(',')
  end

  def already_armnized_files
    ENV['ALREADY_ARMNIZED_FILES'].split(',').map do |file|
      ".github/workflows/#{file}"
    end
  end

  def file_name
    ENV.fetch('CSV_FILE_NAME', nil)
  end

  def plan
    case ENV.fetch('PLAN_NAME', nil)
    when 'Free'
      ::Plan::Free.new
    when 'Pro'
      ::Plan::Pro.new
    when 'Free for organizations'
      ::Plan::FreeOrganization.new
    when 'Team'
      ::Plan::Team.new
    when 'Enterprise Cloud'
      ::Plan::Enterprise.new
    else
      raise "Invalid plan #{ENV.fetch('PLAN_NAME',
                                      nil)}. Please set one of the following: Free, Pro, Free for organizations, GitHub Team, Enterprise Cloud"
    end
  end
end
