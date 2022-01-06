require "ruby2d"

set title: "Particles!"

set width: 650, height: 600

NUM_OF_POINTS_X, NUM_OF_POINTS_Y = 10, 10
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
X_MOVE_BOUND, Y_MOVE_BOUND = 1.0, 1.0
X_SPEED, Y_SPEED = 0.01, 0.01
X_MAX_SPEED, Y_MAX_SPEED = 2.0, 2.0
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR = 6
RADIUS = 10
# RADIUS_INCR = 1.5
# X_ANGLE_MULT, Y_ANGLE_MULT = 3, 3

class Point < Square
  attr_accessor :x_init, :y_init

  def angle
    @angle ||= angle_reset
  end

  def angle_increment
    @angle = (angle + ANGLE_INCR) % 360
  end

  def angle_reset
    @angle = rand(0..360)
  end
end

points = []

# set up point grid
NUM_OF_POINTS_X.times do |i|
  NUM_OF_POINTS_Y.times do |j|
    x_init = X_WINDOW_OFFSET + (i + 0.5) * VIEWPORT_WIDTH / NUM_OF_POINTS_X
    y_init = Y_WINDOW_OFFSET + (j + 0.5) * VIEWPORT_HEIGHT / NUM_OF_POINTS_Y
    # puts "x: #{x_init}, y: #{y_init}"
    points << Point.new(x: x_init, y: y_init, size: 1, color: "white")
  end
end

# memorize initial positions of each point
points.each do |point|
  point.x_init = point.x
  point.y_init = point.y
end

update do
  points.each do |point|
    point.angle_increment
    point.x = point.x_init + RADIUS * Math.cos(point.angle * DEGS_TO_RADIANS)
    point.y = point.y_init + RADIUS * Math.sin(point.angle * DEGS_TO_RADIANS)
  end
end

show
