# frozen_string_literal: true

require "test_helper"

class HollabackTest < Minitest::Test
  def test_version
    refute_nil ::Hollaback::VERSION
  end

  def test_hollaback
    stdout, = capture_io { sequence.call(Callbacker.new("Kevin")) }
    assert_equal %w[hello before main after goodbye-Kevin], stdout.split("\n")

    stdout, = capture_io { sequence.call(Callbacker.new("Meaghan")) }
    assert_equal %w[hello before main after goodbye-Meaghan], stdout.split("\n")
  end

  def test_no_callbacks
    chain = Hollaback::Chain.new
    sequence = chain.compile { puts "main" }

    stdout, = capture_io { sequence.call(Callbacker.new("Jon")) }
    assert_equal "main\n", stdout
  end

  def test_raises_on_invalid_arg
    chain = Hollaback::Chain.new
    chain.before Object.new

    assert_raises ArgumentError do
      chain.compile { puts "main" }
    end
  end

  def test_allows_calling_without_context
    counter = 0
    chain = Hollaback::Chain.new

    chain.before { counter += 1 }
    chain.after { counter += 1 }

    chain.compile { counter += 1 }.call

    assert_equal 3, counter
  end

  private

  def sequence
    @sequence ||=
      begin
        chain = Hollaback::Chain.new

        chain.before :say_hello
        chain.before { say { "before" } }

        chain.after { say { "after" } }
        chain.after(:say_goodbye)

        chain.around(:say)
        chain.compile { puts "main" }
      end
  end
end
