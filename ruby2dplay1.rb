require "ruby2d"

set width: 600, height: 600, title: "Particles!"

DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR_MULT = 0.0005

num_of_points = 1000
points = []

num_of_points.times do
  x_init = rand(0.0..Window.width)
  y_init = rand(0.0..Window.height)
  points << Square.new(x: x_init, y: y_init, size: 1, color: "white")
end

angle = 0
x_sign, y_sign = 1, 1

update do
  points.each do |point|
    x_mult = rand(1.0..50.0)
    y_mult = rand(1.0..50.0)
    x_angle_mult = rand(1.0..2.0)
    y_angle_mult = rand(1.0..2.0)
    angle = (angle + ANGLE_INCR_MULT) % 360
    x_move = x_mult * Math.cos(x_angle_mult * angle * DEGS_TO_RADIANS)
    y_move = y_mult * Math.sin(y_angle_mult * angle * DEGS_TO_RADIANS)
    (point.x + x_move).between?(0, Window.width) ? x_sign = 1 : x_sign = -1
    (point.y + y_move).between?(0, Window.height) ? y_sign = 1 : y_sign = -1
    point.x += x_sign * x_move
    point.y += y_sign * y_move
  end
end

show
