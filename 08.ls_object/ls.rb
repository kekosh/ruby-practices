#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
options = { all: false, list: false, reverse: false }

opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:list] = v }
opt.on('-r') { |v| options[:reverse] = v }

opt.parse! { ARGV }
