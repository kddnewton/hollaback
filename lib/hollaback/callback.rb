# frozen_string_literal: true

module Hollaback
  # A callback that can be executed later
  class Callback
    attr_reader :type, :executable

    def initialize(type, execute = nil, &block)
      @type       = type
      @executable = (execute || block)
    end

    def build
      case executable
      when Symbol
        ->(target, &block) { target.send(executable, &block) }
      when Proc
        ->(target) { target.instance_eval(&executable) }
      else
        raise ArgumentError, "Invalid callback argument: #{executable.inspect}"
      end
    end
  end
end
