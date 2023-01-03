# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  add_filter "/test/"
  enable_coverage :branch
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hollaback"

require "minitest/autorun"

class Callbacker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def say(&_block)
    puts yield
  end

  def say_hello
    puts "hello"
  end

  def say_goodbye
    puts "goodbye-#{name}"
  end
end
