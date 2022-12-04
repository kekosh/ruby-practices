#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './objects'
require_relative './show'
require_relative './information'

opt = OptionParser.new
options = { all: false, list: false, reverse: false }

opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:list] = v }
opt.on('-r') { |v| options[:reverse] = v }

opt.parse! { ARGV }

object_list = if options[:list]
                Information.new(Objects.new(options).object_list).return_detail_info_and_permissions
              else
                Objects.new(options).object_list
              end

if options[:list]
  puts Show.new(object_list).show_object_detail
else
  puts Show.new(object_list).show_object_list
end
