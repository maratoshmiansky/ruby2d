require 'ruby2d'

set title: "Lines play"

lines = []

1000.times do
  x_init = rand(0..640)
  y_init = rand(0..480)
  x_offset = x_init + rand(-1..1)
  y_offset = y_init + rand(-1..1)
  lines << Line.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, color: 'random')
end

update do
  lines.each do |line|
    x_move = rand(-1..1)
    y_move = rand(-1..1)
    line.x1 += x_move
    line.y1 += y_move
    line.x2 += x_move
    line.y2 += y_move
    # line.color = 'random'
  end
end

show
