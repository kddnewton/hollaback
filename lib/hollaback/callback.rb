module Hollaback
  class Callback
    attr_reader :type, :executable

    def initialize(type, execute = nil, &block)
      @type       = type
      @executable = (execute ? execute : block)
    end

    def build
      case executable
      when Symbol
        -> (target, &block) { target.send(executable, &block) }
      when Proc
        -> (target) { target.instance_eval(&executable) }
      end
    end
  end
end
