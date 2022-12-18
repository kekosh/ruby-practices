#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './show'

opt = OptionParser.new
options = { all: false, long: false, reverse: false }

opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:long] = v }
opt.on('-r') { |v| options[:reverse] = v }

opt.parse! { ARGV }

puts Show.new(options).contents_list
