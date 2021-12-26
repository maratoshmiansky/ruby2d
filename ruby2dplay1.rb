require 'ruby2d'

set title: "Lines play"

num_of_lines = 1000
lines = []

num_of_lines.times do
  x_init = rand(0..640)
  y_init = rand(0..480)
  x_offset = x_init + rand(-1..1)
  y_offset = y_init + rand(-1..1)
  lines << Line.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, color: 'random')
end

two_pi = 2 * Math::PI
angle = 0
x_mult = 6
y_mult = x_mult

update do
  lines.each do |line|
    angle_mult = rand(0.001..0.01)
    angle_incr = angle_mult * Math::PI / 180
    angle += angle_incr
    angle %= two_pi
    x_move = x_mult * Math.cos(angle)
    y_move = y_mult * Math.sin(angle)
    # x_move_mult, y_move_mult = rand, rand
    line.x1 += x_move
    line.y1 += y_move
    line.x2 += x_move
    line.y2 += y_move
  end
end

show
