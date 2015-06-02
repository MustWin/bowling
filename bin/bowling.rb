#!/usr/bin/env ruby
#
require 'bowling'

game = Bowling::Game.new()
game.play!(ARGV)
puts game.to_s

