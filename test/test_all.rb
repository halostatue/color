#!/usr/bin/env ruby
#--
# Color
# Colour management with Ruby
# http://rubyforge.org/projects/color
#   Version 1.5.0
#
# Licensed under a MIT-style licence. See Licence.txt in the main
# distribution for full licensing information.
#
# Copyright (c) 2005 - 2010 Austin Ziegler and Matt Lyon
#++

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib") if __FILE__ == $0

$stderr.puts "Checking for test cases:"

Dir[File.join(File.dirname($0), 'test_*.rb')].each do |testcase|
  next if File.basename(testcase) == File.basename(__FILE__)
  $stderr.puts "\t#{testcase}"
  load testcase
end
$stderr.puts " "
