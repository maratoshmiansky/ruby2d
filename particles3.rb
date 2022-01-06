require "ruby2d"

set title: "Particles!"

set width: 650, height: 600

NUM_OF_POINTS_X, NUM_OF_POINTS_Y = 40, 40
X_WINDOW_OFFSET, Y_WINDOW_OFFSET = 65, 60
VIEWPORT_WIDTH = (Window.width - X_WINDOW_OFFSET * 2)
VIEWPORT_HEIGHT = (Window.height - Y_WINDOW_OFFSET * 2)
DEGS_TO_RADIANS = Math::PI / 180
ANGLE_INCR = 2
ANGLE_MULT_MAX = 4
RADIUS_MAX = 100

class Point < Square
  attr_accessor :x_init, :y_init

  def angle
    @angle ||= angle_reset
  end

  def angle_reset
    @angle = rand(0..360)
  end

  def angle_increment
    @angle = (angle + ANGLE_INCR) % 360
  end

  def x_angle_mult
    @x_angle_mult ||= x_angle_mult_reset
  end

  def x_angle_mult_reset
    @x_angle_mult = rand(2..ANGLE_MULT_MAX)
  end

  def y_angle_mult
    @y_angle_mult ||= y_angle_mult_reset
  end

  def y_angle_mult_reset
    @y_angle_mult = rand(2..ANGLE_MULT_MAX)
  end

  def radius
    @radius ||= radius_reset
  end

  def radius_reset
    @radius = rand((RADIUS_MAX / 2)..RADIUS_MAX)
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
    point.x = point.x_init + point.radius * Math.cos(point.x_angle_mult * point.angle * DEGS_TO_RADIANS)
    point.y = point.y_init + point.radius * Math.sin(point.y_angle_mult * point.angle * DEGS_TO_RADIANS)
  end
end

show
