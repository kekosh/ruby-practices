#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './content_printer'

opt = OptionParser.new
options = { all: false, long: false, reverse: false }

opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:long] = v }
opt.on('-r') { |v| options[:reverse] = v }

opt.parse! { ARGV }

puts ContentPrinter.new(options).contents_list
