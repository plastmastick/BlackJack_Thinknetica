# frozen_string_literal: true

module Validation
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate!(attr, validates = {})
      validates.each { |option, param| send option.to_sym, send(attr), param }
    end

    def presence(attr, _param)
      raise "Attribute is nil! Attr: #{attr}" if attr.nil?
    end

    def comparison_min(attr, param)
      raise "Value (#{attr}) less then #{param}! Attr: #{attr}" if attr < param
    end

    def comparison_min_length(attr, param)
      raise "Length less then #{param}! Attr: #{attr}" if attr.length < param
    end

    def zero(attr, _param)
      raise "Attribute equal zero! Attr: #{attr}" if attr.zero?
    end
  end
end
