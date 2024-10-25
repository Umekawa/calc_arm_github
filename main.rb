# frozen_string_literal: true

require_relative 'lib/setting'
require_relative 'lib/price'

def main
  Price.new(Setting.new).output
end
main
