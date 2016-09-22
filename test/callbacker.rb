class Callbacker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def say(&_block)
    puts yield
  end

  def say_hello
    puts 'hello'
  end

  def say_goodbye
    puts "goodbye-#{name}"
  end
end
