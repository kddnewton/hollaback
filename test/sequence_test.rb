require 'test_helper'

class SequenceTest < Minitest::Test
  def test_addition_bad_argument
    sequence = Hollaback::Sequence.new { puts 'main' }
    assert_raises(ArgumentError) { sequence + Object.new }
  end

  def test_addition
    chain = Hollaback::Chain.new
    chain.before(:say_hello)
    sequence_a = chain.compile

    chain = Hollaback::Chain.new
    chain.after(:say_goodbye)
    sequence_b = chain.compile { puts 'main' }

    stdout, = capture_io { (sequence_a + sequence_b).call(Callbacker.new('Kevin')) }
    assert_equal %w[hello main goodbye-Kevin], stdout.split("\n")
  end
end
