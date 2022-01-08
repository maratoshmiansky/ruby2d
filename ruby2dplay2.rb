require "ruby2d"

set width: 650, height: 600, title: "Particles!"

NUM_OF_POINTS = 100
ANGLE_DELTA = 1
DEGS_TO_RADIANS = Math::PI / 180
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60

class Point < Square
  attr_accessor :x_init, :y_init, :x_mult, :y_mult, :angle, :x_angle_mult, :y_angle_mult
end

points = []

NUM_OF_POINTS.times do
  x_init = rand(X_WINDOW_OFFSET..Window.width - X_WINDOW_OFFSET)
  y_init = rand(Y_WINDOW_OFFSET..Window.height - Y_WINDOW_OFFSET)
  points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
end

points.each do |point|
  point.x_init = point.x
  point.y_init = point.y
  point.angle = rand(0..359)
  point.x_mult = [-1, 1].sample * rand(1.0..50.0)
  point.y_mult = [-1, 1].sample * rand(1.0..50.0)
  point.x_angle_mult = rand(2..6)
  point.y_angle_mult = rand(2..6)
end

update do
  points.each do |point|
    point.angle = (point.angle + ANGLE_DELTA) % 360
    point.x = point.x_init + point.x_mult * Math.cos(point.x_angle_mult * point.angle * DEGS_TO_RADIANS)
    point.y = point.y_init + point.y_mult * Math.sin(point.y_angle_mult * point.angle * DEGS_TO_RADIANS)
  end
end

show
