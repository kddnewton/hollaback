module Hollaback
  class Sequence
    attr_reader :befores, :afters, :main

    def initialize(&main)
      @main    = main
      @befores = []
      @afters  = []
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

    def call(target)
      befores.each { |before| before.call(target) }
      value = main.call(target)
      afters.each { |after| after.call(target) }
      value
    end
  end
end
