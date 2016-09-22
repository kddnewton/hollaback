require 'test_helper'

class ChainTest < Minitest::Test
  def test_empty?
    chain = Hollaback::Chain.new
    assert chain.empty?

    chain.before :foobar
    refute chain.empty?
  end
end
