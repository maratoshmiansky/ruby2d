require "ruby2d"

set width: 650, height: 600, title: "Particles!"

TWO_PI = 2 * Math::PI
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR_MULT = 0.0003

num_of_lines = 1000
lines = []

num_of_lines.times do
  x_init = rand(0..Window.width)
  y_init = rand(0..Window.height)
  x_offset = x_init + 1
  y_offset = y_init + 1
  lines << Line.new(x1: x_init, y1: y_init, x2: x_offset, y2: y_offset, color: "white")
end

angle = 0
angle_incr = ANGLE_INCR_MULT * DEGS_TO_RADIANS
x_sign, y_sign = 1, 1

update do
  lines.each do |line|
    x_mult = rand(1..20)
    y_mult = rand(1..20)
    x_angle_mult = rand(1..3)
    y_angle_mult = rand(1..3)
    angle += angle_incr
    angle %= TWO_PI
    x_move = x_mult * Math.cos(x_angle_mult * angle)
    y_move = y_mult * Math.sin(y_angle_mult * angle)

    (line.x1 + x_move).between?(0, Window.width) ? x_sign = 1 : x_sign = -1
    (line.y1 + y_move).between?(0, Window.height) ? y_sign = 1 : y_sign = -1

    line.x1 += x_sign * x_move
    line.x2 += x_sign * x_move
    line.y1 += y_sign * y_move
    line.y2 += y_sign * y_move
  end
end

show
