#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative './game'

shoots = ARGV[0]

puts Game.new(shoots).score
