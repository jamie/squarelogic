require 'rubygems'
require 'bundler/setup'

require 'tesseract'
require 'RMagick'
require 'pp'

$LOAD_PATH << './lib'
require 'square_logic'
require 'scanner'

# Very specific screencap offset, running game in a windows VM offset from
# the corner of my screen.
SCREEN_SIZE = [1280, 800]
SCREEN_OFFSET = [70, 160] # from top left
crop = [SCREEN_SIZE.join('x'), SCREEN_OFFSET.join('+')].join('+')

size = ARGV.shift || 4

loop do
  `screencapture screen.png`
  `convert screen.png -crop #{crop} crop.png`

  board = Scanner.new("crop.png", size)

  solver = SquareLogic.new(size)
  board.groups.each do |group|
    solver.send group[:op], group[:total], *group[:cells]
  end

  puts
  puts
  solver.print! solver.solve
  puts
  puts

  sleep 5
end

# TODO: https://github.com/BlueM/cliclick for actually clicking the numbers
