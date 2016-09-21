require 'test_helper'

class HollabackTest < Minitest::Test
  class Callbacker
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def say(&block)
      puts yield
    end

    def say_hello
      puts 'hello'
    end

    def say_goodbye
      puts "goodbye-#{name}"
    end
  end

  def test_version
    refute_nil ::Hollaback::VERSION
  end

  def test_hollaback
    stdout, = capture_io { sequence.call(Callbacker.new('Kevin')) }
    assert_equal %w[hello before main after goodbye-Kevin], stdout.split("\n")

    stdout, = capture_io { sequence.call(Callbacker.new('Meaghan')) }
    assert_equal %w[hello before main after goodbye-Meaghan], stdout.split("\n")
  end

  private

  def sequence
    @sequence ||= begin
      chain = Hollaback::Chain.new

      chain.before :say_hello
      chain.before { say { 'before' } }

      chain.after { say { 'after' } }
      chain.after(:say_goodbye)

      chain.around(:say)
      chain.compile { puts 'main' }
    end
  end
end
