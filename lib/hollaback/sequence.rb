# frozen_string_literal: true

module Hollaback
  # An object that contains a sequence of callbacks along with a main execution
  # function
  class Sequence
    attr_reader :befores, :afters, :main

    def initialize(args = {}, &main)
      @main    = main
      @befores = args.fetch(:befores, [])
      @afters  = args.fetch(:afters, [])
    end

    def before(&before)
      befores << before
      self
    end

    def after(&after)
      afters << after
      self
    end

    def around(&around)
      Sequence.new do |target|
        around.call(target) { call(target) }
      end
    end

    def call(target = nil)
      befores.each { |before| before.call(target) }

      main.call(target).tap do
        afters.each { |after| after.call(target) }
      end
    end
  end
end
