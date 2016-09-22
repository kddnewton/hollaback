require 'test_helper'

class ChainTest < Minitest::Test
  def test_addition
    chain = Hollaback::Chain.new
    chain.before :foo

    other = Hollaback::Chain.new
    other.after :bar
    chain += other

    assert_equal %i[foo bar], chain.callbacks.map(&:executable)
  end

  def test_empty?
    chain = Hollaback::Chain.new
    assert chain.empty?

    chain.before :foobar
    refute chain.empty?
  end
end
