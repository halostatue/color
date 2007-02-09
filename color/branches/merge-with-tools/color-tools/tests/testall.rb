#!/usr/bin/env ruby
#--
# Colour management with Ruby.
#
# Copyright 2005 Austin Ziegler
#   http://rubyforge.org/ruby-pdf/
#
#   Licensed under a MIT-style licence.
#
# $Id: testall.rb 153 2007-02-07 02:28:41Z austin $
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0

puts "Checking for test cases:"
Dir['test_*.rb'].each do |testcase|
  puts "\t#{testcase}"
  require testcase
end
puts " "
