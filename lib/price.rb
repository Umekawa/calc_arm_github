# frozen_string_literal: true

require 'csv'

class Price
  def initialize(setting)
    @file_name = setting.file_name
    @target_month = setting.target_month
    @plan = setting.plan
    @armnizing_repositries = setting.armnizing_repositries
    @already_armnized_repositries = setting.already_armnized_repositries
    initialize_price_quantity
    aggregate
  end

  def initialize_price_quantity
    @other_price = 0
    @storage_price = 0
    @amd_price = 0
    @amd_quantity = 0
    @armnizing_price = 0
    @armnizing_quantity = 0
    @already_armed_price = 0
    @arm_quantity = 0
    @already_arm_price = 0
    @already_arm_quantity = 0
  end

  def output
    puts "Target month: #{@target_month}"
    puts "Armnizing repositries: #{@armnizing_repositries}"
    puts "Amd: #{@amd_quantity} minutes and #{fixed_amd_price}USD"
    puts "Arm(Already): #{@arm_quantity} minutes and #{@already_armed_price.round(2)}USD"
    puts "Arm(new): #{@armnizing_quantity} minutes and #{@armnizing_price.round(2)}USD"
    puts "Storage price: #{fixed_storage_price.round(2)}USD"
    puts "Other price: #{@other_price.round(2)}USD"
    puts "Monthly price: #{monthly_price}USD"
    puts "Armnized Monthly price: #{armnizing_price}USD"
  end

  def monthly_price
    (action_price+ fixed_storage_price + @other_price).round(2)
  end

  def armnizing_price
    (armnizing_action_price + fixed_storage_price + @other_price).round(2)
  end

  def action_price
    @already_armed_price + @plan.fixed_minutes_price(@amd_price + (@armnizing_price * 8 / 5)) + fixed_amd_price 
  end

  def armnizing_action_price
    @already_armed_price + @armnizing_price + fixed_amd_price
  end

  def fixed_amd_price
    @plan.fixed_minutes_price(@amd_price)
  end

  def fixed_storage_price
    @plan.fixed_storage_price(@storage_price)
  end

  def aggregate
    CSV.foreach(@file_name, headers: true) do |row|
      next unless row['Date'].start_with?(@target_month)

      row_price = row['Quantity'].to_f * row['Price Per Unit ($)'].to_f
      row_quantity = row['Quantity'].to_f

      if row['Product'].eql?('Shared Storage')
        @storage_price += row_price
      elsif row['Product'].eql?('Actions')
        if @armnizing_repositries.include?(row['Repository Slug'])
          @armnizing_price += row_price * 5 / 8
          @armnizing_quantity += row_quantity
        elsif @already_armnized_repositries.include?(row['Repository Slug'])
          @arm_quantity += row_quantity
          @already_armed_price += row_price
        else
          @amd_quantity += row_quantity
          @amd_price += row_price
        end
      else
        @other_price += row_price
      end
    end
  end
end
